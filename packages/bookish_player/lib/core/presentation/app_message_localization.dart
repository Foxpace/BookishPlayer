import 'package:flutter/widgets.dart';
import '../localization/generated/l10n.dart';
import 'app_message.dart';

extension AppMessageLocalization on AppMessage {
  String localize(BuildContext context) {
    final l10n = S.of(context);
    return switch (this) {
      AppMessage.storageInspectFailed => l10n.storageInspectFailed,
      AppMessage.unusedFilesRemoved => l10n.unusedFilesRemoved,
      AppMessage.allDataRemoved => l10n.allDataRemoved,
      AppMessage.allDataRemovedSettingsReloadFailed =>
        l10n.allDataRemovedSettingsReloadFailed,
      AppMessage.clearDataFailed => l10n.clearDataFailed,
      AppMessage.metadataEditorLoadFailed => l10n.metadataEditorLoadFailed,
      AppMessage.metadataSaveFailed => l10n.metadataSaveFailed,
      AppMessage.notesLoadFailed => l10n.notesLoadFailed,
      AppMessage.speechRecognitionUnavailable =>
        l10n.speechRecognitionUnavailable,
      AppMessage.speechRecognitionFailed => l10n.speechRecognitionFailed,
      AppMessage.settingsLoadFailed => l10n.settingsLoadFailed,
      AppMessage.playbackSettingsSaveFailed => l10n.playbackSettingsSaveFailed,
      AppMessage.appearanceSettingsSaveFailed =>
        l10n.appearanceSettingsSaveFailed,
      AppMessage.speechModelsLoadFailed => l10n.speechModelsLoadFailed,
      AppMessage.speechModelDownloaded => l10n.speechModelDownloaded,
      AppMessage.speechModelDownloadFailed => l10n.speechModelDownloadFailed,
      AppMessage.noSpeechDetected => l10n.noSpeechDetected,
      AppMessage.quoteTranscriptionFailed => l10n.quoteTranscriptionFailed,
      AppMessage.libraryLoadFailed => l10n.libraryLoadFailed,
      AppMessage.bookRemovalFailed => l10n.bookRemovalFailed,
      AppMessage.libraryLayoutSaveFailed => l10n.libraryLayoutSaveFailed,
      AppMessage.bookUpdateFailed => l10n.bookUpdateFailed,
      AppMessage.listeningInsightsLoadFailed =>
        l10n.listeningInsightsLoadFailed,
      AppMessage.audiobookPlaybackFailed => l10n.audiobookPlaybackFailed,
      AppMessage.audiobookOpenFailed => l10n.audiobookOpenFailed,
    };
  }
}
