import 'package:injectable/injectable.dart';

import '../../library/models/library_models.dart';
import '../models/editable_book_details.dart';
import '../repos/book_editing_repository.dart';

@injectable
class EditingApplication {
  const EditingApplication(this._books);

  final BookEditingRepository _books;

  Future<Audiobook> loadBook(String bookId) async {
    final book = await _books.loadBook(bookId);
    if (book == null) {
      throw StateError('Audiobook "$bookId" was not found.');
    }
    return book;
  }

  Future<Audiobook> editDetails(Audiobook book, EditableBookDetails details) =>
      _save(
        book.copyWith(
          title: details.title.trim(),
          author: details.author.trim(),
          series: details.series.trim(),
          seriesPosition: double.tryParse(details.seriesPosition.trim()),
          narrator: details.narrator.trim(),
          year: _parseYear(details.year),
          folder: details.folder.trim().isEmpty
              ? 'Imported'
              : details.folder.trim(),
        ),
      );

  Future<Audiobook> changeCover(Audiobook book) async {
    final path = await _books.pickCover(book.id);
    if (path == null) {
      return book;
    }
    final updated = book.withScannedArtwork(path);
    await _books.saveBook(updated);

    final oldPath = book.artworkPath;
    if (oldPath != null && oldPath != path) {
      await _books.deleteImportedFile(oldPath);
    }
    return updated;
  }

  Future<Audiobook> reorderTracks(
    Audiobook book,
    int oldIndex,
    int newIndex,
  ) async {
    final tracks = [...book.playableTracks];
    final moved = tracks.removeAt(oldIndex);
    tracks.insert(newIndex, moved);
    return _save(
      book.copyWith(
        tracks: [
          for (var index = 0; index < tracks.length; index++)
            tracks[index].copyWith(order: index),
        ],
      ),
    );
  }

  Future<Audiobook> addChapter(
    Audiobook book,
    String title,
    Duration position,
  ) {
    final chapters = [
      ...book.chapters,
      AudioChapter(title: title.trim(), startMs: position.inMilliseconds),
    ]..sort((left, right) => left.startMs.compareTo(right.startMs));
    return _save(book.copyWith(chapters: chapters));
  }

  Future<Audiobook> deleteChapter(Audiobook book, AudioChapter chapter) =>
      _save(
        book.copyWith(
          chapters: book.chapters.where((item) => item != chapter).toList(),
        ),
      );

  int? _parseYear(String value) {
    final parsed = int.tryParse(value.trim());
    return parsed != null && parsed >= 1000 && parsed <= 2999 ? parsed : null;
  }

  Future<Audiobook> _save(Audiobook book) async {
    await _books.saveBook(book);
    return book;
  }
}
