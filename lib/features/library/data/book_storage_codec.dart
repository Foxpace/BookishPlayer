import '../domain/audiobook.dart';
import '../domain/book_metadata.dart';
import '../domain/listening_session.dart';
import '../../player/domain/book_note.dart';

const _metadataKeys = {
  'title',
  'author',
  'series',
  'narrator',
  'year',
  'folder',
  'seriesPosition',
  'completedAt',
  'durationMs',
  'artworkPath',
  'artworkScanned',
  'chapters',
};

Map<String, dynamic> bookStorageJson(Audiobook book, String metadataId) {
  final json = book.toJson()..['metadataId'] = metadataId;
  for (final key in _metadataKeys) {
    json.remove(key);
  }
  return json;
}

Audiobook hydrateBook(Map<String, dynamic> stored, BookMetadata metadata) =>
    Audiobook.fromJson({
      ...stored,
      'metadataId': metadata.id,
      'title': metadata.title,
      'author': metadata.author,
      'series': metadata.series,
      'narrator': metadata.narrator,
      'year': metadata.year,
      'folder': metadata.folder,
      'seriesPosition': metadata.seriesPosition,
      'completedAt': metadata.completedAt,
      'durationMs': metadata.durationMs,
      'artworkPath': metadata.artworkPath,
      'artworkScanned': metadata.artworkScanned,
      'chapters': metadata.chapters.map((chapter) => chapter.toJson()).toList(),
    });

Map<String, dynamic> noteStorageJson(BookNote note, String metadataId) {
  return note.copyWith(metadataId: metadataId).toJson();
}

Map<String, dynamic> listeningSessionStorageJson(
  ListeningSession session,
  String metadataId,
) {
  return session.copyWith(metadataId: metadataId).toJson();
}
