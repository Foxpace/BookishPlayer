import 'package:injectable/injectable.dart';

import '../../player/domain/book_note.dart';
import '../domain/audiobook.dart';
import '../domain/audiobook_repository.dart';
import '../domain/observable_audiobook_catalog_repository.dart';
import '../domain/listening_session.dart';
import 'audiobook_dao.dart';

@LazySingleton(as: AudiobookRepository)
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
  Future<void> deleteBook(String id) => _dao.deleteBook(id);

  @override
  Future<List<BookNote>> getNotes(String bookId) => _dao.getNotes(bookId);

  @override
  Future<void> saveNote(BookNote note) => _dao.putNote(note);

  @override
  Future<void> deleteNote(String id) => _dao.deleteNote(id);

  @override
  Future<List<BookNote>> getAllNotes() => _dao.getAllNotes();

  @override
  Future<List<ListeningSession>> getListeningSessions() =>
      _dao.getListeningSessions();

  @override
  Future<void> saveListeningSession(ListeningSession session) =>
      _dao.putListeningSession(session);

  @override
  Future<void> replaceListeningSessions(List<ListeningSession> sessions) =>
      _dao.replaceListeningSessions(sessions);

  @override
  Future<void> replaceLibrary(List<Audiobook> books, List<BookNote> notes) =>
      _dao.replaceLibrary(books, notes);
}
