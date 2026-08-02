import 'dart:io';

import 'package:bookish_player/features/importing/data/device_file_import_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('copies large files in a worker isolate with progress', () async {
    final temporary = await Directory.systemTemp.createTemp(
      'bookish_background_copy_test_',
    );
    final source = File('${temporary.path}/source.m4b');
    final destination = '${temporary.path}/destination.m4b';
    const chunk = 1024 * 1024;
    const chunkCount = 20;
    final bytes = List<int>.generate(chunk, (index) => index % 251);
    final output = source.openWrite();
    for (var index = 0; index < chunkCount; index++) {
      output.add(bytes);
    }
    await output.close();
    final progress = <(int, int)>[];

    try {
      await copyFileInBackground(
        source.path,
        destination,
        onProgress: (copied, total) => progress.add((copied, total)),
      );

      final copied = File(destination);
      expect(await copied.length(), chunk * chunkCount);
      expect(progress.first, (0, chunk * chunkCount));
      expect(progress.last, (chunk * chunkCount, chunk * chunkCount));
      expect(File('$destination.part').existsSync(), isFalse);
      expect(
        await copied
            .openRead(0, chunk)
            .fold<List<int>>(<int>[], (result, value) => result..addAll(value)),
        bytes,
      );
    } finally {
      await temporary.delete(recursive: true);
    }
  });
}
