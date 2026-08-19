import 'dart:io';
import 'dart:isolate';

import '../../../../core/foundation/result.dart';
import '../../models/import_cancellation.dart';
import '../file_import_repository.dart';
import 'device_file_copy_worker.dart';

Future<Result<bool>> copyFileInBackground(
  String sourcePath,
  String destinationPath, {
  ImportCancellationSignal? cancellation,
  FileCopyProgress? onProgress,
}) => _BackgroundFileCopy(
  sourcePath: sourcePath,
  destinationPath: destinationPath,
  cancellation: cancellation,
  onProgress: onProgress,
).run();

class _BackgroundFileCopy {
  _BackgroundFileCopy({
    required this.sourcePath,
    required this.destinationPath,
    required this.cancellation,
    required this.onProgress,
  });

  final String sourcePath;
  final String destinationPath;
  final ImportCancellationSignal? cancellation;
  final FileCopyProgress? onProgress;
  final messages = ReceivePort();

  String get partialPath => '$destinationPath.part';

  Future<Result<bool>> run() async {
    Isolate? isolate;
    try {
      return await _runCopy((spawned) => isolate = spawned);
    } catch (error) {
      return Result.failure(
        AppFailure.operationFailed('import.fileAccess', error: error),
      );
    } finally {
      _finish(isolate);
    }
  }

  Future<Result<bool>> _runCopy(void Function(Isolate) onSpawned) async {
    final isolate = await _spawn();
    onSpawned(isolate);
    return _waitForResult();
  }

  Future<Isolate> _spawn() => Isolate.spawn(
    copyFileWorker,
    _copyRequest(sourcePath, destinationPath, partialPath, messages.sendPort),
    debugName: 'bookish-file-copy',
    onError: messages.sendPort,
    onExit: messages.sendPort,
  );

  Future<Result<bool>> _waitForResult() => Future.any([
    _receiveCopyMessages(messages, onProgress),
    if (cancellation case final signal?)
      signal.whenCancelled.then<Result<bool>>(
        (_) => const Result.failure(AppFailure.cancelled('import.cancelled')),
      ),
  ]);

  void _finish(Isolate? isolate) {
    messages.close();
    isolate?.kill(priority: Isolate.immediate);
    _deleteFile(partialPath);
    if (cancellation?.isCancelled ?? false) {
      _deleteFile(destinationPath);
    }
  }
}

FileCopyRequest _copyRequest(
  String sourcePath,
  String destinationPath,
  String partialPath,
  SendPort sendPort,
) => (
  sourcePath: sourcePath,
  destinationPath: destinationPath,
  partialPath: partialPath,
  sendPort: sendPort,
);

void _deleteFile(String path) {
  final file = File(path);
  if (file.existsSync()) {
    file.deleteSync();
  }
}

Future<Result<bool>> _receiveCopyMessages(
  ReceivePort messages,
  FileCopyProgress? onProgress,
) async {
  await for (final message in messages) {
    final result = _handleCopyMessage(message, onProgress);
    if (result != null) {
      return result;
    }
  }
  return const Result.failure(AppFailure.operationFailed('import.fileAccess'));
}

Result<bool>? _handleCopyMessage(
  Object? message,
  FileCopyProgress? onProgress,
) {
  if (message case (
    copiedBytes: final int copiedBytes,
    totalBytes: final int totalBytes,
  )) {
    onProgress?.call(copiedBytes, totalBytes);
    return null;
  }
  return message == FileCopySignal.complete
      ? const Result.success(true)
      : const Result.failure(AppFailure.operationFailed('import.fileAccess'));
}
