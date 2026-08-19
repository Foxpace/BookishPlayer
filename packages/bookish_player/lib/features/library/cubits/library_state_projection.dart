import '../models/library_models.dart';
import 'library_cubits.dart';

typedef _SectionKey = ({LibrarySectionLabel? label, String title});

extension LibraryStateProjection on LibraryState {
  LibraryState projectView() =>
      copyWith(sections: _buildSections(_selectVisibleBooks(), grouping));

  List<Audiobook> _selectVisibleBooks() {
    final normalizedQuery = query.trim().toLowerCase();
    final visible = books
        .where(
          (book) =>
              _matchesQuery(book, normalizedQuery) &&
              _matchesFilter(book, filter),
        )
        .toList();

    visible.sort((left, right) => _compareBooks(left, right, sort));
    return visible;
  }

  bool _matchesQuery(Audiobook book, String value) {
    if (value.isEmpty) {
      return true;
    }

    return [
      book.title,
      book.author,
      book.narrator,
      book.series,
      book.folder,
    ].any((candidate) => candidate.toLowerCase().contains(value));
  }

  bool _matchesFilter(Audiobook book, LibraryFilter value) => switch (value) {
    LibraryFilter.all => true,
    LibraryFilter.favorites => book.isFavorite,
    LibraryFilter.wantToListen =>
      book.listeningStatus == ListeningStatus.wantToListen,
    LibraryFilter.notStarted =>
      book.listeningStatus == ListeningStatus.notStarted,
    LibraryFilter.inProgress =>
      book.listeningStatus == ListeningStatus.inProgress,
    LibraryFilter.finished => book.listeningStatus == ListeningStatus.finished,
  };

  int _compareBooks(Audiobook left, Audiobook right, LibrarySort value) =>
      switch (value) {
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
      };

  List<LibrarySection> _buildSections(
    List<Audiobook> visible,
    LibraryGrouping value,
  ) {
    if (value == LibraryGrouping.none) {
      return [LibrarySection(books: visible)];
    }

    final grouped = <_SectionKey, List<Audiobook>>{};
    for (final book in visible) {
      final key = _sectionKey(book, value);
      grouped.putIfAbsent(key, () => []).add(book);
    }

    final keys = grouped.keys.toList()
      ..sort((left, right) => left.title.compareTo(right.title));

    return [
      for (final key in keys)
        LibrarySection(
          title: key.title,
          label: key.label,
          books: grouped[key] ?? const [],
        ),
    ];
  }

  _SectionKey _sectionKey(Audiobook book, LibraryGrouping value) =>
      switch (value) {
        LibraryGrouping.none => (label: null, title: ''),
        LibraryGrouping.listeningStatus => _listeningStatusKey(
          book.listeningStatus,
        ),
        LibraryGrouping.author => _textKey(
          book.author,
          LibrarySectionLabel.unknownAuthor,
        ),
        LibraryGrouping.series => _textKey(
          book.series,
          LibrarySectionLabel.noSeries,
        ),
        LibraryGrouping.folder => _textKey(
          book.folder,
          LibrarySectionLabel.imported,
        ),
      };

  _SectionKey _listeningStatusKey(ListeningStatus status) => switch (status) {
    ListeningStatus.wantToListen => (
      label: LibrarySectionLabel.wantToListen,
      title: '',
    ),
    ListeningStatus.notStarted => (
      label: LibrarySectionLabel.notStarted,
      title: '',
    ),
    ListeningStatus.inProgress => (
      label: LibrarySectionLabel.listening,
      title: '',
    ),
    ListeningStatus.finished => (
      label: LibrarySectionLabel.finished,
      title: '',
    ),
  };

  _SectionKey _textKey(String value, LibrarySectionLabel emptyLabel) {
    final text = value.trim();
    return text.isEmpty
        ? (label: emptyLabel, title: '')
        : (label: null, title: text);
  }
}
