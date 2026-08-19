import 'dart:async';

import 'package:bookish_player/core/foundation/result.dart';
import 'package:bookish_player/features/importing/repos/file_import_repository.dart';
import 'package:bookish_player/features/importing/repos/file_import_failure.dart';
import 'package:bookish_player/features/importing/repos/selected_audio_file.dart';
import 'package:bookish_player/features/importing/models/import_cancellation.dart';

class FakeImportFiles implements FileImportRepository {
  FakeImportFiles(this.selected, {this.events, this.pauseCopyAt});
  final List<SelectedAudioFile> selected;
  final List<String>? events;
  final int? pauseCopyAt;
  final copyPaused = Completer<void>();
  var pickCount = 0;
  var copyCount = 0;

  @override
  Future<Result<List<SelectedAudioFile>, FileImportFailure>>
  pickAudioFiles() async {
    pickCount++;
    return Result.success(selected);
  }

  @override
  Future<Result<ImportedAudioFile, FileImportFailure>> importFile(
    SelectedAudioFile selected, {
    ImportCancellationSignal? cancellation,
    FileCopyProgress? onProgress,
  }) async {
    final current = copyCount++;
    events?.add('copy');
    if (current == pauseCopyAt) {
      copyPaused.complete();
      await cancellation?.whenCancelled;
      return const Result.failure(FileImportFailure.cancelled);
    }
    onProgress?.call(100, 100);
    return Result.success(
      ImportedAudioFile(
        path: '/bookish/book-$current.m4b',
        displayName: selected.displayName,
      ),
    );
  }

  @override
  Future<Result<bool, FileImportFailure>> removeTransferredAudioFiles(
    List<SelectedAudioFile> files,
  ) async {
    events?.add('remove');
    return const Result.success(true);
  }

  @override
  Future<void> clearTemporaryFiles() async => events?.add('clear-cache');
  @override
  Future<void> deleteImportedFile(String path) async {}
  @override
  Future<Result<List<SelectedAudioFile>, FileImportFailure>>
  findTransferredAudioFiles() async => Result.success(selected);
  @override
  Future<String?> pickAndImportCover(String bookId) async => null;
}
