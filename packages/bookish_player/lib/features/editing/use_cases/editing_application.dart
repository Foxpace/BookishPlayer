import 'package:injectable/injectable.dart';

import '../../../core/foundation/result.dart';
import '../../library/models/library_models.dart';
import '../models/editable_book_details.dart';
import '../repos/book_editing_repository.dart';

@injectable
class EditingApplication {
  const EditingApplication(this._books);

  final BookEditingRepository _books;

  Future<Result<Audiobook>> loadBook(String bookId) async {
    try {
      return await _loadBook(bookId);
    } catch (error) {
      return Result.failure(
        AppFailure.operationFailed('editing.load', error: error),
      );
    }
  }

  Future<Result<Audiobook>> _loadBook(String bookId) async {
    final book = await _books.loadBook(bookId);
    return book == null
        ? const Result.failure(AppFailure.notFound('editing.book'))
        : Result.success(book);
  }

  Future<Result<Audiobook>> editDetails(
    Audiobook book,
    EditableBookDetails details,
  ) => _save(
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

  Future<Result<Audiobook>> changeCover(Audiobook book) async {
    try {
      return await _changeCover(book);
    } catch (error) {
      return Result.failure(
        AppFailure.operationFailed('editing.save', error: error),
      );
    }
  }

  Future<Result<Audiobook>> _changeCover(Audiobook book) async {
    final path = await _books.pickCover(book.id);
    if (path == null) {
      return Result.success(book);
    }
    final updated = book.withScannedArtwork(path);
    await _books.saveBook(updated);

    final oldPath = book.artworkPath;
    if (oldPath != null && oldPath != path) {
      await _books.deleteImportedFile(oldPath);
    }
    return Result.success(updated);
  }

  Future<Result<Audiobook>> reorderTracks(
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

  Future<Result<Audiobook>> addChapter(
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

  Future<Result<Audiobook>> deleteChapter(
    Audiobook book,
    AudioChapter chapter,
  ) => _save(
    book.copyWith(
      chapters: book.chapters.where((item) => item != chapter).toList(),
    ),
  );

  int? _parseYear(String value) {
    final parsed = int.tryParse(value.trim());
    return parsed != null && parsed >= 1000 && parsed <= 2999 ? parsed : null;
  }

  Future<Result<Audiobook>> _save(Audiobook book) async {
    try {
      return await _saveBook(book);
    } catch (error) {
      return Result.failure(
        AppFailure.operationFailed('editing.save', error: error),
      );
    }
  }

  Future<Result<Audiobook>> _saveBook(Audiobook book) async {
    await _books.saveBook(book);
    return Result.success(book);
  }
}
