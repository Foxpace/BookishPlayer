import 'package:injectable/injectable.dart';

import '../models/chapter_parse_report.dart';
import '../repos/audiobook_artwork_extractor.dart';
import '../repos/audiobook_metadata_extractor.dart';
import '../repos/file_import_repository.dart';
import '../repos/selected_audio_file.dart';
import '../repos/m4b_chapter_parser.dart';
import '../repos/media_probe.dart';

typedef ImportedAudioDetails = ({
  Duration duration,
  ChapterParseReport chapterReport,
  ImportedAudiobookMetadata metadata,
});

@injectable
class ImportSourceGateway {
  const ImportSourceGateway(
    this._files,
    this._mediaProbe,
    this._chapters,
    this._artwork,
    this._metadata,
  );

  final FileImportRepository _files;
  final MediaProbe _mediaProbe;
  final M4bChapterParser _chapters;
  final AudiobookArtworkExtractor _artwork;
  final AudiobookMetadataExtractor _metadata;

  Future<List<SelectedAudioFile>> selectFiles({required bool transferred}) =>
      transferred
      ? _files.findTransferredAudioFiles()
      : _files.pickAudioFiles();

  Future<ImportedAudioFile> importFile(
    SelectedAudioFile selected, {
    FileCopyProgress? onProgress,
  }) => _files.importFile(selected, onProgress: onProgress);

  Future<ImportedAudioDetails> readDetails(String path) async {
    final (duration, chapterReport, metadata) = await (
      _mediaProbe.probeDuration(path),
      _chapters.analyze(path),
      _metadata.extract(path),
    ).wait;
    return (
      duration: duration,
      chapterReport: chapterReport,
      metadata: metadata,
    );
  }

  Future<String?> extractArtwork(String path) => _artwork.extract(path);

  Future<void> removeTransferredFiles(List<SelectedAudioFile> selected) =>
      _files.removeTransferredAudioFiles(selected);
}
