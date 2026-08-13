import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../../library/models/library_models.dart';
import '../library_storage_repository.dart';
import '../../models/storage_report.dart';

@LazySingleton(as: LibraryStorageRepository)
class DeviceLibraryStorageRepository implements LibraryStorageRepository {
  @override
  Future<StorageReport> inspect(List<Audiobook> books) async {
    final referenced = _referencedPaths(books);
    final missing = _missingBookIds(books);
    final duplicates = _duplicateBookIds(books);

    final support = await getApplicationSupportDirectory();
    final managedFiles = _managedFiles(support);
    final usage = await _measureUsage(managedFiles, referenced);

    return StorageReport(
      managedBytes: usage.managedBytes,
      reclaimableBytes: usage.reclaimableBytes,
      missingBookIds: missing,
      duplicateBookIds: duplicates,
      orphanPaths: usage.orphanPaths,
    );
  }

  Set<String> _referencedPaths(List<Audiobook> books) {
    return {
      for (final book in books) ...[
        for (final track in book.playableTracks) track.filePath,
        ?book.artworkPath,
      ],
    };
  }

  List<String> _missingBookIds(List<Audiobook> books) {
    final missing = <String>[];

    for (final book in books) {
      if (book.playableTracks.any(
        (track) => !File(track.filePath).existsSync(),
      )) {
        missing.add(book.id);
      }
    }

    return missing;
  }

  List<List<String>> _duplicateBookIds(List<Audiobook> books) {
    final duplicateMap = <String, List<String>>{};

    for (final book in books) {
      final key =
          '${book.title.trim().toLowerCase()}|${book.author.trim().toLowerCase()}|${book.durationMs}';
      duplicateMap.putIfAbsent(key, () => []).add(book.id);
    }

    return duplicateMap.values.where((group) => group.length > 1).toList();
  }

  List<File> _managedFiles(Directory support) {
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

    return managedFiles;
  }

  Future<({int managedBytes, int reclaimableBytes, List<String> orphanPaths})>
  _measureUsage(List<File> files, Set<String> referenced) async {
    var managedBytes = 0;
    var reclaimableBytes = 0;
    final orphans = <String>[];

    for (final file in files) {
      final size = await file.length();
      managedBytes += size;

      if (!referenced.contains(file.path)) {
        orphans.add(file.path);
        reclaimableBytes += size;
      }
    }

    return (
      managedBytes: managedBytes,
      reclaimableBytes: reclaimableBytes,
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
