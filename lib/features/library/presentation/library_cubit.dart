import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/presentation/diagnostic_failure.dart';
import '../application/load_library_workflow.dart';
import '../application/remove_audiobook_workflow.dart';
import '../../importing/domain/file_import_repository.dart';
import '../../importing/domain/audiobook_artwork_extractor.dart';
import '../../settings/domain/settings_repository.dart';
import '../domain/audiobook.dart';
import '../domain/audiobook_catalog_repository.dart';
import '../domain/audiobook_removal_mode.dart';
import 'library_state.dart';

@injectable
class LibraryCubit extends Cubit<LibraryState> {
  LibraryCubit(
    this._books,
    FileImportRepository files,
    AudiobookArtworkExtractor artwork,
    this._settings,
  ) : _loader = LoadLibraryWorkflow(_books, artwork, _settings),
      _remover = RemoveAudiobookWorkflow(_books, files),
      super(const LibraryState());

  final AudiobookCatalogRepository _books;
  final SettingsRepository _settings;
  final LoadLibraryWorkflow _loader;
  final RemoveAudiobookWorkflow _remover;

  Future<void> load() async {
    emit(state.copyWith(status: LibraryStatus.loading, message: null));
    try {
      final result = await _loader.run();
      final layout = result.layout == LibraryLayout.grid.name
          ? LibraryLayout.grid
          : LibraryLayout.list;
      emit(
        state.copyWith(
          status: LibraryStatus.ready,
          books: result.books,
          layout: layout,
          sections: _buildSections(_visibleBooks(result.books), state.grouping),
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: LibraryStatus.failure,
          message: diagnosticFailureMessage(
            'Could not open your library.',
            error,
          ),
        ),
      );
    }
  }

  Future<bool> deleteBook(Audiobook book, AudiobookRemovalMode mode) async {
    try {
      await _remover.run(book, mode);
      emit(
        state.copyWith(
          books: state.books.where((item) => item.id != book.id).toList(),
          sections: _buildSections(
            _visibleBooks(
              state.books.where((item) => item.id != book.id).toList(),
            ),
            state.grouping,
          ),
        ),
      );
      return true;
    } catch (error) {
      emit(
        state.copyWith(
          status: LibraryStatus.failure,
          message: diagnosticFailureMessage(
            'The book could not be removed.',
            error,
          ),
        ),
      );
      return false;
    }
  }

  void clearMessage() {
    emit(state.copyWith(status: LibraryStatus.ready, message: null));
  }

  void setGrouping(LibraryGrouping grouping) {
    emit(
      state.copyWith(
        grouping: grouping,
        sections: _buildSections(_visibleBooks(state.books), grouping),
      ),
    );
  }

  Future<void> setLayout(LibraryLayout layout) async {
    emit(state.copyWith(layout: layout));
    try {
      await _settings.setLibraryLayout(layout.name);
    } catch (error) {
      emit(
        state.copyWith(
          message: diagnosticFailureMessage(
            'The library layout could not be saved.',
            error,
          ),
        ),
      );
    }
  }

  void setQuery(String query) => _refresh(state.copyWith(query: query));

  void setFilter(LibraryFilter filter) =>
      _refresh(state.copyWith(filter: filter));

  void setSort(LibrarySort sort) => _refresh(state.copyWith(sort: sort));

  Future<void> toggleFavorite(Audiobook book) async {
    await _saveUpdated(book.copyWith(isFavorite: !book.isFavorite));
  }

  Future<void> setListeningStatus(
    Audiobook book,
    ListeningStatus? status,
  ) async {
    await _saveUpdated(
      book.copyWith(
        statusOverride: status,
        completedAt: status == ListeningStatus.finished
            ? (book.completedAt ?? DateTime.now())
            : null,
      ),
    );
  }

  Future<void> _saveUpdated(Audiobook updated) async {
    try {
      await _books.saveBook(updated);
      final books = [
        for (final book in state.books)
          if (book.id == updated.id) updated else book,
      ];
      _refresh(state.copyWith(books: books));
    } catch (error) {
      emit(
        state.copyWith(
          message: diagnosticFailureMessage(
            'The book could not be updated.',
            error,
          ),
        ),
      );
    }
  }

  void _refresh(LibraryState next) {
    emit(
      next.copyWith(
        sections: _buildSections(
          _visibleBooks(next.books, source: next),
          next.grouping,
        ),
      ),
    );
  }

  List<Audiobook> _visibleBooks(List<Audiobook> books, {LibraryState? source}) {
    final current = source ?? state;
    final query = current.query.trim().toLowerCase();
    final visible = books.where((book) {
      final matchesQuery =
          query.isEmpty ||
          [
            book.title,
            book.author,
            book.narrator,
            book.series,
            book.folder,
          ].any((value) => value.toLowerCase().contains(query));
      final matchesFilter = switch (current.filter) {
        LibraryFilter.all => true,
        LibraryFilter.favorites => book.isFavorite,
        LibraryFilter.wantToListen =>
          book.listeningStatus == ListeningStatus.wantToListen,
        LibraryFilter.notStarted =>
          book.listeningStatus == ListeningStatus.notStarted,
        LibraryFilter.inProgress =>
          book.listeningStatus == ListeningStatus.inProgress,
        LibraryFilter.finished =>
          book.listeningStatus == ListeningStatus.finished,
      };
      return matchesQuery && matchesFilter;
    }).toList();
    visible.sort(
      (left, right) => switch (current.sort) {
        LibrarySort.recent => (right.lastPlayedAt ?? right.addedAt).compareTo(
          left.lastPlayedAt ?? left.addedAt,
        ),
        LibrarySort.title => left.title.toLowerCase().compareTo(
          right.title.toLowerCase(),
        ),
        LibrarySort.author => left.author.toLowerCase().compareTo(
          right.author.toLowerCase(),
        ),
        LibrarySort.remaining => left.remainingDuration.compareTo(
          right.remainingDuration,
        ),
        LibrarySort.added => right.addedAt.compareTo(left.addedAt),
      },
    );
    return visible;
  }

  List<LibrarySection> _buildSections(
    List<Audiobook> books,
    LibraryGrouping grouping,
  ) {
    if (grouping == LibraryGrouping.none) {
      return [LibrarySection(title: '', books: books)];
    }
    final grouped = <String, List<Audiobook>>{};
    for (final book in books) {
      final key = switch (grouping) {
        LibraryGrouping.none => '',
        LibraryGrouping.listeningStatus => switch (book.listeningStatus) {
          ListeningStatus.wantToListen => 'Want to listen',
          ListeningStatus.notStarted => 'Not started',
          ListeningStatus.inProgress => 'Listening',
          ListeningStatus.finished => 'Finished',
        },
        LibraryGrouping.author =>
          book.author.trim().isEmpty ? 'Unknown author' : book.author.trim(),
        LibraryGrouping.series =>
          book.series.trim().isEmpty ? 'No series' : book.series.trim(),
        LibraryGrouping.folder =>
          book.folder.trim().isEmpty ? 'Imported' : book.folder.trim(),
      };
      grouped.putIfAbsent(key, () => []).add(book);
    }
    final keys = grouped.keys.toList()..sort();
    return keys
        .map((key) => LibrarySection(title: key, books: grouped[key]!))
        .toList();
  }
}
