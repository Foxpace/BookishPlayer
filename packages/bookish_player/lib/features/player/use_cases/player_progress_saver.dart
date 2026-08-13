import 'package:injectable/injectable.dart';

import '../../../core/foundation/clock.dart';
import '../../library/models/library_models.dart';
import '../../library/repos/audiobook_catalog_repository.dart';

@injectable
class PlayerProgressSaver {
  const PlayerProgressSaver(this._books, this._clock);

  final AudiobookCatalogRepository _books;
  final Clock _clock;

  bool checkpointDue(DateTime lastSavedAt) =>
      _clock.now().difference(lastSavedAt) >= const Duration(milliseconds: 250);

  Future<DateTime?> save(Audiobook? book, Duration position) async {
    if (book == null) {
      return null;
    }
    await _books.updateProgress(book.id, position);
    return _clock.now();
  }
}
