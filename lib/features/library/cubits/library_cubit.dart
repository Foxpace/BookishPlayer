import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/presentation/app_message.dart';
import '../use_cases/library_use_case_bundle.dart';
import '../models/library_models.dart';
import '../models/audiobook_removal_mode.dart';
import 'library_cubits.dart';
import 'library_state_projection.dart';
import 'library_intents.dart';

class LibraryCubit extends Cubit<LibraryState> {
  LibraryCubit(this._useCases, this._prepareBookRemoval)
    : super(const LibraryState());

  final LibraryUseCases _useCases;
  final PrepareBookRemoval _prepareBookRemoval;

  Future<void> load() async {
    emit(state.copyWith(status: LibraryStatus.loading, message: null));
    try {
      await _loadLibraryAndEmit();
    } catch (_) {
      _emitLibraryLoadFailure();
    }
  }

  Future<bool> deleteBook(Audiobook book, AudiobookRemovalMode mode) async {
    try {
      return await _removeBookAndEmit(book, mode);
    } catch (_) {
      return _emitBookRemovalFailure();
    }
  }

  void clearMessage() {
    emit(state.copyWith(status: LibraryStatus.ready, message: null));
  }

  void setGrouping(LibraryGrouping grouping) {
    _projectAndEmit(state.copyWith(grouping: grouping));
  }

  Future<void> setLayout(LibraryLayout layout) async {
    emit(state.copyWith(layout: layout));
    try {
      await _useCases.saveLayout(layout.name);
    } catch (_) {
      _emitLayoutSaveFailure();
    }
  }

  void setQuery(String query) => _projectAndEmit(state.copyWith(query: query));

  void setFilter(LibraryFilter filter) =>
      _projectAndEmit(state.copyWith(filter: filter));

  void setSort(LibrarySort sort) => _projectAndEmit(state.copyWith(sort: sort));

  Future<void> toggleFavorite(Audiobook book) async {
    await _saveUpdatedBook(book.copyWith(isFavorite: !book.isFavorite));
  }

  Future<void> setListeningStatus(
    Audiobook book,
    ListeningStatus? status,
  ) async {
    await _saveUpdatedBook(
      book.copyWith(
        statusOverride: status,
        completedAt: status == ListeningStatus.finished
            ? (book.completedAt ?? DateTime.now())
            : null,
      ),
    );
  }

  Future<void> _saveUpdatedBook(Audiobook updated) async {
    try {
      await _saveUpdatedBookAndEmit(updated);
    } catch (_) {
      _emitBookUpdateFailure();
    }
  }

  Future<void> _loadLibraryAndEmit() async {
    final result = await _useCases.loadLibrary();
    final layout = result.layout == LibraryLayout.grid.name
        ? LibraryLayout.grid
        : LibraryLayout.list;
    _projectAndEmit(
      state.copyWith(
        status: LibraryStatus.ready,
        books: result.books,
        layout: layout,
      ),
    );
  }

  void _emitLibraryLoadFailure() => emit(
    state.copyWith(
      status: LibraryStatus.failure,
      message: AppMessage.libraryLoadFailed,
      effectRevision: state.effectRevision + 1,
    ),
  );

  Future<bool> _removeBookAndEmit(
    Audiobook book,
    AudiobookRemovalMode mode,
  ) async {
    await _prepareBookRemoval(book.id);
    await _useCases.removeBook(book, mode);
    _projectAndEmit(
      state.copyWith(
        books: state.books.where((item) => item.id != book.id).toList(),
      ),
    );
    return true;
  }

  bool _emitBookRemovalFailure() {
    emit(
      state.copyWith(
        status: LibraryStatus.failure,
        message: AppMessage.bookRemovalFailed,
        effectRevision: state.effectRevision + 1,
      ),
    );
    return false;
  }

  void _emitLayoutSaveFailure() => emit(
    state.copyWith(
      message: AppMessage.libraryLayoutSaveFailed,
      effectRevision: state.effectRevision + 1,
    ),
  );

  Future<void> _saveUpdatedBookAndEmit(Audiobook updated) async {
    await _useCases.saveBook(updated);
    final books = [
      for (final book in state.books)
        if (book.id == updated.id) updated else book,
    ];
    _projectAndEmit(state.copyWith(books: books));
  }

  void _emitBookUpdateFailure() => emit(
    state.copyWith(
      message: AppMessage.bookUpdateFailed,
      effectRevision: state.effectRevision + 1,
    ),
  );

  void _projectAndEmit(LibraryState next) {
    emit(next.projectView());
  }
}
