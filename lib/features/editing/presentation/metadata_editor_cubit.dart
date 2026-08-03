import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../importing/domain/file_import_repository.dart';
import '../../library/domain/audiobook.dart';
import '../../library/domain/audiobook_catalog_repository.dart';
import 'metadata_editor_state.dart';

@injectable
class MetadataEditorCubit extends Cubit<MetadataEditorState> {
  MetadataEditorCubit(this._books, this._files)
    : super(const MetadataEditorState());

  final AudiobookCatalogRepository _books;
  final FileImportRepository _files;

  Future<void> load(String bookId) async {
    final book = await _books.getBook(bookId);
    emit(
      book == null
          ? const MetadataEditorState(
              status: MetadataEditorStatus.failure,
              message: 'Audiobook not found.',
            )
          : MetadataEditorState(status: MetadataEditorStatus.ready, book: book),
    );
  }

  Future<void> saveDetails({
    required String title,
    required String author,
    required String series,
    required String seriesPosition,
    required String narrator,
    required String year,
    required String folder,
  }) async {
    final book = state.book;
    if (book == null || title.trim().isEmpty) {
      return;
    }
    await _save(
      book.copyWith(
        title: title.trim(),
        author: author.trim(),
        series: series.trim(),
        seriesPosition: double.tryParse(seriesPosition.trim()),
        narrator: narrator.trim(),
        year: _parseYear(year),
        folder: folder.trim().isEmpty ? 'Imported' : folder.trim(),
      ),
    );
  }

  int? _parseYear(String value) {
    final parsed = int.tryParse(value.trim());
    return parsed != null && parsed >= 1000 && parsed <= 2999 ? parsed : null;
  }

  Future<void> changeCover() async {
    final book = state.book;
    if (book == null) {
      return;
    }
    final path = await _files.pickAndImportCover(book.id);
    if (path == null) {
      return;
    }
    final oldPath = book.artworkPath;
    await _save(book.copyWith(artworkPath: path, artworkScanned: true));
    if (oldPath != null && oldPath != path) {
      await _files.deleteImportedFile(oldPath);
    }
  }

  Future<void> reorderTrack(int oldIndex, int newIndex) async {
    final book = state.book;
    if (book == null || book.tracks.isEmpty) {
      return;
    }
    final tracks = [...book.playableTracks];
    final moved = tracks.removeAt(oldIndex);
    tracks.insert(newIndex, moved);
    final ordered = [
      for (var index = 0; index < tracks.length; index++)
        tracks[index].copyWith(order: index),
    ];
    await _save(book.copyWith(tracks: ordered));
  }

  Future<void> addChapter(String title, Duration position) async {
    final book = state.book;
    if (book == null || title.trim().isEmpty) {
      return;
    }
    final chapters = [
      ...book.chapters,
      AudioChapter(title: title.trim(), startMs: position.inMilliseconds),
    ]..sort((a, b) => a.startMs.compareTo(b.startMs));
    await _save(book.copyWith(chapters: chapters));
  }

  Future<void> deleteChapter(AudioChapter chapter) async {
    final book = state.book;
    if (book == null) {
      return;
    }
    await _save(
      book.copyWith(
        chapters: book.chapters.where((item) => item != chapter).toList(),
      ),
    );
  }

  Future<void> _save(Audiobook book) async {
    emit(state.copyWith(status: MetadataEditorStatus.saving, book: book));
    try {
      await _books.saveBook(book);
      emit(state.copyWith(status: MetadataEditorStatus.saved, book: book));
    } catch (_) {
      emit(
        state.copyWith(
          status: MetadataEditorStatus.failure,
          message: 'Could not save audiobook metadata.',
        ),
      );
    }
  }
}
