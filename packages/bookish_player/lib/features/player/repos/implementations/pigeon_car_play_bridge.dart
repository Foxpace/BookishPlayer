import 'dart:async';
import 'dart:io';

import '../../../library/models/library_models.dart';
import '../../../library/repos/observable_audiobook_catalog_repository.dart';
import '../../use_cases/playback_command_service.dart';
import 'car_play_api.g.dart';

class PigeonCarPlayBridge extends CarPlayFlutterApi {
  PigeonCarPlayBridge(this._books, this._commands);

  final ObservableAudiobookCatalogRepository _books;
  final PlaybackCommandService _commands;
  final _host = CarPlayHostApi();
  StreamSubscription<List<Audiobook>>? _subscription;

  Future<void> initialize() async {
    if (!Platform.isIOS) {
      return;
    }
    CarPlayFlutterApi.setUp(this);
    _subscription = _books.watchBooks().listen(
      (books) => unawaited(_publish(books)),
    );
    await _publish(await _books.getBooks());
  }

  Future<void> _publish(List<Audiobook> books) => _host.updateLibrary([
    for (final book in books)
      CarBookItem(
        id: book.id,
        title: book.title,
        author: book.author,
        series: book.series,
        artworkPath: book.artworkPath,
        durationMs: book.durationMs,
        positionMs: book.positionMs,
      ),
  ]);

  @override
  void playBook(String id) {
    unawaited(_commands.playBook(id));
  }

  Future<void> dispose() async {
    await _subscription?.cancel();
    CarPlayFlutterApi.setUp(null);
  }
}
