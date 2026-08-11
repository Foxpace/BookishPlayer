import 'dart:io';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/source/line_info.dart';

void main(List<String> arguments) {
  final minimum = _integerOption(arguments, '--minimum=') ?? 1;
  final failureThreshold = _integerOption(arguments, '--fail-at=');
  final findings = <_Finding>[];
  final files = Directory('lib')
      .listSync(recursive: true)
      .whereType<File>()
      .where(_isHandwrittenNonUiProductionFile);

  for (final file in files) {
    final source = file.readAsStringSync();
    final parsed = parseString(content: source, path: file.path);
    parsed.unit.accept(
      _CallableVisitor(
        file.path,
        source.split('\n'),
        parsed.lineInfo,
        findings,
      ),
    );
  }

  findings.sort((left, right) {
    final runOrder = right.longestRun.compareTo(left.longestRun);
    return runOrder != 0 ? runOrder : right.lines.compareTo(left.lines);
  });
  for (final finding in findings.where((item) => item.longestRun >= minimum)) {
    stdout.writeln(
      '${finding.longestRun}\t${finding.lines}\t${finding.blankLines}\t'
      '${finding.path}\t${finding.name}',
    );
  }

  if (failureThreshold != null &&
      findings.any((item) => item.longestRun >= failureThreshold)) {
    exitCode = 1;
  }
}

int? _integerOption(List<String> arguments, String prefix) {
  for (final argument in arguments) {
    if (argument.startsWith(prefix)) {
      return int.tryParse(argument.substring(prefix.length));
    }
  }

  return null;
}

bool _isHandwrittenNonUiProductionFile(File file) {
  final path = file.path;
  final isUiComposition =
      path.contains('/ui/') ||
      path.contains('/presentation/') ||
      path.contains('/theme/') ||
      path.contains('/navigation/') ||
      path.endsWith('_root.dart') ||
      path.endsWith('_presenter.dart') ||
      path.endsWith('/bookish_app.dart');

  return path.endsWith('.dart') &&
      !isUiComposition &&
      !path.contains('/generated/') &&
      !path.endsWith('.config.dart') &&
      !path.endsWith('.g.dart') &&
      !path.endsWith('.freezed.dart');
}

class _CallableVisitor extends RecursiveAstVisitor<void> {
  _CallableVisitor(this.path, this.sourceLines, this.lineInfo, this.findings);

  final String path;
  final List<String> sourceLines;
  final LineInfo lineInfo;
  final List<_Finding> findings;

  @override
  void visitMethodDeclaration(MethodDeclaration node) {
    _record(node, node.name.lexeme);
    super.visitMethodDeclaration(node);
  }

  @override
  void visitConstructorDeclaration(ConstructorDeclaration node) {
    _record(node, node.name?.lexeme ?? 'constructor');
    super.visitConstructorDeclaration(node);
  }

  @override
  void visitFunctionDeclaration(FunctionDeclaration node) {
    _record(node, node.name.lexeme);
    super.visitFunctionDeclaration(node);
  }

  void _record(AstNode node, String name) {
    final start = lineInfo.getLocation(node.offset).lineNumber;
    final end = lineInfo.getLocation(node.end).lineNumber;
    final lines = sourceLines.sublist(start - 1, end);
    var longestRun = 0;
    var currentRun = 0;
    var blankLines = 0;

    for (final line in lines) {
      if (line.trim().isEmpty) {
        blankLines++;
        currentRun = 0;
      } else {
        currentRun++;
        if (currentRun > longestRun) {
          longestRun = currentRun;
        }
      }
    }
    findings.add(
      _Finding(
        path: path,
        name: name,
        lines: end - start + 1,
        blankLines: blankLines,
        longestRun: longestRun,
      ),
    );
  }
}

class _Finding {
  const _Finding({
    required this.path,
    required this.name,
    required this.lines,
    required this.blankLines,
    required this.longestRun,
  });

  final String path;
  final String name;
  final int lines;
  final int blankLines;
  final int longestRun;
}
