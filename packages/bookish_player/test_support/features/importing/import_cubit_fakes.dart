import 'dart:async';

import 'package:bookish_player/features/importing/repos/file_import_repository.dart';
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
  Future<List<SelectedAudioFile>> pickAudioFiles() async {
    pickCount++;
    return selected;
  }

  @override
  Future<ImportedAudioFile> importFile(
    SelectedAudioFile selected, {
    ImportCancellationSignal? cancellation,
    FileCopyProgress? onProgress,
  }) async {
    final current = copyCount++;
    events?.add('copy');
    if (current == pauseCopyAt) {
      copyPaused.complete();
      await cancellation?.whenCancelled;
      throw const ImportCancelledException();
    }
    onProgress?.call(100, 100);
    return ImportedAudioFile(
      path: '/bookish/book-$current.m4b',
      displayName: selected.displayName,
    );
  }

  @override
  Future<void> removeTransferredAudioFiles(
    List<SelectedAudioFile> files,
  ) async {
    events?.add('remove');
  }

  @override
  Future<void> clearTemporaryFiles() async => events?.add('clear-cache');
  @override
  Future<void> deleteImportedFile(String path) async {}
  @override
  Future<List<SelectedAudioFile>> findTransferredAudioFiles() async => selected;
  @override
  Future<String?> pickAndImportCover(String bookId) async => null;
}
