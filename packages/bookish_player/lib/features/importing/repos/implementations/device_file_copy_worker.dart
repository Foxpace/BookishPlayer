import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

typedef _CopyResult = ({int copiedBytes, int totalBytes});

void copyFileWorker(FileCopyRequest request) {
  final operation = _FileCopyOperation(request);
  try {
    operation.copyFileAndReportProgress();
  } catch (error, stackTrace) {
    operation.reportCopyFailure(error, stackTrace);
  }
}

class _FileCopyOperation {
  _FileCopyOperation(this.request);

  final FileCopyRequest request;
  RandomAccessFile? _source;
  RandomAccessFile? _destination;
  Object? _cleanupError;

  void copyFileAndReportProgress() {
    final partial = _preparePartialFile();
    final source = _openSource();
    final destination = _openDestination(partial);
    final result = _copyBytes(source, destination);

    _closeOpenFiles();
    final validationFailure = _validateCopy(result);
    if (validationFailure != null) {
      reportCopyFailure(validationFailure, StackTrace.current);
      return;
    }

    partial.renameSync(request.destinationPath);
    _reportProgress(result.copiedBytes, result.totalBytes);
    request.sendPort.send(FileCopySignal.complete);
  }

  File _preparePartialFile() {
    final partial = File(request.partialPath);
    if (partial.existsSync()) {
      partial.deleteSync();
    }

    return partial;
  }

  RandomAccessFile _openSource() {
    final source = File(request.sourcePath).openSync(mode: FileMode.read);
    _source = source;
    return source;
  }

  RandomAccessFile _openDestination(File partial) {
    final destination = partial.openSync(mode: FileMode.write);
    _destination = destination;
    return destination;
  }

  _CopyResult _copyBytes(
    RandomAccessFile source,
    RandomAccessFile destination,
  ) {
    final totalBytes = source.lengthSync();
    final buffer = Uint8List(4 * 1024 * 1024);
    var copiedBytes = 0;
    var lastReportedBytes = 0;
    var lastReportedAt = DateTime.now();

    _reportProgress(copiedBytes, totalBytes);
    while (true) {
      final count = source.readIntoSync(buffer);
      if (count == 0) {
        break;
      }

      destination.writeFromSync(buffer, 0, count);
      copiedBytes += count;

      final now = DateTime.now();
      if (_shouldReportProgress(
        copiedBytes,
        lastReportedBytes,
        now,
        lastReportedAt,
      )) {
        _reportProgress(copiedBytes, totalBytes);
        lastReportedBytes = copiedBytes;
        lastReportedAt = now;
      }
    }

    destination.flushSync();

    return (copiedBytes: copiedBytes, totalBytes: totalBytes);
  }

  bool _shouldReportProgress(
    int copiedBytes,
    int lastReportedBytes,
    DateTime now,
    DateTime lastReportedAt,
  ) {
    return copiedBytes - lastReportedBytes >= 16 * 1024 * 1024 ||
        now.difference(lastReportedAt) >= const Duration(milliseconds: 250);
  }

  void _closeOpenFiles() {
    _destination?.closeSync();
    _destination = null;

    _source?.closeSync();
    _source = null;
  }

  String? _validateCopy(_CopyResult result) {
    if (result.copiedBytes != result.totalBytes) {
      return 'Copied ${result.copiedBytes} of ${result.totalBytes} bytes.';
    }
    return null;
  }

  void _reportProgress(int copiedBytes, int totalBytes) =>
      request.sendPort.send((copiedBytes: copiedBytes, totalBytes: totalBytes));

  void reportCopyFailure(Object error, StackTrace stackTrace) {
    try {
      _closeFilesAndDeletePartial();
    } catch (caught) {
      _recordCleanupFailure(caught);
    }
    final cleanupDetail = _cleanupError == null
        ? ''
        : '\nCleanup also failed: ${_cleanupError.runtimeType}';
    request.sendPort.send('$error\n$stackTrace$cleanupDetail');
  }

  void _closeFilesAndDeletePartial() {
    _closeOpenFiles();

    final partial = File(request.partialPath);
    if (partial.existsSync()) {
      partial.deleteSync();
    }
  }

  void _recordCleanupFailure(Object error) {
    _cleanupError = error;
  }
}

typedef FileCopyRequest = ({
  String sourcePath,
  String destinationPath,
  String partialPath,
  SendPort sendPort,
});

enum FileCopySignal { complete }
