import 'dart:io';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/source/line_info.dart';

void main() {
  final builds = <({String path, String widget, int lines})>[];
  final files = Directory('lib')
      .listSync(recursive: true)
      .whereType<File>()
      .where((file) => file.path.endsWith('.dart'))
      .where(
        (file) =>
            !file.path.endsWith('.g.dart') &&
            !file.path.endsWith('.freezed.dart'),
      );

  for (final file in files) {
    final result = parseString(
      content: file.readAsStringSync(),
      path: file.path,
    );
    for (final declaration
        in result.unit.declarations.whereType<ClassDeclaration>()) {
      final superclass = declaration.extendsClause?.superclass.toSource();
      if (superclass != 'StatelessWidget' &&
          superclass != 'StatefulWidget' &&
          !(superclass?.startsWith('State<') ?? false)) {
        continue;
      }
      final body = declaration.body;
      if (body is! BlockClassBody) {
        continue;
      }
      final build = body.members
          .whereType<MethodDeclaration>()
          .where((method) => method.name.lexeme == 'build')
          .firstOrNull;
      if (build == null) {
        continue;
      }
      builds.add((
        path: file.path,
        widget: declaration.namePart.typeName.lexeme,
        lines: _span(result.lineInfo, build),
      ));
    }
  }

  builds.sort((left, right) => right.lines.compareTo(left.lines));
  for (final build in builds) {
    stdout.writeln('${build.lines}\t${build.path}\t${build.widget}');
  }
}

int _span(LineInfo lines, AstNode node) =>
    lines.getLocation(node.end).lineNumber -
    lines.getLocation(node.offset).lineNumber +
    1;
