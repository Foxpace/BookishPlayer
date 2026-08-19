part of 'diagnostic_entry.dart';

extension DiagnosticEntryFormatting on DiagnosticEntry {
  String toDiagnosticText({
    required String title,
    String historyTitle = 'Completed operations:',
    String diagnosticsTitle = 'Additional diagnostics:',
  }) => [
    title,
    'Time: $time',
    'Operation: $operation',
    for (final entry in context.entries) '${entry.key}: ${entry.value}',

    'Platform: $platform $platformVersion',
    'Build: $build',
    '',

    'Error type: $errorType',
    if (message case final value?) 'Error: $value',
    '',
    historyTitle,
    if (history.isEmpty) 'None' else ...history,
    if (diagnostics.isNotEmpty) ...['', diagnosticsTitle, ...diagnostics],
    '',
    'Stack trace:',
    stack,
  ].join('\n');
}
