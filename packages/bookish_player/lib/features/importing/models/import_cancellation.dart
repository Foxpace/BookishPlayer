import 'dart:async';

import 'import_cancelled_exception.dart';
export 'import_cancelled_exception.dart';

class ImportCancellationSignal {
  final _cancelled = Completer<void>();

  bool get isCancelled => _cancelled.isCompleted;

  Future<void> get whenCancelled => _cancelled.future;

  void cancel() {
    if (!_cancelled.isCompleted) {
      _cancelled.complete();
    }
  }

  void throwIfCancelled() {
    if (isCancelled) {
      throw const ImportCancelledException();
    }
  }
}
