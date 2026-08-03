part of 'device_file_import_repository.dart';

void _copyFileWorker(_CopyRequest request) {
  RandomAccessFile? source;
  RandomAccessFile? destination;
  try {
    final partial = File(request.partialPath);
    if (partial.existsSync()) {
      partial.deleteSync();
    }
    source = File(request.sourcePath).openSync(mode: FileMode.read);
    destination = partial.openSync(mode: FileMode.write);
    final totalBytes = source.lengthSync();
    final buffer = Uint8List(4 * 1024 * 1024);
    var copiedBytes = 0;
    var lastReportedBytes = 0;
    var lastReportedAt = DateTime.now();
    request.sendPort.send((copiedBytes: 0, totalBytes: totalBytes));
    while (true) {
      final count = source.readIntoSync(buffer);
      if (count == 0) {
        break;
      }
      destination.writeFromSync(buffer, 0, count);
      copiedBytes += count;
      final now = DateTime.now();
      if (copiedBytes - lastReportedBytes >= 16 * 1024 * 1024 ||
          now.difference(lastReportedAt) >= const Duration(milliseconds: 250)) {
        request.sendPort.send((
          copiedBytes: copiedBytes,
          totalBytes: totalBytes,
        ));
        lastReportedBytes = copiedBytes;
        lastReportedAt = now;
      }
    }
    destination.flushSync();
    destination.closeSync();
    destination = null;
    source.closeSync();
    source = null;
    if (copiedBytes != totalBytes) {
      throw FileSystemException(
        'Copied $copiedBytes of $totalBytes bytes.',
        request.sourcePath,
      );
    }
    partial.renameSync(request.destinationPath);
    request.sendPort.send((copiedBytes: copiedBytes, totalBytes: totalBytes));
    request.sendPort.send(_CopySignal.complete);
  } catch (error, stackTrace) {
    try {
      destination?.closeSync();
      source?.closeSync();
      final partial = File(request.partialPath);
      if (partial.existsSync()) {
        partial.deleteSync();
      }
    } catch (_) {}
    request.sendPort.send((message: '$error\n$stackTrace'));
  }
}

typedef _CopyRequest = ({
  String sourcePath,
  String destinationPath,
  String partialPath,
  SendPort sendPort,
});

enum _CopySignal { complete }
