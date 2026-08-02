import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../importing/domain/file_import_repository.dart';
import '../../importing/domain/audiobook_artwork_extractor.dart';
import '../domain/audiobook.dart';
import '../domain/audiobook_repository.dart';
import 'library_state.dart';

@injectable
class LibraryCubit extends Cubit<LibraryState> {
  LibraryCubit(this._books, this._files, this._artwork)
    : super(const LibraryState());

  final AudiobookRepository _books;
  final FileImportRepository _files;
  final AudiobookArtworkExtractor _artwork;

  Future<void> load() async {
    emit(state.copyWith(status: LibraryStatus.loading, message: null));
    try {
      final savedBooks = await _books.getBooks();
      final books = <Audiobook>[];
      for (final book in savedBooks) {
        if (book.artworkScanned) {
          books.add(book);
          continue;
        }
        final artworkPath = await _artwork.extract(book.filePath);
        final updated = book.copyWith(
          artworkPath: artworkPath,
          artworkScanned: true,
        );
        await _books.saveBook(updated);
        books.add(updated);
      }
      emit(
        state.copyWith(
          status: LibraryStatus.ready,
          books: books,
          sections: _buildSections(books, state.grouping),
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: LibraryStatus.failure,
          message: 'Could not open your library.',
        ),
      );
    }
  }

  Future<void> deleteBook(Audiobook book) async {
    try {
      await _books.deleteBook(book.id);
      final paths = book.playableTracks.map((track) => track.filePath).toSet();
      for (final path in paths) {
        await _files.deleteImportedFile(path);
      }
      final artworkPath = book.artworkPath;
      if (artworkPath != null) {
        await _files.deleteImportedFile(artworkPath);
      }
      emit(
        state.copyWith(
          books: state.books.where((item) => item.id != book.id).toList(),
          sections: _buildSections(
            state.books.where((item) => item.id != book.id).toList(),
            state.grouping,
          ),
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: LibraryStatus.failure,
          message: 'The book could not be removed.',
        ),
      );
    }
  }

  void clearMessage() {
    emit(state.copyWith(status: LibraryStatus.ready, message: null));
  }

  void setGrouping(LibraryGrouping grouping) {
    emit(
      state.copyWith(
        grouping: grouping,
        sections: _buildSections(state.books, grouping),
      ),
    );
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
