import 'package:flutter/widgets.dart';

import '../../../../core/localization/generated/l10n.dart';
import '../../models/import_models.dart';
import '../../cubits/import_cubits.dart';

part 'import_detail_localization.dart';

extension ImportHeadingLocalization on ImportHeading {
  String localize(BuildContext context) {
    final l10n = S.of(context);
    return switch (this) {
      ImportHeading.openingFileBrowser => l10n.importOpeningFileBrowser,
      ImportHeading.preparingSelection => l10n.importPreparingSelection,
      ImportHeading.copyingAudiobook => l10n.importCopyingAudiobook,
      ImportHeading.readingAudioInformation =>
        l10n.importReadingAudioInformation,
      ImportHeading.analyzingChapters => l10n.importAnalyzingChapters,
      ImportHeading.extractingArtwork => l10n.importExtractingArtwork,
      ImportHeading.savingToLibrary => l10n.importSavingToLibrary,
      ImportHeading.removingOriginals => l10n.importRemovingOriginals,
      ImportHeading.noTransferredAudiobooks =>
        l10n.importNoTransferredAudiobooks,
      ImportHeading.noFilesSelected => l10n.importNoFilesSelected,
      ImportHeading.originalsRemain => l10n.importOriginalsRemain,
      ImportHeading.fileAccessFailed => l10n.importFileAccessFailed,
      ImportHeading.malformedMetadata => l10n.importMalformedMetadata,
      ImportHeading.importFailed => l10n.importFailed,
    };
  }
}

String _localizeImportStage(S l10n, ImportStage? stage) => switch (stage) {
  ImportStage.selectingFiles => l10n.importStageSelectingFiles,
  ImportStage.copyingFile => l10n.importStageCopyingFile,
  ImportStage.readingDuration => l10n.importStageReadingDuration,
  ImportStage.analyzingChapters => l10n.importStageAnalyzingChapters,
  ImportStage.extractingArtwork => l10n.importStageExtractingArtwork,
  ImportStage.savingBook => l10n.importStageSavingBook,
  ImportStage.removingOriginals => l10n.importStageRemovingOriginals,
  null => l10n.importStageUnknown,
};

String _formatByteCount(int bytes) {
  if (bytes >= 1024 * 1024 * 1024) {
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }
  if (bytes >= 1024 * 1024) {
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
  if (bytes >= 1024) {
    return '${(bytes / 1024).toStringAsFixed(1)} KB';
  }
  return '$bytes B';
}
