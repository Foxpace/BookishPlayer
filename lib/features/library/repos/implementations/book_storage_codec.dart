import '../../models/library_models.dart';
import '../../models/listening_session.dart';
import '../../../notes/models/note_models.dart';

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
      'completedAt': metadata.completedAt?.toIso8601String(),
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

BookNote parseStoredNote(String id, Map<String, dynamic> value) {
  try {
    return BookNote.fromJson(value);
  } catch (error) {
    throw FormatException('Could not parse note record "$id": $error');
  }
}

BookMetadata parseStoredMetadata(String id, Map<String, dynamic> value) {
  try {
    return BookMetadata.fromJson(value);
  } catch (error) {
    throw FormatException(
      'Could not parse audiobook metadata record "$id": $error',
    );
  }
}
