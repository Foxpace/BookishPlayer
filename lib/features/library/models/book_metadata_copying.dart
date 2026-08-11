import 'book_metadata.dart';

extension BookMetadataCopying on BookMetadata {
  BookMetadata preserveArchivedValues(BookMetadata? archived) => copyWith(
    artworkPath: artworkPath ?? archived?.artworkPath,
    completedAt: completedAt ?? archived?.completedAt,
  );
}
