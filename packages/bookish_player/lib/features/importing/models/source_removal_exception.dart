class SourceRemovalException implements Exception {
  const SourceRemovalException(this.cause);

  final Object cause;

  @override
  String toString() => '$cause';
}
