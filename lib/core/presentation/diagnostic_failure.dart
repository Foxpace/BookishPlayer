String diagnosticFailureMessage(String action, Object error) {
  final type = error.runtimeType.toString();
  final raw = error.toString().trim();
  final detail = raw.startsWith('$type:')
      ? raw.substring(type.length + 1).trim()
      : raw;
  return '$action\n$type: $detail';
}
