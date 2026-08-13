import 'dart:io';

const _generatedSuffixes = <String>[
  '.g.dart',
  '.freezed.dart',
  'injection.config.dart',
];

void main(List<String> arguments) {
  final enforce = arguments.contains('--enforce');
  final paths = arguments.where((argument) => !argument.startsWith('--'));
  final path = paths.isEmpty ? 'coverage/lcov.info' : paths.first;
  final source = File(path);
  if (!source.existsSync()) {
    stderr.writeln('Coverage file not found: $path');
    exitCode = 2;
    return;
  }

  final totals = _Coverage();
  final logic = _Coverage();
  final critical = _Coverage();
  var active = false;
  var activeLogic = false;
  var activeCritical = false;
  for (final line in source.readAsLinesSync()) {
    if (line.startsWith('SF:')) {
      final file = line.substring(3);
      active = _isHandwrittenProduction(file);
      activeLogic = active && _isLogic(file);
      activeCritical = active && _isCritical(file);
      continue;
    }
    if (!active || !line.startsWith('DA:')) {
      continue;
    }
    final separator = line.indexOf(',');
    final hits = int.parse(line.substring(separator + 1));
    totals.add(hits);
    if (activeLogic) {
      logic.add(hits);
    }
    if (activeCritical) {
      critical.add(hits);
    }
  }

  stdout
    ..writeln('Handwritten production: ${totals.summary}')
    ..writeln('Models/use cases/projectors/policies/Cubits: ${logic.summary}')
    ..writeln('Critical adapters and use cases: ${critical.summary}');

  if (enforce &&
      (totals.percent < 70 || logic.percent < 85 || critical.percent < 70)) {
    stderr.writeln(
      'Coverage is below the documented local acceptance targets.',
    );
    exitCode = 1;
  }
}

bool _isHandwrittenProduction(String path) =>
    path.startsWith('lib/') &&
    !_generatedSuffixes.any(path.endsWith) &&
    !path.contains('/localization/generated/');

bool _isLogic(String path) =>
    path.contains('/models/') ||
    path.contains('/use_cases/') ||
    path.endsWith('_cubit.dart') ||
    path.endsWith('_projector.dart') ||
    path.endsWith('_policy.dart');

bool _isCritical(String path) =>
    path.contains('/core/database/') ||
    path.contains('/core/diagnostics/') ||
    RegExp(
      '^lib/features/(importing|library|player|portability)/'
      '(use_cases|repos/implementations)/',
    ).hasMatch(path);

class _Coverage {
  var covered = 0;
  var total = 0;

  double get percent => total == 0 ? 0 : covered * 100 / total;

  String get summary => '$covered/$total (${percent.toStringAsFixed(1)}%)';

  void add(int hits) {
    total++;
    if (hits > 0) {
      covered++;
    }
  }
}
