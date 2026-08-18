import 'package:injectable/injectable.dart';

import '../../../notes/models/book_note.dart';

import '../../models/library_models.dart';
import '../../models/audiobook_removal_mode.dart';
import '../audiobook_repository.dart';
import '../observable_audiobook_catalog_repository.dart';
import 'audiobook_dao.dart';

@lazySingleton
class SembastAudiobookRepository
    implements AudiobookRepository, ObservableAudiobookCatalogRepository {
  SembastAudiobookRepository(this._dao);

  final AudiobookDao _dao;

  @override
  Future<List<Audiobook>> getBooks() => _dao.getBooks();

  @override
  Stream<List<Audiobook>> watchBooks() => _dao.watchBooks();

  @override
  Future<Audiobook?> getBook(String id) => _dao.getBook(id);

  @override
  Future<void> saveBook(Audiobook book) => _dao.putBook(book);

  @override
  Future<void> updateProgress(String id, Duration position) =>
      _dao.updateProgress(id, position);

  @override
  Future<void> updatePlaybackSpeed(String id, double speed) =>
      _dao.updatePlaybackSpeed(id, speed);

  @override
  Future<void> deleteBook(
    String id, {
    AudiobookRemovalMode mode = AudiobookRemovalMode.keepUserData,
  }) => _dao.deleteBook(id, mode: mode);

  @override
  Future<List<BookNote>> getNotes(String bookId) => _dao.getNotes(bookId);

  @override
  Future<void> saveNote(BookNote note) => _dao.putNote(note);

  @override
  Future<void> deleteNote(String id) => _dao.deleteNote(id);

  @override
  Future<List<BookNote>> getAllNotes() => _dao.getAllNotes();

  @override
  Future<List<BookMetadata>> getBookMetadata() => _dao.getBookMetadata();

  @override
  Future<BookMetadata?> findBookMetadata(String fingerprint) =>
      _dao.findBookMetadata(fingerprint);

  @override
  Future<void> replaceLibrary(List<Audiobook> books, List<BookNote> notes) =>
      _dao.replaceLibrary(books, notes);
}
