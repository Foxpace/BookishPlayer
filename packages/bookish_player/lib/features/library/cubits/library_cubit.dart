import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/foundation/result.dart';
import '../../../core/presentation/app_message.dart';
import '../use_cases/library_application.dart';
import '../models/library_models.dart';
import '../models/audiobook_removal_mode.dart';
import 'library_cubits.dart';
import 'library_state_projection.dart';

class LibraryCubit extends Cubit<LibraryState> {
  LibraryCubit(this._application) : super(const LibraryState());

  final LibraryApplication _application;

  Future<void> load() async {
    emit(state.copyWith(status: LibraryStatus.loading, message: null));
    await _loadLibraryAndEmit();
  }

  Future<bool> deleteBook(Audiobook book, AudiobookRemovalMode mode) async {
    return _removeBookAndEmit(book, mode);
  }

  void clearMessage() {
    emit(state.copyWith(status: LibraryStatus.ready, message: null));
  }

  void setGrouping(LibraryGrouping grouping) {
    _projectAndEmit(state.copyWith(grouping: grouping));
  }

  Future<void> setLayout(LibraryLayout layout) async {
    emit(state.copyWith(layout: layout));
    if (await _application.setLayout(layout.name) case ResultFailure()) {
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
    await _saveUpdatedBookAndEmit(updated);
  }

  Future<void> _loadLibraryAndEmit() async {
    switch (await _application.load()) {
      case ResultSuccess(:final value):
        final layout = value.layout == LibraryLayout.grid.name
            ? LibraryLayout.grid
            : LibraryLayout.list;
        _projectAndEmit(
          state.copyWith(
            status: LibraryStatus.ready,
            books: value.books,
            layout: layout,
          ),
        );
      case ResultFailure():
        _emitLibraryLoadFailure();
    }
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
    return switch (await _application.removeBook(book, mode)) {
      ResultSuccess() => _emitBookRemoved(book),
      ResultFailure() => _emitBookRemovalFailure(),
    };
  }

  bool _emitBookRemoved(Audiobook book) {
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
    switch (await _application.saveBook(updated)) {
      case ResultSuccess():
        final books = [
          for (final book in state.books)
            if (book.id == updated.id) updated else book,
        ];
        _projectAndEmit(state.copyWith(books: books));
      case ResultFailure():
        _emitBookUpdateFailure();
    }
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
