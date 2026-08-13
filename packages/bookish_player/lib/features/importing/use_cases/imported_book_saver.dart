import 'package:injectable/injectable.dart';

import '../../../core/foundation/clock.dart';
import '../../../core/foundation/id_generator.dart';
import '../../library/models/library_models.dart';
import '../../library/repos/audiobook_catalog_repository.dart';
import '../../library/repos/book_metadata_repository.dart';
import '../repos/audiobook_metadata_extractor.dart';

typedef ImportedBookDraft = ({
  String path,
  Duration duration,
  List<AudioChapter> chapters,
  ImportedAudiobookMetadata metadata,
  String title,
  String? artworkPath,
});

@injectable
class ImportedBookSaver {
  const ImportedBookSaver(
    this._books,
    this._bookMetadata,
    this._clock,
    this._ids,
  );

  final AudiobookCatalogRepository _books;
  final BookMetadataRepository _bookMetadata;
  final Clock _clock;
  final IdGenerator _ids;

  Future<BookMetadata?> findArchivedMetadata({
    required String title,
    required String author,
    required Duration duration,
  }) => _bookMetadata.findBookMetadata(
    bookMetadataFingerprint(
      title: title,
      author: author,
      durationMs: duration.inMilliseconds,
    ),
  );

  Future<void> save(ImportedBookDraft draft) => _books.saveBook(
    Audiobook(
      id: _ids.generate(),
      title: draft.title,
      filePath: draft.path,
      durationMs: draft.duration.inMilliseconds,
      addedAt: _clock.now(),
      author: draft.metadata.author ?? '',
      series: draft.metadata.series ?? '',
      narrator: draft.metadata.narrator ?? '',
      year: draft.metadata.year,
      chapters: draft.chapters,
      artworkPath: draft.artworkPath,
      artworkScanned: true,
    ),
  );
}
