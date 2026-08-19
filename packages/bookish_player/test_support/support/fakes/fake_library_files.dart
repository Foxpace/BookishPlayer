import 'package:bookish_player/core/foundation/result.dart';
import 'package:bookish_player/features/importing/repos/file_import_repository.dart';
import 'package:bookish_player/features/importing/models/import_cancellation.dart';
import 'package:bookish_player/features/importing/repos/file_import_failure.dart';
import 'package:bookish_player/features/importing/repos/selected_audio_file.dart';

class FakeLibraryFiles implements FileImportRepository {
  String? pickedCover;
  final deletedPaths = <String>[];

  @override
  Future<void> clearTemporaryFiles() async {}

  @override
  Future<void> deleteImportedFile(String path) async {
    deletedPaths.add(path);
  }

  @override
  Future<Result<List<SelectedAudioFile>, FileImportFailure>>
  findTransferredAudioFiles() async => const Result.success([]);

  @override
  Future<Result<ImportedAudioFile, FileImportFailure>> importFile(
    SelectedAudioFile selected, {
    ImportCancellationSignal? cancellation,
    FileCopyProgress? onProgress,
  }) async => Result.success(
    ImportedAudioFile(
      path: selected.sourcePath,
      displayName: selected.displayName,
    ),
  );

  @override
  Future<String?> pickAndImportCover(String bookId) async => pickedCover;

  @override
  Future<Result<List<SelectedAudioFile>, FileImportFailure>>
  pickAudioFiles() async => const Result.success([]);

  @override
  Future<Result<bool, FileImportFailure>> removeTransferredAudioFiles(
    List<SelectedAudioFile> files,
  ) async => const Result.success(true);
}
