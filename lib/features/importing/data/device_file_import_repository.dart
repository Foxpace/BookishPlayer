import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:injectable/injectable.dart';

import '../domain/file_import_repository.dart';

@LazySingleton(as: FileImportRepository)
class DeviceFileImportRepository implements FileImportRepository {
  DeviceFileImportRepository();

  static const _extensions = [
    'mp3',
    'm4a',
    'm4b',
    'aac',
    'wav',
    'flac',
    'ogg',
    'opus',
  ];

  final _uuid = const Uuid();

  @override
  Future<List<SelectedAudioFile>> pickAudioFiles() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: _extensions,
      withData: false,
    );
    if (result == null) {
      return const [];
    }

    final inaccessible = result.files
        .where((file) => file.path == null)
        .map((file) => file.name)
        .toList();
    if (inaccessible.isNotEmpty) {
      throw FileSystemException(
        'The document provider did not expose a readable local copy for: '
        '${inaccessible.join(', ')}',
      );
    }

    return result.files
        .map(
          (file) =>
              SelectedAudioFile(sourcePath: file.path!, displayName: file.name),
        )
        .toList();
  }

  @override
  Future<List<SelectedAudioFile>> findTransferredAudioFiles() async {
    final documents = await getApplicationDocumentsDirectory();
    final files = await documents
        .list(recursive: true, followLinks: false)
        .where((entity) => entity is File)
        .cast<File>()
        .where(
          (file) => _extensions.contains(
            p.extension(file.path).substring(1).toLowerCase(),
          ),
        )
        .toList();
    files.sort((a, b) => a.path.compareTo(b.path));
    return files
        .map(
          (file) => SelectedAudioFile(
            sourcePath: file.path,
            displayName: p.basename(file.path),
          ),
        )
        .toList();
  }

  @override
  Future<ImportedAudioFile> importFile(SelectedAudioFile selected) async {
    final support = await getApplicationSupportDirectory();
    final library = Directory(p.join(support.path, 'audiobooks'));
    await library.create(recursive: true);
    final extension = p.extension(selected.displayName).toLowerCase();
    final destination = p.join(library.path, '${_uuid.v4()}$extension');
    await File(selected.sourcePath).copy(destination);
    return ImportedAudioFile(
      path: destination,
      displayName: selected.displayName,
    );
  }

  @override
  Future<void> removeTransferredAudioFiles(
    List<SelectedAudioFile> files,
  ) async {
    for (final selected in files) {
      final file = File(selected.sourcePath);
      if (file.existsSync()) {
        await file.delete();
      }
    }
  }

  @override
  Future<String?> pickAndImportCover(String bookId) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
      withData: false,
    );
    final sourcePath = result?.files.single.path;
    if (sourcePath == null) {
      return null;
    }
    final support = await getApplicationSupportDirectory();
    final directory = Directory(p.join(support.path, 'covers'));
    await directory.create(recursive: true);
    final extension = p.extension(sourcePath).toLowerCase();
    final destination = p.join(directory.path, '$bookId$extension');
    await File(sourcePath).copy(destination);
    return destination;
  }

  @override
  Future<void> deleteImportedFile(String path) async {
    final file = File(path);
    if (file.existsSync()) {
      await file.delete();
    }
  }
}
