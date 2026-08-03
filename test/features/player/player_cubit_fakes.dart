part of 'player_cubit_test.dart';

class _FakeAudioPlayer implements AudioPlayerRepository {
  final _positions = StreamController<Duration>.broadcast();
  final _buffers = StreamController<Duration>.broadcast();
  final _durations = StreamController<Duration?>.broadcast();
  final _playing = StreamController<bool>.broadcast();
  final _completed = StreamController<bool>.broadcast();
  Duration currentPosition = Duration.zero;
  var speed = 1.0;
  var playing = false;
  var pauseCount = 0;

  void emitPosition(Duration value) {
    currentPosition = value;
    _positions.add(value);
  }

  Future<void> close() async {
    await _positions.close();
    await _buffers.close();
    await _durations.close();
    await _playing.close();
    await _completed.close();
  }

  @override
  Stream<Duration> get positionStream => _positions.stream;
  @override
  Stream<Duration> get bufferedPositionStream => _buffers.stream;
  @override
  Stream<Duration?> get durationStream => _durations.stream;
  @override
  Stream<bool> get playingStream => _playing.stream;
  @override
  Stream<bool> get completedStream => _completed.stream;
  @override
  Duration get position => currentPosition;
  @override
  bool get isPlaying => playing;
  @override
  Future<Duration> probeDuration(String path) async => Duration.zero;
  @override
  Future<void> load(Audiobook book) async {
    currentPosition = Duration(milliseconds: book.positionMs);
  }

  @override
  Future<void> play() async {
    playing = true;
    _playing.add(true);
  }

  @override
  Future<void> pause() async {
    pauseCount++;
    playing = false;
    _playing.add(false);
  }

  @override
  Future<void> seek(Duration position) async {
    currentPosition = position;
  }

  @override
  Future<void> setSpeed(double speed) async {
    this.speed = speed;
  }

  @override
  Future<void> dispose() async {}
}

class _FakeBooks implements AudiobookRepository {
  _FakeBooks(this.book) : _books = {book.id: book};

  _FakeBooks.withBooks(List<Audiobook> books)
    : book = books.first,
      _books = {for (final book in books) book.id: book};

  Audiobook book;
  final Map<String, Audiobook> _books;
  Duration? progress;
  double? savedSpeed;
  BookNote? savedNote;

  @override
  Future<Audiobook?> getBook(String id) async => _books[id];
  @override
  Future<List<Audiobook>> getBooks() async => _books.values.toList();
  @override
  Future<void> saveBook(Audiobook book) async {
    this.book = book;
    _books[book.id] = book;
  }

  @override
  Future<void> updateProgress(String id, Duration position) async {
    progress = position;
    final stored = _books[id];
    if (stored != null) {
      final updated = stored.copyWith(positionMs: position.inMilliseconds);
      _books[id] = updated;
      if (book.id == id) {
        book = updated;
      }
    }
  }

  @override
  Future<void> updatePlaybackSpeed(String id, double speed) async =>
      savedSpeed = speed;
  @override
  Future<List<BookNote>> getNotes(String bookId) async => [];
  @override
  Future<List<BookNote>> getAllNotes() async => [];
  @override
  Future<void> saveNote(BookNote note) async => savedNote = note;
  @override
  Future<void> deleteNote(String id) async {}
  @override
  Future<void> deleteBook(String id) async {}
  @override
  Future<void> replaceLibrary(
    List<Audiobook> books,
    List<BookNote> notes,
  ) async {}
}

class _FakeExports implements LocalExportRepository {
  @override
  Future<bool> exportBackup(Map<String, dynamic> backup) async => true;
  @override
  Future<bool> exportNotes(Audiobook book, List<BookNote> notes) async => true;
  @override
  Future<Map<String, dynamic>?> pickBackup() async => null;
}
