// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Bookish`
  String get appTitle {
    return Intl.message('Bookish', name: 'appTitle', desc: '', args: []);
  }

  /// `A quiet, offline-first audiobook player.`
  String get appDescription {
    return Intl.message(
      'A quiet, offline-first audiobook player.',
      name: 'appDescription',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settingsTitle {
    return Intl.message('Settings', name: 'settingsTitle', desc: '', args: []);
  }

  /// `Appearance`
  String get appearanceTitle {
    return Intl.message(
      'Appearance',
      name: 'appearanceTitle',
      desc: '',
      args: [],
    );
  }

  /// `Choose how Bookish looks on this device.`
  String get appearanceDescription {
    return Intl.message(
      'Choose how Bookish looks on this device.',
      name: 'appearanceDescription',
      desc: '',
      args: [],
    );
  }

  /// `Follow system`
  String get themeFollowSystem {
    return Intl.message(
      'Follow system',
      name: 'themeFollowSystem',
      desc: '',
      args: [],
    );
  }

  /// `Match your device appearance automatically`
  String get themeFollowSystemDescription {
    return Intl.message(
      'Match your device appearance automatically',
      name: 'themeFollowSystemDescription',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get themeLight {
    return Intl.message('Light', name: 'themeLight', desc: '', args: []);
  }

  /// `Warm paper and dark ink`
  String get themeLightDescription {
    return Intl.message(
      'Warm paper and dark ink',
      name: 'themeLightDescription',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get themeDark {
    return Intl.message('Dark', name: 'themeDark', desc: '', args: []);
  }

  /// `Comfortable listening after lights out`
  String get themeDarkDescription {
    return Intl.message(
      'Comfortable listening after lights out',
      name: 'themeDarkDescription',
      desc: '',
      args: [],
    );
  }

  /// `Use Android system colors`
  String get systemColorsTitle {
    return Intl.message(
      'Use Android system colors',
      name: 'systemColorsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Match colors to your wallpaper on Android 12 and newer`
  String get systemColorsDescription {
    return Intl.message(
      'Match colors to your wallpaper on Android 12 and newer',
      name: 'systemColorsDescription',
      desc: '',
      args: [],
    );
  }

  /// `App color`
  String get appColorTitle {
    return Intl.message('App color', name: 'appColorTitle', desc: '', args: []);
  }

  /// `Used when system colors are off or unavailable`
  String get appColorDescription {
    return Intl.message(
      'Used when system colors are off or unavailable',
      name: 'appColorDescription',
      desc: '',
      args: [],
    );
  }

  /// `Choose app color`
  String get chooseAppColorTitle {
    return Intl.message(
      'Choose app color',
      name: 'chooseAppColorTitle',
      desc: '',
      args: [],
    );
  }

  /// `Default color`
  String get defaultColor {
    return Intl.message(
      'Default color',
      name: 'defaultColor',
      desc: '',
      args: [],
    );
  }

  /// `Hue`
  String get colorHue {
    return Intl.message('Hue', name: 'colorHue', desc: '', args: []);
  }

  /// `Saturation`
  String get colorSaturation {
    return Intl.message(
      'Saturation',
      name: 'colorSaturation',
      desc: '',
      args: [],
    );
  }

  /// `Brightness`
  String get colorBrightness {
    return Intl.message(
      'Brightness',
      name: 'colorBrightness',
      desc: '',
      args: [],
    );
  }

  /// `Local transcription`
  String get localTranscriptionTitle {
    return Intl.message(
      'Local transcription',
      name: 'localTranscriptionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Choose and download the on-device speech model used to turn audiobook ranges into quotes.`
  String get localTranscriptionDescription {
    return Intl.message(
      'Choose and download the on-device speech model used to turn audiobook ranges into quotes.',
      name: 'localTranscriptionDescription',
      desc: '',
      args: [],
    );
  }

  /// `Speech-to-text model`
  String get speechToTextModel {
    return Intl.message(
      'Speech-to-text model',
      name: 'speechToTextModel',
      desc: '',
      args: [],
    );
  }

  /// `No speech models available`
  String get noSpeechModelsAvailable {
    return Intl.message(
      'No speech models available',
      name: 'noSpeechModelsAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Choose a model to use it. If needed, it downloads automatically. Audio and generated text stay on this device.`
  String get speechModelDescription {
    return Intl.message(
      'Choose a model to use it. If needed, it downloads automatically. Audio and generated text stay on this device.',
      name: 'speechModelDescription',
      desc: '',
      args: [],
    );
  }

  /// `Choose speech model`
  String get chooseSpeechModel {
    return Intl.message(
      'Choose speech model',
      name: 'chooseSpeechModel',
      desc: '',
      args: [],
    );
  }

  /// `Tap a model to select it. Models that are not on this device download automatically.`
  String get chooseSpeechModelDescription {
    return Intl.message(
      'Tap a model to select it. Models that are not on this device download automatically.',
      name: 'chooseSpeechModelDescription',
      desc: '',
      args: [],
    );
  }

  /// `Downloaded`
  String get modelDownloaded {
    return Intl.message(
      'Downloaded',
      name: 'modelDownloaded',
      desc: '',
      args: [],
    );
  }

  /// `Available to download`
  String get modelAvailableToDownload {
    return Intl.message(
      'Available to download',
      name: 'modelAvailableToDownload',
      desc: '',
      args: [],
    );
  }

  /// `Not downloaded`
  String get modelNotDownloaded {
    return Intl.message(
      'Not downloaded',
      name: 'modelNotDownloaded',
      desc: '',
      args: [],
    );
  }

  /// `Selected`
  String get modelSelected {
    return Intl.message('Selected', name: 'modelSelected', desc: '', args: []);
  }

  /// `{size} MB`
  String modelSize(num size) {
    return Intl.message('$size MB', name: 'modelSize', desc: '', args: [size]);
  }

  /// `Local data`
  String get localDataTitle {
    return Intl.message(
      'Local data',
      name: 'localDataTitle',
      desc: '',
      args: [],
    );
  }

  /// `Back up progress, notes, metadata, and settings without a cloud account.`
  String get localDataDescription {
    return Intl.message(
      'Back up progress, notes, metadata, and settings without a cloud account.',
      name: 'localDataDescription',
      desc: '',
      args: [],
    );
  }

  /// `Export backup`
  String get exportBackup {
    return Intl.message(
      'Export backup',
      name: 'exportBackup',
      desc: '',
      args: [],
    );
  }

  /// `Save a portable Bookish JSON file`
  String get exportBackupDescription {
    return Intl.message(
      'Save a portable Bookish JSON file',
      name: 'exportBackupDescription',
      desc: '',
      args: [],
    );
  }

  /// `Restore backup`
  String get restoreBackup {
    return Intl.message(
      'Restore backup',
      name: 'restoreBackup',
      desc: '',
      args: [],
    );
  }

  /// `Replace local library data from a backup`
  String get restoreBackupDescription {
    return Intl.message(
      'Replace local library data from a backup',
      name: 'restoreBackupDescription',
      desc: '',
      args: [],
    );
  }

  /// `Backup exported.`
  String get backupExported {
    return Intl.message(
      'Backup exported.',
      name: 'backupExported',
      desc: '',
      args: [],
    );
  }

  /// `Could not export the backup.`
  String get backupExportFailed {
    return Intl.message(
      'Could not export the backup.',
      name: 'backupExportFailed',
      desc: '',
      args: [],
    );
  }

  /// `Backup restored. Audio files must remain available locally.`
  String get backupRestored {
    return Intl.message(
      'Backup restored. Audio files must remain available locally.',
      name: 'backupRestored',
      desc: '',
      args: [],
    );
  }

  /// `This backup could not be restored.`
  String get backupRestoreFailed {
    return Intl.message(
      'This backup could not be restored.',
      name: 'backupRestoreFailed',
      desc: '',
      args: [],
    );
  }

  /// `This backup is invalid or incompatible.`
  String get invalidBackup {
    return Intl.message(
      'This backup is invalid or incompatible.',
      name: 'invalidBackup',
      desc: '',
      args: [],
    );
  }

  /// `Local diagnostics`
  String get diagnosticsTitle {
    return Intl.message(
      'Local diagnostics',
      name: 'diagnosticsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Bookish keeps a bounded, sanitized error log on this device. It never includes book titles, notes, transcripts, or audio.`
  String get diagnosticsDescription {
    return Intl.message(
      'Bookish keeps a bounded, sanitized error log on this device. It never includes book titles, notes, transcripts, or audio.',
      name: 'diagnosticsDescription',
      desc: '',
      args: [],
    );
  }

  /// `Export diagnostics`
  String get exportDiagnostics {
    return Intl.message(
      'Export diagnostics',
      name: 'exportDiagnostics',
      desc: '',
      args: [],
    );
  }

  /// `Delete diagnostics`
  String get deleteDiagnostics {
    return Intl.message(
      'Delete diagnostics',
      name: 'deleteDiagnostics',
      desc: '',
      args: [],
    );
  }

  /// `Diagnostics exported.`
  String get diagnosticsExported {
    return Intl.message(
      'Diagnostics exported.',
      name: 'diagnosticsExported',
      desc: '',
      args: [],
    );
  }

  /// `There are no diagnostics to export.`
  String get diagnosticsNoRecords {
    return Intl.message(
      'There are no diagnostics to export.',
      name: 'diagnosticsNoRecords',
      desc: '',
      args: [],
    );
  }

  /// `Diagnostics could not be exported.`
  String get diagnosticsExportFailed {
    return Intl.message(
      'Diagnostics could not be exported.',
      name: 'diagnosticsExportFailed',
      desc: '',
      args: [],
    );
  }

  /// `Diagnostics deleted.`
  String get diagnosticsDeleted {
    return Intl.message(
      'Diagnostics deleted.',
      name: 'diagnosticsDeleted',
      desc: '',
      args: [],
    );
  }

  /// `Diagnostics could not be deleted.`
  String get diagnosticsDeleteFailed {
    return Intl.message(
      'Diagnostics could not be deleted.',
      name: 'diagnosticsDeleteFailed',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get aboutTitle {
    return Intl.message('About', name: 'aboutTitle', desc: '', args: []);
  }

  /// `App information, version, and open-source notices.`
  String get aboutDescription {
    return Intl.message(
      'App information, version, and open-source notices.',
      name: 'aboutDescription',
      desc: '',
      args: [],
    );
  }

  /// `About Bookish`
  String get aboutBookish {
    return Intl.message(
      'About Bookish',
      name: 'aboutBookish',
      desc: '',
      args: [],
    );
  }

  /// `Version {version}`
  String appVersion(String version) {
    return Intl.message(
      'Version $version',
      name: 'appVersion',
      desc: '',
      args: [version],
    );
  }

  /// `Open-source licenses`
  String get openSourceLicenses {
    return Intl.message(
      'Open-source licenses',
      name: 'openSourceLicenses',
      desc: '',
      args: [],
    );
  }

  /// `Licenses for Flutter and every package used by Bookish`
  String get openSourceLicensesDescription {
    return Intl.message(
      'Licenses for Flutter and every package used by Bookish',
      name: 'openSourceLicensesDescription',
      desc: '',
      args: [],
    );
  }

  /// `Copyright © 2026 Bookish contributors`
  String get applicationLegalese {
    return Intl.message(
      'Copyright © 2026 Bookish contributors',
      name: 'applicationLegalese',
      desc: '',
      args: [],
    );
  }

  /// `Listening insights`
  String get listeningInsightsTitle {
    return Intl.message(
      'Listening insights',
      name: 'listeningInsightsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Could not load insights.`
  String get couldNotLoadInsights {
    return Intl.message(
      'Could not load insights.',
      name: 'couldNotLoadInsights',
      desc: '',
      args: [],
    );
  }

  /// `All-time listening`
  String get allTimeListening {
    return Intl.message(
      'All-time listening',
      name: 'allTimeListening',
      desc: '',
      args: [],
    );
  }

  /// `Listening time`
  String get listeningTime {
    return Intl.message(
      'Listening time',
      name: 'listeningTime',
      desc: '',
      args: [],
    );
  }

  /// `Last 7 days`
  String get lastSevenDays {
    return Intl.message(
      'Last 7 days',
      name: 'lastSevenDays',
      desc: '',
      args: [],
    );
  }

  /// `Last 30 days`
  String get lastThirtyDays {
    return Intl.message(
      'Last 30 days',
      name: 'lastThirtyDays',
      desc: '',
      args: [],
    );
  }

  /// `Last 12 months`
  String get lastTwelveMonths {
    return Intl.message(
      'Last 12 months',
      name: 'lastTwelveMonths',
      desc: '',
      args: [],
    );
  }

  /// `Listening activity`
  String get listeningActivity {
    return Intl.message(
      'Listening activity',
      name: 'listeningActivity',
      desc: '',
      args: [],
    );
  }

  /// `Week`
  String get week {
    return Intl.message('Week', name: 'week', desc: '', args: []);
  }

  /// `Month`
  String get month {
    return Intl.message('Month', name: 'month', desc: '', args: []);
  }

  /// `Year`
  String get year {
    return Intl.message('Year', name: 'year', desc: '', args: []);
  }

  /// `Books completed`
  String get booksCompleted {
    return Intl.message(
      'Books completed',
      name: 'booksCompleted',
      desc: '',
      args: [],
    );
  }

  /// `Active days`
  String get activeDays {
    return Intl.message('Active days', name: 'activeDays', desc: '', args: []);
  }

  /// `Streak days`
  String get streakDays {
    return Intl.message('Streak days', name: 'streakDays', desc: '', args: []);
  }

  /// `Your listening history will appear here.`
  String get emptyListeningHistory {
    return Intl.message(
      'Your listening history will appear here.',
      name: 'emptyListeningHistory',
      desc: '',
      args: [],
    );
  }

  /// `Finished book`
  String get finishedBook {
    return Intl.message(
      'Finished book',
      name: 'finishedBook',
      desc: '',
      args: [],
    );
  }

  /// `Storage could not be inspected.`
  String get storageInspectFailed {
    return Intl.message(
      'Storage could not be inspected.',
      name: 'storageInspectFailed',
      desc: '',
      args: [],
    );
  }

  /// `Unused files removed.`
  String get unusedFilesRemoved {
    return Intl.message(
      'Unused files removed.',
      name: 'unusedFilesRemoved',
      desc: '',
      args: [],
    );
  }

  /// `All Bookish data was removed.`
  String get allDataRemoved {
    return Intl.message(
      'All Bookish data was removed.',
      name: 'allDataRemoved',
      desc: '',
      args: [],
    );
  }

  /// `All Bookish data was removed, but settings could not be refreshed. Restart Bookish to finish resetting the screen.`
  String get allDataRemovedSettingsReloadFailed {
    return Intl.message(
      'All Bookish data was removed, but settings could not be refreshed. Restart Bookish to finish resetting the screen.',
      name: 'allDataRemovedSettingsReloadFailed',
      desc: '',
      args: [],
    );
  }

  /// `Bookish could not remove all app data.`
  String get clearDataFailed {
    return Intl.message(
      'Bookish could not remove all app data.',
      name: 'clearDataFailed',
      desc: '',
      args: [],
    );
  }

  /// `The audiobook editor could not be opened.`
  String get metadataEditorLoadFailed {
    return Intl.message(
      'The audiobook editor could not be opened.',
      name: 'metadataEditorLoadFailed',
      desc: '',
      args: [],
    );
  }

  /// `Could not save audiobook metadata.`
  String get metadataSaveFailed {
    return Intl.message(
      'Could not save audiobook metadata.',
      name: 'metadataSaveFailed',
      desc: '',
      args: [],
    );
  }

  /// `Your notes could not be loaded.`
  String get notesLoadFailed {
    return Intl.message(
      'Your notes could not be loaded.',
      name: 'notesLoadFailed',
      desc: '',
      args: [],
    );
  }

  /// `Speech recognition is not available.`
  String get speechRecognitionUnavailable {
    return Intl.message(
      'Speech recognition is not available.',
      name: 'speechRecognitionUnavailable',
      desc: '',
      args: [],
    );
  }

  /// `Speech recognition stopped unexpectedly.`
  String get speechRecognitionFailed {
    return Intl.message(
      'Speech recognition stopped unexpectedly.',
      name: 'speechRecognitionFailed',
      desc: '',
      args: [],
    );
  }

  /// `Could not load appearance settings.`
  String get settingsLoadFailed {
    return Intl.message(
      'Could not load appearance settings.',
      name: 'settingsLoadFailed',
      desc: '',
      args: [],
    );
  }

  /// `Could not save playback settings.`
  String get playbackSettingsSaveFailed {
    return Intl.message(
      'Could not save playback settings.',
      name: 'playbackSettingsSaveFailed',
      desc: '',
      args: [],
    );
  }

  /// `Could not save appearance settings.`
  String get appearanceSettingsSaveFailed {
    return Intl.message(
      'Could not save appearance settings.',
      name: 'appearanceSettingsSaveFailed',
      desc: '',
      args: [],
    );
  }

  /// `Could not load speech models.`
  String get speechModelsLoadFailed {
    return Intl.message(
      'Could not load speech models.',
      name: 'speechModelsLoadFailed',
      desc: '',
      args: [],
    );
  }

  /// `Speech model downloaded and ready.`
  String get speechModelDownloaded {
    return Intl.message(
      'Speech model downloaded and ready.',
      name: 'speechModelDownloaded',
      desc: '',
      args: [],
    );
  }

  /// `Could not download the speech model.`
  String get speechModelDownloadFailed {
    return Intl.message(
      'Could not download the speech model.',
      name: 'speechModelDownloadFailed',
      desc: '',
      args: [],
    );
  }

  /// `No speech was detected in this range.`
  String get noSpeechDetected {
    return Intl.message(
      'No speech was detected in this range.',
      name: 'noSpeechDetected',
      desc: '',
      args: [],
    );
  }

  /// `The quote could not be transcribed.`
  String get quoteTranscriptionFailed {
    return Intl.message(
      'The quote could not be transcribed.',
      name: 'quoteTranscriptionFailed',
      desc: '',
      args: [],
    );
  }

  /// `Could not open your library.`
  String get libraryLoadFailed {
    return Intl.message(
      'Could not open your library.',
      name: 'libraryLoadFailed',
      desc: '',
      args: [],
    );
  }

  /// `The book could not be removed.`
  String get bookRemovalFailed {
    return Intl.message(
      'The book could not be removed.',
      name: 'bookRemovalFailed',
      desc: '',
      args: [],
    );
  }

  /// `The library layout could not be saved.`
  String get libraryLayoutSaveFailed {
    return Intl.message(
      'The library layout could not be saved.',
      name: 'libraryLayoutSaveFailed',
      desc: '',
      args: [],
    );
  }

  /// `The book could not be updated.`
  String get bookUpdateFailed {
    return Intl.message(
      'The book could not be updated.',
      name: 'bookUpdateFailed',
      desc: '',
      args: [],
    );
  }

  /// `Listening insights could not be loaded.`
  String get listeningInsightsLoadFailed {
    return Intl.message(
      'Listening insights could not be loaded.',
      name: 'listeningInsightsLoadFailed',
      desc: '',
      args: [],
    );
  }

  /// `This audiobook could not be played.`
  String get audiobookPlaybackFailed {
    return Intl.message(
      'This audiobook could not be played.',
      name: 'audiobookPlaybackFailed',
      desc: '',
      args: [],
    );
  }

  /// `This audiobook could not be opened.`
  String get audiobookOpenFailed {
    return Intl.message(
      'This audiobook could not be opened.',
      name: 'audiobookOpenFailed',
      desc: '',
      args: [],
    );
  }

  /// `Opening file browser`
  String get importOpeningFileBrowser {
    return Intl.message(
      'Opening file browser',
      name: 'importOpeningFileBrowser',
      desc: '',
      args: [],
    );
  }

  /// `Preparing file selection`
  String get importPreparingSelection {
    return Intl.message(
      'Preparing file selection',
      name: 'importPreparingSelection',
      desc: '',
      args: [],
    );
  }

  /// `Copying audiobook`
  String get importCopyingAudiobook {
    return Intl.message(
      'Copying audiobook',
      name: 'importCopyingAudiobook',
      desc: '',
      args: [],
    );
  }

  /// `Reading audio information`
  String get importReadingAudioInformation {
    return Intl.message(
      'Reading audio information',
      name: 'importReadingAudioInformation',
      desc: '',
      args: [],
    );
  }

  /// `Analyzing chapters`
  String get importAnalyzingChapters {
    return Intl.message(
      'Analyzing chapters',
      name: 'importAnalyzingChapters',
      desc: '',
      args: [],
    );
  }

  /// `Extracting cover artwork`
  String get importExtractingArtwork {
    return Intl.message(
      'Extracting cover artwork',
      name: 'importExtractingArtwork',
      desc: '',
      args: [],
    );
  }

  /// `Saving to your library`
  String get importSavingToLibrary {
    return Intl.message(
      'Saving to your library',
      name: 'importSavingToLibrary',
      desc: '',
      args: [],
    );
  }

  /// `Removing originals`
  String get importRemovingOriginals {
    return Intl.message(
      'Removing originals',
      name: 'importRemovingOriginals',
      desc: '',
      args: [],
    );
  }

  /// `No transferred audiobooks found`
  String get importNoTransferredAudiobooks {
    return Intl.message(
      'No transferred audiobooks found',
      name: 'importNoTransferredAudiobooks',
      desc: '',
      args: [],
    );
  }

  /// `No files were selected`
  String get importNoFilesSelected {
    return Intl.message(
      'No files were selected',
      name: 'importNoFilesSelected',
      desc: '',
      args: [],
    );
  }

  /// `Import cancelled`
  String get importCancelled {
    return Intl.message(
      'Import cancelled',
      name: 'importCancelled',
      desc: '',
      args: [],
    );
  }

  /// `The book was copied, but the originals remain`
  String get importOriginalsRemain {
    return Intl.message(
      'The book was copied, but the originals remain',
      name: 'importOriginalsRemain',
      desc: '',
      args: [],
    );
  }

  /// `Bookish could not access that file`
  String get importFileAccessFailed {
    return Intl.message(
      'Bookish could not access that file',
      name: 'importFileAccessFailed',
      desc: '',
      args: [],
    );
  }

  /// `The audiobook metadata is malformed`
  String get importMalformedMetadata {
    return Intl.message(
      'The audiobook metadata is malformed',
      name: 'importMalformedMetadata',
      desc: '',
      args: [],
    );
  }

  /// `The audiobook could not be imported`
  String get importFailed {
    return Intl.message(
      'The audiobook could not be imported',
      name: 'importFailed',
      desc: '',
      args: [],
    );
  }

  /// `Choose one or more audiobook files.`
  String get importChooseFiles {
    return Intl.message(
      'Choose one or more audiobook files.',
      name: 'importChooseFiles',
      desc: '',
      args: [],
    );
  }

  /// `Please keep Bookish open for a moment.`
  String get importKeepOpen {
    return Intl.message(
      'Please keep Bookish open for a moment.',
      name: 'importKeepOpen',
      desc: '',
      args: [],
    );
  }

  /// `{file}\nPlease keep Bookish open for a moment.`
  String importKeepOpenWithFile(String file) {
    return Intl.message(
      '$file\nPlease keep Bookish open for a moment.',
      name: 'importKeepOpenWithFile',
      desc: '',
      args: [file],
    );
  }

  /// `{file}\n{copied} of {total} copied`
  String importCopyProgress(String file, String copied, String total) {
    return Intl.message(
      '$file\n$copied of $total copied',
      name: 'importCopyProgress',
      desc: '',
      args: [file, copied, total],
    );
  }

  /// `The audiobook is safely copied. Bookish is now removing the selected original files.`
  String get importRemovingOriginalsDetail {
    return Intl.message(
      'The audiobook is safely copied. Bookish is now removing the selected original files.',
      name: 'importRemovingOriginalsDetail',
      desc: '',
      args: [],
    );
  }

  /// `In Finder, select your iPhone, open Files > Bookish, then drag audiobooks directly into the Bookish file area.`
  String get importFinderInstructions {
    return Intl.message(
      'In Finder, select your iPhone, open Files > Bookish, then drag audiobooks directly into the Bookish file area.',
      name: 'importFinderInstructions',
      desc: '',
      args: [],
    );
  }

  /// `Android did not return any files to Bookish. You can open the file browser again or return to your library.`
  String get importSelectionCancelled {
    return Intl.message(
      'Android did not return any files to Bookish. You can open the file browser again or return to your library.',
      name: 'importSelectionCancelled',
      desc: '',
      args: [],
    );
  }

  /// `{count, plural, =0{No audiobooks were added.} =1{1 completed audiobook remains in your library.} other{{count} completed audiobooks remain in your library.}}`
  String importCancelledDetail(int count) {
    return Intl.plural(
      count,
      zero: 'No audiobooks were added.',
      one: '1 completed audiobook remains in your library.',
      other: '$count completed audiobooks remain in your library.',
      name: 'importCancelledDetail',
      desc: '',
      args: [count],
    );
  }

  /// `Book names, file paths, and raw errors are omitted.`
  String get importDiagnosticPrivacy {
    return Intl.message(
      'Book names, file paths, and raw errors are omitted.',
      name: 'importDiagnosticPrivacy',
      desc: '',
      args: [],
    );
  }

  /// `The document provider did not allow Bookish to delete one or more originals. Your imported copy is safe. You can retry deletion or remove the originals in the Files app.`
  String get importOriginalsRemainDetail {
    return Intl.message(
      'The document provider did not allow Bookish to delete one or more originals. Your imported copy is safe. You can retry deletion or remove the originals in the Files app.',
      name: 'importOriginalsRemainDetail',
      desc: '',
      args: [],
    );
  }

  /// `The failure happened while {stage}. The privacy-safe diagnostic below can be copied when reporting the problem.`
  String importFailureAtStage(String stage) {
    return Intl.message(
      'The failure happened while $stage. The privacy-safe diagnostic below can be copied when reporting the problem.',
      name: 'importFailureAtStage',
      desc: '',
      args: [stage],
    );
  }

  /// `{file} failed while {stage}. Completed audiobooks remain in your library. The privacy-safe diagnostic below can be copied when reporting the problem.`
  String importFailureForFileAtStage(String file, String stage) {
    return Intl.message(
      '$file failed while $stage. Completed audiobooks remain in your library. The privacy-safe diagnostic below can be copied when reporting the problem.',
      name: 'importFailureForFileAtStage',
      desc: '',
      args: [file, stage],
    );
  }

  /// `receiving the file from the document provider`
  String get importStageSelectingFiles {
    return Intl.message(
      'receiving the file from the document provider',
      name: 'importStageSelectingFiles',
      desc: '',
      args: [],
    );
  }

  /// `copying the file into Bookish`
  String get importStageCopyingFile {
    return Intl.message(
      'copying the file into Bookish',
      name: 'importStageCopyingFile',
      desc: '',
      args: [],
    );
  }

  /// `opening the audio stream`
  String get importStageReadingDuration {
    return Intl.message(
      'opening the audio stream',
      name: 'importStageReadingDuration',
      desc: '',
      args: [],
    );
  }

  /// `analyzing embedded chapters`
  String get importStageAnalyzingChapters {
    return Intl.message(
      'analyzing embedded chapters',
      name: 'importStageAnalyzingChapters',
      desc: '',
      args: [],
    );
  }

  /// `reading embedded cover artwork`
  String get importStageExtractingArtwork {
    return Intl.message(
      'reading embedded cover artwork',
      name: 'importStageExtractingArtwork',
      desc: '',
      args: [],
    );
  }

  /// `saving the library entry`
  String get importStageSavingBook {
    return Intl.message(
      'saving the library entry',
      name: 'importStageSavingBook',
      desc: '',
      args: [],
    );
  }

  /// `removing the selected original files`
  String get importStageRemovingOriginals {
    return Intl.message(
      'removing the selected original files',
      name: 'importStageRemovingOriginals',
      desc: '',
      args: [],
    );
  }

  /// `processing the audiobook`
  String get importStageUnknown {
    return Intl.message(
      'processing the audiobook',
      name: 'importStageUnknown',
      desc: '',
      args: [],
    );
  }

  /// `Back to library`
  String get backToLibrary {
    return Intl.message(
      'Back to library',
      name: 'backToLibrary',
      desc: '',
      args: [],
    );
  }

  /// `Technical details`
  String get technicalDetails {
    return Intl.message(
      'Technical details',
      name: 'technicalDetails',
      desc: '',
      args: [],
    );
  }

  /// `Exception and stack trace`
  String get exceptionAndStackTrace {
    return Intl.message(
      'Exception and stack trace',
      name: 'exceptionAndStackTrace',
      desc: '',
      args: [],
    );
  }

  /// `Diagnostic copied`
  String get diagnosticCopied {
    return Intl.message(
      'Diagnostic copied',
      name: 'diagnosticCopied',
      desc: '',
      args: [],
    );
  }

  /// `Copy diagnostic`
  String get copyDiagnostic {
    return Intl.message(
      'Copy diagnostic',
      name: 'copyDiagnostic',
      desc: '',
      args: [],
    );
  }

  /// `Open file browser again`
  String get openFileBrowserAgain {
    return Intl.message(
      'Open file browser again',
      name: 'openFileBrowserAgain',
      desc: '',
      args: [],
    );
  }

  /// `Try again`
  String get tryAgain {
    return Intl.message('Try again', name: 'tryAgain', desc: '', args: []);
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Save`
  String get save {
    return Intl.message('Save', name: 'save', desc: '', args: []);
  }

  /// `Add`
  String get add {
    return Intl.message('Add', name: 'add', desc: '', args: []);
  }

  /// `Close`
  String get close {
    return Intl.message('Close', name: 'close', desc: '', args: []);
  }

  /// `Off`
  String get off {
    return Intl.message('Off', name: 'off', desc: '', args: []);
  }

  /// `Share`
  String get share {
    return Intl.message('Share', name: 'share', desc: '', args: []);
  }

  /// `Play`
  String get play {
    return Intl.message('Play', name: 'play', desc: '', args: []);
  }

  /// `Pause`
  String get pause {
    return Intl.message('Pause', name: 'pause', desc: '', args: []);
  }

  /// `Jump to this position?`
  String get jumpToPositionQuestion {
    return Intl.message(
      'Jump to this position?',
      name: 'jumpToPositionQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Jump`
  String get jump {
    return Intl.message('Jump', name: 'jump', desc: '', args: []);
  }

  /// `Playback position changed.`
  String get playbackPositionChanged {
    return Intl.message(
      'Playback position changed.',
      name: 'playbackPositionChanged',
      desc: '',
      args: [],
    );
  }

  /// `This moves {duration} back.`
  String largeSeekBackward(String duration) {
    return Intl.message(
      'This moves $duration back.',
      name: 'largeSeekBackward',
      desc: '',
      args: [duration],
    );
  }

  /// `This moves {duration} forward.`
  String largeSeekForward(String duration) {
    return Intl.message(
      'This moves $duration forward.',
      name: 'largeSeekForward',
      desc: '',
      args: [duration],
    );
  }

  /// `Add bookmark at current position`
  String get addBookmarkAtCurrentPosition {
    return Intl.message(
      'Add bookmark at current position',
      name: 'addBookmarkAtCurrentPosition',
      desc: '',
      args: [],
    );
  }

  /// `Bookmark saved.`
  String get bookmarkSaved {
    return Intl.message(
      'Bookmark saved.',
      name: 'bookmarkSaved',
      desc: '',
      args: [],
    );
  }

  /// `Dictate voice note`
  String get dictateVoiceNote {
    return Intl.message(
      'Dictate voice note',
      name: 'dictateVoiceNote',
      desc: '',
      args: [],
    );
  }

  /// `Add note at current position`
  String get addNoteAtCurrentPosition {
    return Intl.message(
      'Add note at current position',
      name: 'addNoteAtCurrentPosition',
      desc: '',
      args: [],
    );
  }

  /// `Export notes`
  String get exportNotes {
    return Intl.message(
      'Export notes',
      name: 'exportNotes',
      desc: '',
      args: [],
    );
  }

  /// `Notes exported.`
  String get notesExported {
    return Intl.message(
      'Notes exported.',
      name: 'notesExported',
      desc: '',
      args: [],
    );
  }

  /// `Jump to note`
  String get jumpToNote {
    return Intl.message('Jump to note', name: 'jumpToNote', desc: '', args: []);
  }

  /// `Delete note`
  String get deleteNote {
    return Intl.message('Delete note', name: 'deleteNote', desc: '', args: []);
  }

  /// `End of chapter`
  String get endOfChapter {
    return Intl.message(
      'End of chapter',
      name: 'endOfChapter',
      desc: '',
      args: [],
    );
  }

  /// `Stop at the next chapter boundary`
  String get endOfChapterDescription {
    return Intl.message(
      'Stop at the next chapter boundary',
      name: 'endOfChapterDescription',
      desc: '',
      args: [],
    );
  }

  /// `Turn off timer`
  String get turnOffTimer {
    return Intl.message(
      'Turn off timer',
      name: 'turnOffTimer',
      desc: '',
      args: [],
    );
  }

  /// `Previous chapter`
  String get previousChapter {
    return Intl.message(
      'Previous chapter',
      name: 'previousChapter',
      desc: '',
      args: [],
    );
  }

  /// `Next chapter`
  String get nextChapter {
    return Intl.message(
      'Next chapter',
      name: 'nextChapter',
      desc: '',
      args: [],
    );
  }

  /// `Playback speed`
  String get playbackSpeed {
    return Intl.message(
      'Playback speed',
      name: 'playbackSpeed',
      desc: '',
      args: [],
    );
  }

  /// `Choose audio output`
  String get chooseAudioOutput {
    return Intl.message(
      'Choose audio output',
      name: 'chooseAudioOutput',
      desc: '',
      args: [],
    );
  }

  /// `Transcribe a quote`
  String get transcribeQuote {
    return Intl.message(
      'Transcribe a quote',
      name: 'transcribeQuote',
      desc: '',
      args: [],
    );
  }

  /// `Chapters`
  String get chaptersTitle {
    return Intl.message('Chapters', name: 'chaptersTitle', desc: '', args: []);
  }

  /// `Sleep timer`
  String get sleepTimer {
    return Intl.message('Sleep timer', name: 'sleepTimer', desc: '', args: []);
  }

  /// `Notes and bookmarks`
  String get notesAndBookmarks {
    return Intl.message(
      'Notes and bookmarks',
      name: 'notesAndBookmarks',
      desc: '',
      args: [],
    );
  }

  /// `Audio outputs could not be opened.`
  String get audioOutputsOpenFailed {
    return Intl.message(
      'Audio outputs could not be opened.',
      name: 'audioOutputsOpenFailed',
      desc: '',
      args: [],
    );
  }

  /// `Back to library`
  String get backToLibraryTooltip {
    return Intl.message(
      'Back to library',
      name: 'backToLibraryTooltip',
      desc: '',
      args: [],
    );
  }

  /// `A thought worth returning to…`
  String get noteThoughtHint {
    return Intl.message(
      'A thought worth returning to…',
      name: 'noteThoughtHint',
      desc: '',
      args: [],
    );
  }

  /// `Note at {position}`
  String noteAtPosition(String position) {
    return Intl.message(
      'Note at $position',
      name: 'noteAtPosition',
      desc: '',
      args: [position],
    );
  }

  /// `{chapter} · {position}`
  String chapterAtPosition(String chapter, String position) {
    return Intl.message(
      '$chapter · $position',
      name: 'chapterAtPosition',
      desc: '',
      args: [chapter, position],
    );
  }

  /// `Save note`
  String get saveNote {
    return Intl.message('Save note', name: 'saveNote', desc: '', args: []);
  }

  /// `Edit audiobook`
  String get editAudiobook {
    return Intl.message(
      'Edit audiobook',
      name: 'editAudiobook',
      desc: '',
      args: [],
    );
  }

  /// `Change cover`
  String get changeCover {
    return Intl.message(
      'Change cover',
      name: 'changeCover',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get titleField {
    return Intl.message('Title', name: 'titleField', desc: '', args: []);
  }

  /// `Author`
  String get authorField {
    return Intl.message('Author', name: 'authorField', desc: '', args: []);
  }

  /// `Series`
  String get seriesField {
    return Intl.message('Series', name: 'seriesField', desc: '', args: []);
  }

  /// `Volume number`
  String get volumeNumberField {
    return Intl.message(
      'Volume number',
      name: 'volumeNumberField',
      desc: '',
      args: [],
    );
  }

  /// `For example 2 or 2.5`
  String get volumeNumberHint {
    return Intl.message(
      'For example 2 or 2.5',
      name: 'volumeNumberHint',
      desc: '',
      args: [],
    );
  }

  /// `Narrator`
  String get narratorField {
    return Intl.message('Narrator', name: 'narratorField', desc: '', args: []);
  }

  /// `Year`
  String get yearField {
    return Intl.message('Year', name: 'yearField', desc: '', args: []);
  }

  /// `Folder`
  String get folderField {
    return Intl.message('Folder', name: 'folderField', desc: '', args: []);
  }

  /// `Save details`
  String get saveDetails {
    return Intl.message(
      'Save details',
      name: 'saveDetails',
      desc: '',
      args: [],
    );
  }

  /// `Track order`
  String get trackOrder {
    return Intl.message('Track order', name: 'trackOrder', desc: '', args: []);
  }

  /// `Add chapter`
  String get addChapter {
    return Intl.message('Add chapter', name: 'addChapter', desc: '', args: []);
  }

  /// `Start time in seconds`
  String get startTimeSeconds {
    return Intl.message(
      'Start time in seconds',
      name: 'startTimeSeconds',
      desc: '',
      args: [],
    );
  }

  /// `Rewind interval`
  String get rewindInterval {
    return Intl.message(
      'Rewind interval',
      name: 'rewindInterval',
      desc: '',
      args: [],
    );
  }

  /// `Forward interval`
  String get forwardInterval {
    return Intl.message(
      'Forward interval',
      name: 'forwardInterval',
      desc: '',
      args: [],
    );
  }

  /// `Chapter timer fallback`
  String get chapterTimerFallback {
    return Intl.message(
      'Chapter timer fallback',
      name: 'chapterTimerFallback',
      desc: '',
      args: [],
    );
  }

  /// `Shorten silence`
  String get shortenSilence {
    return Intl.message(
      'Shorten silence',
      name: 'shortenSilence',
      desc: '',
      args: [],
    );
  }

  /// `Voice boost`
  String get voiceBoost {
    return Intl.message('Voice boost', name: 'voiceBoost', desc: '', args: []);
  }

  /// `Continue series`
  String get continueSeries {
    return Intl.message(
      'Continue series',
      name: 'continueSeries',
      desc: '',
      args: [],
    );
  }

  /// `Storage assistant`
  String get storageAssistantTitle {
    return Intl.message(
      'Storage assistant',
      name: 'storageAssistantTitle',
      desc: '',
      args: [],
    );
  }

  /// `{size} managed`
  String managedStorage(String size) {
    return Intl.message(
      '$size managed',
      name: 'managedStorage',
      desc: '',
      args: [size],
    );
  }

  /// `{size} can be reclaimed safely`
  String reclaimableStorage(String size) {
    return Intl.message(
      '$size can be reclaimed safely',
      name: 'reclaimableStorage',
      desc: '',
      args: [size],
    );
  }

  /// `this book`
  String get thisBook {
    return Intl.message('this book', name: 'thisBook', desc: '', args: []);
  }

  /// `Remove every book, note, setting, listening record, speech model, and app-managed file.`
  String get resetDataDescription {
    return Intl.message(
      'Remove every book, note, setting, listening record, speech model, and app-managed file.',
      name: 'resetDataDescription',
      desc: '',
      args: [],
    );
  }

  /// `“{title}” will be removed from the library because its audio is no longer available.`
  String removeMissingBookDescription(String title) {
    return Intl.message(
      '“$title” will be removed from the library because its audio is no longer available.',
      name: 'removeMissingBookDescription',
      desc: '',
      args: [title],
    );
  }

  /// `This permanently removes all audiobooks, covers, notes, listening history, settings, downloaded speech models, and app-managed files. This cannot be undone.`
  String get eraseAllDataDescription {
    return Intl.message(
      'This permanently removes all audiobooks, covers, notes, listening history, settings, downloaded speech models, and app-managed files. This cannot be undone.',
      name: 'eraseAllDataDescription',
      desc: '',
      args: [],
    );
  }

  /// `Clean`
  String get clean {
    return Intl.message('Clean', name: 'clean', desc: '', args: []);
  }

  /// `Missing files`
  String get missingFiles {
    return Intl.message(
      'Missing files',
      name: 'missingFiles',
      desc: '',
      args: [],
    );
  }

  /// `Every library file is available.`
  String get allLibraryFilesAvailable {
    return Intl.message(
      'Every library file is available.',
      name: 'allLibraryFilesAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Unknown book`
  String get unknownBook {
    return Intl.message(
      'Unknown book',
      name: 'unknownBook',
      desc: '',
      args: [],
    );
  }

  /// `Remove missing library entry`
  String get removeMissingLibraryEntry {
    return Intl.message(
      'Remove missing library entry',
      name: 'removeMissingLibraryEntry',
      desc: '',
      args: [],
    );
  }

  /// `Possible duplicates`
  String get possibleDuplicates {
    return Intl.message(
      'Possible duplicates',
      name: 'possibleDuplicates',
      desc: '',
      args: [],
    );
  }

  /// `No duplicate books detected.`
  String get noDuplicateBooks {
    return Intl.message(
      'No duplicate books detected.',
      name: 'noDuplicateBooks',
      desc: '',
      args: [],
    );
  }

  /// `Erase all app data`
  String get eraseAllAppData {
    return Intl.message(
      'Erase all app data',
      name: 'eraseAllAppData',
      desc: '',
      args: [],
    );
  }

  /// `Erase`
  String get erase {
    return Intl.message('Erase', name: 'erase', desc: '', args: []);
  }

  /// `Remove unused files?`
  String get removeUnusedFilesQuestion {
    return Intl.message(
      'Remove unused files?',
      name: 'removeUnusedFilesQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Remove unused files`
  String get removeUnusedFiles {
    return Intl.message(
      'Remove unused files',
      name: 'removeUnusedFiles',
      desc: '',
      args: [],
    );
  }

  /// `Remove missing entry?`
  String get removeMissingEntryQuestion {
    return Intl.message(
      'Remove missing entry?',
      name: 'removeMissingEntryQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Remove entry`
  String get removeEntry {
    return Intl.message(
      'Remove entry',
      name: 'removeEntry',
      desc: '',
      args: [],
    );
  }

  /// `Erase all Bookish data?`
  String get eraseAllDataQuestion {
    return Intl.message(
      'Erase all Bookish data?',
      name: 'eraseAllDataQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Erase everything`
  String get eraseEverything {
    return Intl.message(
      'Erase everything',
      name: 'eraseEverything',
      desc: '',
      args: [],
    );
  }

  /// `Filter and organize library`
  String get filterAndOrganizeLibrary {
    return Intl.message(
      'Filter and organize library',
      name: 'filterAndOrganizeLibrary',
      desc: '',
      args: [],
    );
  }

  /// `List`
  String get listLayout {
    return Intl.message('List', name: 'listLayout', desc: '', args: []);
  }

  /// `Grid`
  String get gridLayout {
    return Intl.message('Grid', name: 'gridLayout', desc: '', args: []);
  }

  /// `Choose audiobooks`
  String get chooseAudiobooks {
    return Intl.message(
      'Choose audiobooks',
      name: 'chooseAudiobooks',
      desc: '',
      args: [],
    );
  }

  /// `Save voice note`
  String get saveVoiceNote {
    return Intl.message(
      'Save voice note',
      name: 'saveVoiceNote',
      desc: '',
      args: [],
    );
  }

  /// `Notes`
  String get notesTitle {
    return Intl.message('Notes', name: 'notesTitle', desc: '', args: []);
  }

  /// `{count, plural, =1{1 note} other{{count} notes}}`
  String noteCount(num count) {
    return Intl.plural(
      count,
      one: '1 note',
      other: '$count notes',
      name: 'noteCount',
      desc: '',
      args: [count],
    );
  }

  /// `Book actions`
  String get bookActions {
    return Intl.message(
      'Book actions',
      name: 'bookActions',
      desc: '',
      args: [],
    );
  }

  /// `Remove favorite`
  String get removeFavorite {
    return Intl.message(
      'Remove favorite',
      name: 'removeFavorite',
      desc: '',
      args: [],
    );
  }

  /// `Add favorite`
  String get addFavorite {
    return Intl.message(
      'Add favorite',
      name: 'addFavorite',
      desc: '',
      args: [],
    );
  }

  /// `Want to listen`
  String get wantToListen {
    return Intl.message(
      'Want to listen',
      name: 'wantToListen',
      desc: '',
      args: [],
    );
  }

  /// `Mark finished`
  String get markFinished {
    return Intl.message(
      'Mark finished',
      name: 'markFinished',
      desc: '',
      args: [],
    );
  }

  /// `Mark unfinished`
  String get markUnfinished {
    return Intl.message(
      'Mark unfinished',
      name: 'markUnfinished',
      desc: '',
      args: [],
    );
  }

  /// `Use progress status`
  String get useProgressStatus {
    return Intl.message(
      'Use progress status',
      name: 'useProgressStatus',
      desc: '',
      args: [],
    );
  }

  /// `View full title`
  String get viewFullTitle {
    return Intl.message(
      'View full title',
      name: 'viewFullTitle',
      desc: '',
      args: [],
    );
  }

  /// `Edit metadata`
  String get editMetadata {
    return Intl.message(
      'Edit metadata',
      name: 'editMetadata',
      desc: '',
      args: [],
    );
  }

  /// `Remove from device`
  String get removeFromDevice {
    return Intl.message(
      'Remove from device',
      name: 'removeFromDevice',
      desc: '',
      args: [],
    );
  }

  /// `Full title`
  String get fullTitle {
    return Intl.message('Full title', name: 'fullTitle', desc: '', args: []);
  }

  /// `Your notes`
  String get yourNotes {
    return Intl.message('Your notes', name: 'yourNotes', desc: '', args: []);
  }

  /// `Notes you save while listening will live here.`
  String get notesEmptyDescription {
    return Intl.message(
      'Notes you save while listening will live here.',
      name: 'notesEmptyDescription',
      desc: '',
      args: [],
    );
  }

  /// `Note`
  String get noteTitle {
    return Intl.message('Note', name: 'noteTitle', desc: '', args: []);
  }

  /// `Share note`
  String get shareNote {
    return Intl.message('Share note', name: 'shareNote', desc: '', args: []);
  }

  /// `Title (optional)`
  String get optionalTitle {
    return Intl.message(
      'Title (optional)',
      name: 'optionalTitle',
      desc: '',
      args: [],
    );
  }

  /// `Remove “{title}”?`
  String removeBookQuestion(String title) {
    return Intl.message(
      'Remove “$title”?',
      name: 'removeBookQuestion',
      desc: '',
      args: [title],
    );
  }

  /// `Remove audio only`
  String get removeAudioOnly {
    return Intl.message(
      'Remove audio only',
      name: 'removeAudioOnly',
      desc: '',
      args: [],
    );
  }

  /// `Original files outside Bookish are not affected.`
  String get externalOriginalsUnaffected {
    return Intl.message(
      'Original files outside Bookish are not affected.',
      name: 'externalOriginalsUnaffected',
      desc: '',
      args: [],
    );
  }

  /// `Search title, author, narrator, or series`
  String get librarySearchHint {
    return Intl.message(
      'Search title, author, narrator, or series',
      name: 'librarySearchHint',
      desc: '',
      args: [],
    );
  }

  /// `Notes gallery`
  String get notesGallery {
    return Intl.message(
      'Notes gallery',
      name: 'notesGallery',
      desc: '',
      args: [],
    );
  }

  /// `Copy from Files`
  String get copyFromFiles {
    return Intl.message(
      'Copy from Files',
      name: 'copyFromFiles',
      desc: '',
      args: [],
    );
  }

  /// `Move from Finder transfer`
  String get moveFromFinderTransfer {
    return Intl.message(
      'Move from Finder transfer',
      name: 'moveFromFinderTransfer',
      desc: '',
      args: [],
    );
  }

  /// `Audiobook imported into Bookish`
  String get audiobookImported {
    return Intl.message(
      'Audiobook imported into Bookish',
      name: 'audiobookImported',
      desc: '',
      args: [],
    );
  }

  /// `Import audiobooks`
  String get importAudiobooks {
    return Intl.message(
      'Import audiobooks',
      name: 'importAudiobooks',
      desc: '',
      args: [],
    );
  }

  /// `No books match these filters.`
  String get noBooksMatchFilters {
    return Intl.message(
      'No books match these filters.',
      name: 'noBooksMatchFilters',
      desc: '',
      args: [],
    );
  }

  /// `From {position}`
  String fromPosition(String position) {
    return Intl.message(
      'From $position',
      name: 'fromPosition',
      desc: '',
      args: [position],
    );
  }

  /// `To {position}`
  String toPosition(String position) {
    return Intl.message(
      'To $position',
      name: 'toPosition',
      desc: '',
      args: [position],
    );
  }

  /// `Preview quote`
  String get previewQuote {
    return Intl.message(
      'Preview quote',
      name: 'previewQuote',
      desc: '',
      args: [],
    );
  }

  /// `The transcription will appear here.`
  String get transcriptionPlaceholder {
    return Intl.message(
      'The transcription will appear here.',
      name: 'transcriptionPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Save to notes`
  String get saveToNotes {
    return Intl.message(
      'Save to notes',
      name: 'saveToNotes',
      desc: '',
      args: [],
    );
  }

  /// `Quote saved to notes.`
  String get quoteSavedToNotes {
    return Intl.message(
      'Quote saved to notes.',
      name: 'quoteSavedToNotes',
      desc: '',
      args: [],
    );
  }

  /// `Error details`
  String get errorDetails {
    return Intl.message(
      'Error details',
      name: 'errorDetails',
      desc: '',
      args: [],
    );
  }

  /// `Copy error details`
  String get copyErrorDetails {
    return Intl.message(
      'Copy error details',
      name: 'copyErrorDetails',
      desc: '',
      args: [],
    );
  }

  /// `Error details copied`
  String get errorDetailsCopied {
    return Intl.message(
      'Error details copied',
      name: 'errorDetailsCopied',
      desc: '',
      args: [],
    );
  }

  /// `Audiobook not found`
  String get audiobookNotFound {
    return Intl.message(
      'Audiobook not found',
      name: 'audiobookNotFound',
      desc: '',
      args: [],
    );
  }

  /// `Chapters`
  String get chapters {
    return Intl.message('Chapters', name: 'chapters', desc: '', args: []);
  }

  /// `Undo`
  String get undo {
    return Intl.message('Undo', name: 'undo', desc: '', args: []);
  }

  /// `No audiobook selected`
  String get noAudiobookSelected {
    return Intl.message(
      'No audiobook selected',
      name: 'noAudiobookSelected',
      desc: '',
      args: [],
    );
  }

  /// `NOW PLAYING`
  String get nowPlaying {
    return Intl.message('NOW PLAYING', name: 'nowPlaying', desc: '', args: []);
  }

  /// `Playing`
  String get playing {
    return Intl.message('Playing', name: 'playing', desc: '', args: []);
  }

  /// `Paused`
  String get paused {
    return Intl.message('Paused', name: 'paused', desc: '', args: []);
  }

  /// `Stops at end of chapter`
  String get stopsAtEndOfChapter {
    return Intl.message(
      'Stops at end of chapter',
      name: 'stopsAtEndOfChapter',
      desc: '',
      args: [],
    );
  }

  /// `Timer active`
  String get timerActive {
    return Intl.message(
      'Timer active',
      name: 'timerActive',
      desc: '',
      args: [],
    );
  }

  /// `About {count} minutes remaining`
  String minutesRemaining(num count) {
    return Intl.message(
      'About $count minutes remaining',
      name: 'minutesRemaining',
      desc: '',
      args: [count],
    );
  }

  /// `Its audio file is no longer available.`
  String get missingAudioDescription {
    return Intl.message(
      'Its audio file is no longer available.',
      name: 'missingAudioDescription',
      desc: '',
      args: [],
    );
  }

  /// `Duplicate books`
  String get duplicateBooks {
    return Intl.message(
      'Duplicate books',
      name: 'duplicateBooks',
      desc: '',
      args: [],
    );
  }

  /// `Unknown`
  String get unknown {
    return Intl.message('Unknown', name: 'unknown', desc: '', args: []);
  }

  /// `Reset Bookish`
  String get resetBookish {
    return Intl.message(
      'Reset Bookish',
      name: 'resetBookish',
      desc: '',
      args: [],
    );
  }

  /// `Bookish will delete copied audio and cover files that are not referenced by any library entry.`
  String get unusedFilesExplanation {
    return Intl.message(
      'Bookish will delete copied audio and cover files that are not referenced by any library entry.',
      name: 'unusedFilesExplanation',
      desc: '',
      args: [],
    );
  }

  /// `Playback could not be reset safely.`
  String get playbackResetFailed {
    return Intl.message(
      'Playback could not be reset safely.',
      name: 'playbackResetFailed',
      desc: '',
      args: [],
    );
  }

  /// `Relaxed`
  String get speedRelaxed {
    return Intl.message('Relaxed', name: 'speedRelaxed', desc: '', args: []);
  }

  /// `Natural`
  String get speedNatural {
    return Intl.message('Natural', name: 'speedNatural', desc: '', args: []);
  }

  /// `Focused`
  String get speedFocused {
    return Intl.message('Focused', name: 'speedFocused', desc: '', args: []);
  }

  /// `Brisk`
  String get speedBrisk {
    return Intl.message('Brisk', name: 'speedBrisk', desc: '', args: []);
  }

  /// `Fast`
  String get speedFast {
    return Intl.message('Fast', name: 'speedFast', desc: '', args: []);
  }

  /// `Very fast`
  String get speedVeryFast {
    return Intl.message('Very fast', name: 'speedVeryFast', desc: '', args: []);
  }

  /// `Output`
  String get output {
    return Intl.message('Output', name: 'output', desc: '', args: []);
  }

  /// `Quote`
  String get quote {
    return Intl.message('Quote', name: 'quote', desc: '', args: []);
  }

  /// `Timer`
  String get timer {
    return Intl.message('Timer', name: 'timer', desc: '', args: []);
  }

  /// `Notes`
  String get notes {
    return Intl.message('Notes', name: 'notes', desc: '', args: []);
  }

  /// `Playback`
  String get playbackTitle {
    return Intl.message('Playback', name: 'playbackTitle', desc: '', args: []);
  }

  /// `Tune Bookish for narration, sleep, and precise seeking.`
  String get playbackDescription {
    return Intl.message(
      'Tune Bookish for narration, sleep, and precise seeking.',
      name: 'playbackDescription',
      desc: '',
      args: [],
    );
  }

  /// `{count} sec`
  String secondsShort(num count) {
    return Intl.message(
      '$count sec',
      name: 'secondsShort',
      desc: '',
      args: [count],
    );
  }

  /// `{count} min`
  String minutesShort(num count) {
    return Intl.message(
      '$count min',
      name: 'minutesShort',
      desc: '',
      args: [count],
    );
  }

  /// `{count} sec earlier`
  String secondsEarlier(num count) {
    return Intl.message(
      '$count sec earlier',
      name: 'secondsEarlier',
      desc: '',
      args: [count],
    );
  }

  /// `{count} sec later`
  String secondsLater(num count) {
    return Intl.message(
      '$count sec later',
      name: 'secondsLater',
      desc: '',
      args: [count],
    );
  }

  /// `Last {count} sec`
  String lastSeconds(num count) {
    return Intl.message(
      'Last $count sec',
      name: 'lastSeconds',
      desc: '',
      args: [count],
    );
  }

  /// `Last {count} min`
  String lastMinutes(num count) {
    return Intl.message(
      'Last $count min',
      name: 'lastMinutes',
      desc: '',
      args: [count],
    );
  }

  /// `Stops even if a chapter boundary is missing`
  String get chapterFallbackDescription {
    return Intl.message(
      'Stops even if a chapter boundary is missing',
      name: 'chapterFallbackDescription',
      desc: '',
      args: [],
    );
  }

  /// `Gently skips quiet gaps on supported devices`
  String get shortenSilenceDescription {
    return Intl.message(
      'Gently skips quiet gaps on supported devices',
      name: 'shortenSilenceDescription',
      desc: '',
      args: [],
    );
  }

  /// `Emphasizes narration on supported devices`
  String get voiceBoostDescription {
    return Intl.message(
      'Emphasizes narration on supported devices',
      name: 'voiceBoostDescription',
      desc: '',
      args: [],
    );
  }

  /// `Start the next unfinished volume automatically`
  String get continueSeriesDescription {
    return Intl.message(
      'Start the next unfinished volume automatically',
      name: 'continueSeriesDescription',
      desc: '',
      args: [],
    );
  }

  /// `Library view`
  String get libraryView {
    return Intl.message(
      'Library view',
      name: 'libraryView',
      desc: '',
      args: [],
    );
  }

  /// `Show`
  String get show {
    return Intl.message('Show', name: 'show', desc: '', args: []);
  }

  /// `Group by`
  String get groupBy {
    return Intl.message('Group by', name: 'groupBy', desc: '', args: []);
  }

  /// `Sort by`
  String get sortBy {
    return Intl.message('Sort by', name: 'sortBy', desc: '', args: []);
  }

  /// `None`
  String get none {
    return Intl.message('None', name: 'none', desc: '', args: []);
  }

  /// `Listening status`
  String get listeningStatus {
    return Intl.message(
      'Listening status',
      name: 'listeningStatus',
      desc: '',
      args: [],
    );
  }

  /// `All books`
  String get allBooks {
    return Intl.message('All books', name: 'allBooks', desc: '', args: []);
  }

  /// `Not started`
  String get notStarted {
    return Intl.message('Not started', name: 'notStarted', desc: '', args: []);
  }

  /// `In progress`
  String get inProgress {
    return Intl.message('In progress', name: 'inProgress', desc: '', args: []);
  }

  /// `Finished`
  String get finished {
    return Intl.message('Finished', name: 'finished', desc: '', args: []);
  }

  /// `Favorites`
  String get favorites {
    return Intl.message('Favorites', name: 'favorites', desc: '', args: []);
  }

  /// `Recently added`
  String get recentlyAdded {
    return Intl.message(
      'Recently added',
      name: 'recentlyAdded',
      desc: '',
      args: [],
    );
  }

  /// `Time remaining`
  String get timeRemaining {
    return Intl.message(
      'Time remaining',
      name: 'timeRemaining',
      desc: '',
      args: [],
    );
  }

  /// `Date added`
  String get dateAdded {
    return Intl.message('Date added', name: 'dateAdded', desc: '', args: []);
  }

  /// `Transcribing on device…`
  String get transcribingOnDevice {
    return Intl.message(
      'Transcribing on device…',
      name: 'transcribingOnDevice',
      desc: '',
      args: [],
    );
  }

  /// `Transcribe range`
  String get transcribeRange {
    return Intl.message(
      'Transcribe range',
      name: 'transcribeRange',
      desc: '',
      args: [],
    );
  }

  /// `Audiobook`
  String get audiobook {
    return Intl.message('Audiobook', name: 'audiobook', desc: '', args: []);
  }

  /// `Quote time range`
  String get quoteTimeRange {
    return Intl.message(
      'Quote time range',
      name: 'quoteTimeRange',
      desc: '',
      args: [],
    );
  }

  /// `Voice note`
  String get voiceNote {
    return Intl.message('Voice note', name: 'voiceNote', desc: '', args: []);
  }

  /// `Tap the microphone and speak.`
  String get voiceNotePrompt {
    return Intl.message(
      'Tap the microphone and speak.',
      name: 'voiceNotePrompt',
      desc: '',
      args: [],
    );
  }

  /// `Stop listening`
  String get stopListening {
    return Intl.message(
      'Stop listening',
      name: 'stopListening',
      desc: '',
      args: [],
    );
  }

  /// `Start listening`
  String get startListening {
    return Intl.message(
      'Start listening',
      name: 'startListening',
      desc: '',
      args: [],
    );
  }

  /// `Library`
  String get libraryTitle {
    return Intl.message('Library', name: 'libraryTitle', desc: '', args: []);
  }

  /// `Review your listening and manage local audiobook storage.`
  String get librarySettingsDescription {
    return Intl.message(
      'Review your listening and manage local audiobook storage.',
      name: 'librarySettingsDescription',
      desc: '',
      args: [],
    );
  }

  /// `Listening time, activity, and completed books`
  String get listeningInsightsDescription {
    return Intl.message(
      'Listening time, activity, and completed books',
      name: 'listeningInsightsDescription',
      desc: '',
      args: [],
    );
  }

  /// `Find missing, duplicate, and unused files`
  String get storageAssistantDescription {
    return Intl.message(
      'Find missing, duplicate, and unused files',
      name: 'storageAssistantDescription',
      desc: '',
      args: [],
    );
  }

  /// `Review and edit`
  String get reviewAndEdit {
    return Intl.message(
      'Review and edit',
      name: 'reviewAndEdit',
      desc: '',
      args: [],
    );
  }

  /// `Correct the local transcription before saving or sharing it.`
  String get reviewTranscriptionDescription {
    return Intl.message(
      'Correct the local transcription before saving or sharing it.',
      name: 'reviewTranscriptionDescription',
      desc: '',
      args: [],
    );
  }

  /// `Could not load notes.`
  String get couldNotLoadNotes {
    return Intl.message(
      'Could not load notes.',
      name: 'couldNotLoadNotes',
      desc: '',
      args: [],
    );
  }

  /// `Archived`
  String get archived {
    return Intl.message('Archived', name: 'archived', desc: '', args: []);
  }

  /// `In library`
  String get inLibrary {
    return Intl.message('In library', name: 'inLibrary', desc: '', args: []);
  }

  /// `Delete everything`
  String get deleteEverything {
    return Intl.message(
      'Delete everything',
      name: 'deleteEverything',
      desc: '',
      args: [],
    );
  }

  /// `Keep notes, book details, cover, and listening history.`
  String get keepUserDataDescription {
    return Intl.message(
      'Keep notes, book details, cover, and listening history.',
      name: 'keepUserDataDescription',
      desc: '',
      args: [],
    );
  }

  /// `Also delete notes, book details, cover, and listening history.`
  String get deleteAllUserDataDescription {
    return Intl.message(
      'Also delete notes, book details, cover, and listening history.',
      name: 'deleteAllUserDataDescription',
      desc: '',
      args: [],
    );
  }

  /// `Your library`
  String get yourLibrary {
    return Intl.message(
      'Your library',
      name: 'yourLibrary',
      desc: '',
      args: [],
    );
  }

  /// `Keep the originals and copy them into Bookish`
  String get copyFromFilesDescription {
    return Intl.message(
      'Keep the originals and copy them into Bookish',
      name: 'copyFromFilesDescription',
      desc: '',
      args: [],
    );
  }

  /// `Copy into Bookish, then remove the transferred originals`
  String get moveFromFinderDescription {
    return Intl.message(
      'Copy into Bookish, then remove the transferred originals',
      name: 'moveFromFinderDescription',
      desc: '',
      args: [],
    );
  }

  /// `Share these details if the issue repeats`
  String get shareErrorDetailsDescription {
    return Intl.message(
      'Share these details if the issue repeats',
      name: 'shareErrorDetailsDescription',
      desc: '',
      args: [],
    );
  }

  /// `A quiet shelf, for now`
  String get quietShelfTitle {
    return Intl.message(
      'A quiet shelf, for now',
      name: 'quietShelfTitle',
      desc: '',
      args: [],
    );
  }

  /// `Import MP3, M4A, M4B, AAC, FLAC, WAV, OGG, or Opus files from your device or cloud storage.`
  String get quietShelfDescription {
    return Intl.message(
      'Import MP3, M4A, M4B, AAC, FLAC, WAV, OGG, or Opus files from your device or cloud storage.',
      name: 'quietShelfDescription',
      desc: '',
      args: [],
    );
  }

  /// `Notes & bookmarks`
  String get notesAndBookmarksTitle {
    return Intl.message(
      'Notes & bookmarks',
      name: 'notesAndBookmarksTitle',
      desc: '',
      args: [],
    );
  }

  /// `No notes yet. Add one while you listen.`
  String get noNotesYet {
    return Intl.message(
      'No notes yet. Add one while you listen.',
      name: 'noNotesYet',
      desc: '',
      args: [],
    );
  }

  /// `We’re sorry for the inconvenience. Please try again. If the issue keeps happening, expand and copy the error details below and send them to us.`
  String get diagnosticFailureApology {
    return Intl.message(
      'We’re sorry for the inconvenience. Please try again. If the issue keeps happening, expand and copy the error details below and send them to us.',
      name: 'diagnosticFailureApology',
      desc: '',
      args: [],
    );
  }

  /// `Choose the exact part of the audiobook. Transcription happens on this device and can take a while, especially for longer selections.`
  String get transcriptionRangeDescription {
    return Intl.message(
      'Choose the exact part of the audiobook. Transcription happens on this device and can take a while, especially for longer selections.',
      name: 'transcriptionRangeDescription',
      desc: '',
      args: [],
    );
  }

  /// `{start} – {end} in chapter`
  String rangeInChapter(String start, String end) {
    return Intl.message(
      '$start – $end in chapter',
      name: 'rangeInChapter',
      desc: '',
      args: [start, end],
    );
  }

  /// `Quote from {title}`
  String quoteShareSubject(String title) {
    return Intl.message(
      'Quote from $title',
      name: 'quoteShareSubject',
      desc: '',
      args: [title],
    );
  }

  /// `Unknown author`
  String get unknownAuthor {
    return Intl.message(
      'Unknown author',
      name: 'unknownAuthor',
      desc: '',
      args: [],
    );
  }

  /// `No series`
  String get noSeries {
    return Intl.message('No series', name: 'noSeries', desc: '', args: []);
  }

  /// `Imported`
  String get imported {
    return Intl.message('Imported', name: 'imported', desc: '', args: []);
  }

  /// `Listening`
  String get listening {
    return Intl.message('Listening', name: 'listening', desc: '', args: []);
  }

  /// `{start} to {end}`
  String rangeAccessibilityValue(String start, String end) {
    return Intl.message(
      '$start to $end',
      name: 'rangeAccessibilityValue',
      desc: '',
      args: [start, end],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'sk'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
