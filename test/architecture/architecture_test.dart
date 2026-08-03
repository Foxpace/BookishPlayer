import 'dart:io';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/source/line_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;

const _maxFileLines = 300;
const _maxClassLines = 300;
const _maxCallableLines = 100;
const _maxBuildLines = 180;

void main() {
  test('handwritten Dart sources stay within maintainability limits', () {
    final violations = <String>[];
    for (final file in _dartFiles()) {
      final content = file.readAsStringSync();
      final lineCount = '\n'.allMatches(content).length + 1;
      if (lineCount > _maxFileLines) {
        violations.add('${file.path}: $lineCount file lines');
      }
      final parsed = parseString(content: content, path: file.path);
      parsed.unit.accept(_SizeVisitor(file.path, parsed.lineInfo, violations));
    }
    expect(violations, isEmpty, reason: violations.join('\n'));
  });

  test('imports follow the documented dependency direction', () {
    final violations = <String>[];
    for (final file in _dartFiles(rootNames: const ['lib'])) {
      final source = p.normalize(file.path);
      final content = file.readAsStringSync();
      final parsed = parseString(content: content, path: source);
      for (final directive
          in parsed.unit.directives.whereType<ImportDirective>()) {
        final uri = directive.uri.stringValue;
        if (uri == null) {
          continue;
        }
        _checkImport(source, uri, violations);
      }
      if ((content.contains('MethodChannel(') ||
              content.contains('BasicMessageChannel(')) &&
          !source.endsWith('.g.dart')) {
        violations.add(
          '$source uses a handwritten platform channel; use Pigeon instead',
        );
      }
    }
    expect(violations, isEmpty, reason: violations.join('\n'));
  });

  test('data-only classes use Freezed', () {
    final violations = <String>[];
    for (final file in _dartFiles(rootNames: const ['lib'])) {
      final parsed = parseString(
        content: file.readAsStringSync(),
        path: file.path,
      );
      parsed.unit.accept(_FreezedDataClassVisitor(file.path, violations));
    }
    expect(violations, isEmpty, reason: violations.join('\n'));
  });
}

Iterable<File> _dartFiles({List<String> rootNames = const ['lib', 'test']}) {
  return rootNames
      .expand((root) => Directory(root).listSync(recursive: true))
      .whereType<File>()
      .where((file) => file.path.endsWith('.dart'))
      .where((file) => !_isGenerated(file.path));
}

bool _isGenerated(String path) =>
    path.endsWith('.freezed.dart') ||
    path.endsWith('.g.dart') ||
    path.endsWith('injection.config.dart') ||
    path.contains('/core/localization/generated/');

void _checkImport(String source, String uri, List<String> violations) {
  final target = uri.startsWith('package:bookish_player/')
      ? p.join('lib', uri.substring('package:bookish_player/'.length))
      : uri.startsWith('.')
      ? p.normalize(p.join(p.dirname(source), uri))
      : uri;
  void reject({required bool condition, required String rule}) {
    if (condition) {
      violations.add('$source imports $uri ($rule)');
    }
  }

  final screenRoot = source.endsWith('_screen_root.dart');
  reject(
    condition: source.contains('/presentation/') && target.contains('/data/'),
    rule: 'presentation must not import data',
  );
  reject(
    condition: source.contains('/data/') && target.contains('/presentation/'),
    rule: 'data adapters must not depend on presentation',
  );
  const platformPackages = <String>{
    'audio_service',
    'file_picker',
    'just_audio',
    'path_provider',
    'sembast',
    'share_plus',
    'speech_to_text',
  };
  final packageName = uri.startsWith('package:')
      ? uri.substring('package:'.length).split('/').first
      : null;
  reject(
    condition:
        source.contains('/presentation/') &&
        platformPackages.contains(packageName),
    rule: 'presentation must access platform packages through domain ports',
  );
  reject(
    condition:
        source.contains('/presentation/') &&
        target.endsWith('core/di/injection.dart') &&
        !screenRoot,
    rule: 'only ScreenRoot may use DI',
  );
  reject(
    condition:
        source.startsWith('lib/core/di/') &&
        target.contains('lib/features/') &&
        !source.endsWith('app_module.dart') &&
        !source.endsWith('injection.config.dart'),
    rule: 'core DI may compose features only in the app module',
  );
  reject(
    condition:
        source.contains('/domain/') &&
        (target.contains('/data/') ||
            target.contains('/presentation/') ||
            uri.startsWith('package:flutter')),
    rule: 'domain must remain framework and implementation independent',
  );
  reject(
    condition:
        source.contains('/application/') &&
        (target.contains('/data/') ||
            target.contains('/presentation/') ||
            uri.startsWith('package:flutter')),
    rule: 'application may depend only on domain contracts',
  );
  reject(
    condition:
        source.startsWith('lib/core/') &&
        target.contains('lib/features/') &&
        !source.startsWith('lib/core/di/') &&
        !source.startsWith('lib/core/navigation/'),
    rule: 'core feature dependencies are limited to composition',
  );
}

class _SizeVisitor extends RecursiveAstVisitor<void> {
  _SizeVisitor(this.path, this.lines, this.violations);

  final String path;
  final LineInfo lines;
  final List<String> violations;

  int _span(AstNode node) =>
      lines.getLocation(node.end).lineNumber -
      lines.getLocation(node.offset).lineNumber +
      1;

  void _check(AstNode node, String name, int maximum) {
    final span = _span(node);
    if (span > maximum) {
      violations.add('$path: $name spans $span lines (max $maximum)');
    }
  }

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    _check(node, 'class ${node.namePart.typeName.lexeme}', _maxClassLines);
    super.visitClassDeclaration(node);
  }

  @override
  void visitMethodDeclaration(MethodDeclaration node) {
    final maximum = node.name.lexeme == 'build'
        ? _maxBuildLines
        : _maxCallableLines;
    _check(node, 'method ${node.name.lexeme}', maximum);
    super.visitMethodDeclaration(node);
  }

  @override
  void visitConstructorDeclaration(ConstructorDeclaration node) {
    _check(node, 'constructor', _maxCallableLines);
    super.visitConstructorDeclaration(node);
  }

  @override
  void visitFunctionDeclaration(FunctionDeclaration node) {
    final isTestMain = path.startsWith('test/') && node.name.lexeme == 'main';
    if (!isTestMain) {
      _check(node, 'function ${node.name.lexeme}', _maxCallableLines);
    }
    super.visitFunctionDeclaration(node);
  }
}

class _FreezedDataClassVisitor extends RecursiveAstVisitor<void> {
  _FreezedDataClassVisitor(this.path, this.violations);

  final String path;
  final List<String> violations;

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    if (_isDataOnly(node) && !_usesFreezed(node)) {
      violations.add(
        '$path: data-only class ${node.namePart.typeName.lexeme} must use Freezed',
      );
    }
    super.visitClassDeclaration(node);
  }

  bool _usesFreezed(ClassDeclaration node) => node.metadata.any(
    (annotation) => annotation.name.toSource() == 'freezed',
  );

  bool _isDataOnly(ClassDeclaration node) {
    final body = node.body;
    if (body is! BlockClassBody) {
      return false;
    }
    final fields = body.members.whereType<FieldDeclaration>().where(
      (field) => !field.isStatic,
    );
    final constructors = body.members.whereType<ConstructorDeclaration>();
    final hasConstructorData = constructors.any(
      (constructor) => constructor.parameters.parameters.isNotEmpty,
    );
    final methods = body.members.whereType<MethodDeclaration>();
    final hasBehavior = methods.any((method) => !method.isGetter);
    return (fields.isNotEmpty || hasConstructorData) && !hasBehavior;
  }
}
