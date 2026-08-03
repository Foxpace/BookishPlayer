import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../library/domain/audiobook.dart';
import '../domain/library_storage_repository.dart';
import '../domain/storage_report.dart';

@LazySingleton(as: LibraryStorageRepository)
class DeviceLibraryStorageRepository implements LibraryStorageRepository {
  @override
  Future<StorageReport> inspect(List<Audiobook> books) async {
    final referenced = <String>{
      for (final book in books) ...[
        for (final track in book.playableTracks) track.filePath,
        ?book.artworkPath,
      ],
    };
    final missing = <String>[];
    for (final book in books) {
      if (book.playableTracks.any(
        (track) => !File(track.filePath).existsSync(),
      )) {
        missing.add(book.id);
      }
    }
    final duplicateMap = <String, List<String>>{};
    for (final book in books) {
      final key =
          '${book.title.trim().toLowerCase()}|${book.author.trim().toLowerCase()}|${book.durationMs}';
      duplicateMap.putIfAbsent(key, () => []).add(book.id);
    }
    final support = await getApplicationSupportDirectory();
    final managedFiles = <File>[];
    for (final folder in ['audiobooks', 'covers']) {
      final directory = Directory(p.join(support.path, folder));
      if (directory.existsSync()) {
        managedFiles.addAll(
          directory.listSync().whereType<File>().where(
            (file) => !file.path.endsWith('.part'),
          ),
        );
      }
    }
    var managedBytes = 0;
    var reclaimableBytes = 0;
    final orphans = <String>[];
    for (final file in managedFiles) {
      final size = await file.length();
      managedBytes += size;
      if (!referenced.contains(file.path)) {
        orphans.add(file.path);
        reclaimableBytes += size;
      }
    }
    return StorageReport(
      managedBytes: managedBytes,
      reclaimableBytes: reclaimableBytes,
      missingBookIds: missing,
      duplicateBookIds: duplicateMap.values
          .where((group) => group.length > 1)
          .toList(),
      orphanPaths: orphans,
    );
  }

  @override
  Future<void> deleteOrphans(List<String> paths) async {
    for (final path in paths) {
      final file = File(path);
      if (file.existsSync()) {
        await file.delete();
      }
    }
  }
}
