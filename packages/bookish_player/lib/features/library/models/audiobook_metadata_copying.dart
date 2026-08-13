import 'audiobook.dart';
import 'book_metadata.dart';

extension AudiobookMetadataCopying on Audiobook {
  BookMetadata toBookMetadata({String? metadataId, DateTime? createdAt}) =>
      BookMetadata(
        id: metadataId ?? (this.metadataId.isEmpty ? id : this.metadataId),
        fingerprint: bookMetadataFingerprint(
          title: title,
          author: author,
          durationMs: durationMs,
        ),
        activeBookId: id,

        title: title,
        author: author,
        series: series,
        narrator: narrator,
        year: year,
        folder: folder,
        seriesPosition: seriesPosition,
        completedAt: completedAt,

        durationMs: durationMs,
        artworkPath: artworkPath,
        artworkScanned: artworkScanned,
        chapters: chapters,

        createdAt: createdAt ?? DateTime.now(),
      );
}
