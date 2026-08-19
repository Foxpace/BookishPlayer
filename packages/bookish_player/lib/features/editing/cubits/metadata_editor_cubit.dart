import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/presentation/app_message.dart';
import '../../library/models/library_models.dart';
import '../models/editable_book_details.dart';
import '../use_cases/editing_application.dart';
import 'metadata_editor_state.dart';
import 'metadata_editor_status.dart';

@injectable
class MetadataEditorCubit extends Cubit<MetadataEditorState> {
  MetadataEditorCubit(this._application) : super(const MetadataEditorState());

  final EditingApplication _application;

  Future<void> load(String bookId) async {
    emit(
      state.copyWith(
        status: MetadataEditorStatus.loading,
        bookId: bookId,
        message: null,
      ),
    );
    try {
      await _loadBookAndEmit(bookId);
    } catch (_) {
      _emitBookLoadFailure();
    }
  }

  Future<void> retryLoad() async {
    if (state.bookId case final id?) {
      await load(id);
    }
  }

  Future<void> saveDetails(EditableBookDetails details) async {
    final book = state.book;
    if (book == null || details.title.trim().isEmpty) {
      return;
    }

    await _saveBook(_application.editDetails(book, details));
  }

  Future<void> changeCover() async {
    final book = state.book;
    if (book == null) {
      return;
    }
    await _saveBook(_application.changeCover(book));
  }

  Future<void> reorderTrack(int oldIndex, int newIndex) async {
    final book = state.book;
    if (book == null || book.tracks.isEmpty) {
      return;
    }
    await _saveBook(_application.reorderTracks(book, oldIndex, newIndex));
  }

  Future<void> addChapter(String title, Duration position) async {
    final book = state.book;
    if (book == null || title.trim().isEmpty) {
      return;
    }
    await _saveBook(_application.addChapter(book, title, position));
  }

  Future<void> deleteChapter(AudioChapter chapter) async {
    final book = state.book;
    if (book == null) {
      return;
    }
    await _saveBook(_application.deleteChapter(book, chapter));
  }

  Future<void> _saveBook(Future<Audiobook> operation) async {
    emit(state.copyWith(status: MetadataEditorStatus.saving));
    try {
      await _saveBookAndEmit(operation);
    } catch (_) {
      _emitBookSaveFailure();
    }
  }

  Future<void> _loadBookAndEmit(String bookId) async {
    final book = await _application.loadBook(bookId);
    emit(
      MetadataEditorState(
        status: MetadataEditorStatus.ready,
        bookId: bookId,
        book: book,
        effectRevision: state.effectRevision,
      ),
    );
  }

  void _emitBookLoadFailure() => emit(
    MetadataEditorState(
      status: MetadataEditorStatus.failure,
      bookId: state.bookId,
      message: AppMessage.metadataEditorLoadFailed,
      effectRevision: state.effectRevision + 1,
    ),
  );

  Future<void> _saveBookAndEmit(Future<Audiobook> operation) async {
    final book = await operation;
    emit(state.copyWith(status: MetadataEditorStatus.saved, book: book));
  }

  void _emitBookSaveFailure() => emit(
    state.copyWith(
      status: MetadataEditorStatus.failure,
      message: AppMessage.metadataSaveFailed,
      effectRevision: state.effectRevision + 1,
    ),
  );
}
