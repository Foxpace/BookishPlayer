// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(version) => "Version ${version}";

  static String m1(chapter, position) => "${chapter} · ${position}";

  static String m2(position) => "From ${position}";

  static String m3(count) =>
      "${Intl.plural(count, zero: 'No audiobooks were added.', one: '1 completed audiobook remains in your library.', other: '${count} completed audiobooks remain in your library.')}";

  static String m4(file, copied, total) =>
      "${file}\n${copied} of ${total} copied";

  static String m5(stage) =>
      "The failure happened while ${stage}. The privacy-safe diagnostic below can be copied when reporting the problem.";

  static String m6(file, stage) =>
      "${file} failed while ${stage}. Completed audiobooks remain in your library. The privacy-safe diagnostic below can be copied when reporting the problem.";

  static String m7(file) => "${file}\nPlease keep Bookish open for a moment.";

  static String m8(duration) => "This moves ${duration} back.";

  static String m9(duration) => "This moves ${duration} forward.";

  static String m10(count) => "Last ${count} min";

  static String m11(count) => "Last ${count} sec";

  static String m12(size) => "${size} managed";

  static String m13(count) => "About ${count} minutes remaining";

  static String m14(count) => "${count} min";

  static String m15(size) => "${size} MB";

  static String m16(position) => "Note at ${position}";

  static String m17(count) =>
      "${Intl.plural(count, one: '1 note', other: '${count} notes')}";

  static String m18(title) => "Quote from ${title}";

  static String m19(start, end) => "${start} to ${end}";

  static String m20(start, end) => "${start} – ${end} in chapter";

  static String m21(size) => "${size} can be reclaimed safely";

  static String m22(title) => "Remove “${title}”?";

  static String m23(title) =>
      "“${title}” will be removed from the library because its audio is no longer available.";

  static String m24(count) => "${count} sec earlier";

  static String m25(count) => "${count} sec later";

  static String m26(count) => "${count} sec";

  static String m27(position) => "To ${position}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "aboutBookish": MessageLookupByLibrary.simpleMessage("About Bookish"),
    "aboutDescription": MessageLookupByLibrary.simpleMessage(
      "App information, version, and open-source notices.",
    ),
    "aboutTitle": MessageLookupByLibrary.simpleMessage("About"),
    "activeDays": MessageLookupByLibrary.simpleMessage("Active days"),
    "add": MessageLookupByLibrary.simpleMessage("Add"),
    "addBookmarkAtCurrentPosition": MessageLookupByLibrary.simpleMessage(
      "Add bookmark at current position",
    ),
    "addChapter": MessageLookupByLibrary.simpleMessage("Add chapter"),
    "addFavorite": MessageLookupByLibrary.simpleMessage("Add favorite"),
    "addNoteAtCurrentPosition": MessageLookupByLibrary.simpleMessage(
      "Add note at current position",
    ),
    "allBooks": MessageLookupByLibrary.simpleMessage("All books"),
    "allDataRemoved": MessageLookupByLibrary.simpleMessage(
      "All Bookish data was removed.",
    ),
    "allDataRemovedSettingsReloadFailed": MessageLookupByLibrary.simpleMessage(
      "All Bookish data was removed, but settings could not be refreshed. Restart Bookish to finish resetting the screen.",
    ),
    "allLibraryFilesAvailable": MessageLookupByLibrary.simpleMessage(
      "Every library file is available.",
    ),
    "allTimeListening": MessageLookupByLibrary.simpleMessage(
      "All-time listening",
    ),
    "appDescription": MessageLookupByLibrary.simpleMessage(
      "A quiet, offline-first audiobook player.",
    ),
    "appTitle": MessageLookupByLibrary.simpleMessage("Bookish"),
    "appVersion": m0,
    "appearanceDescription": MessageLookupByLibrary.simpleMessage(
      "Choose how Bookish looks on this device.",
    ),
    "appearanceSettingsSaveFailed": MessageLookupByLibrary.simpleMessage(
      "Could not save appearance settings.",
    ),
    "appearanceTitle": MessageLookupByLibrary.simpleMessage("Appearance"),
    "applicationLegalese": MessageLookupByLibrary.simpleMessage(
      "Copyright © 2026 Bookish contributors",
    ),
    "archived": MessageLookupByLibrary.simpleMessage("Archived"),
    "audioOutputsOpenFailed": MessageLookupByLibrary.simpleMessage(
      "Audio outputs could not be opened.",
    ),
    "audiobook": MessageLookupByLibrary.simpleMessage("Audiobook"),
    "audiobookImported": MessageLookupByLibrary.simpleMessage(
      "Audiobook imported into Bookish",
    ),
    "audiobookNotFound": MessageLookupByLibrary.simpleMessage(
      "Audiobook not found",
    ),
    "audiobookOpenFailed": MessageLookupByLibrary.simpleMessage(
      "This audiobook could not be opened.",
    ),
    "audiobookPlaybackFailed": MessageLookupByLibrary.simpleMessage(
      "This audiobook could not be played.",
    ),
    "authorField": MessageLookupByLibrary.simpleMessage("Author"),
    "backToLibrary": MessageLookupByLibrary.simpleMessage("Back to library"),
    "backToLibraryTooltip": MessageLookupByLibrary.simpleMessage(
      "Back to library",
    ),
    "backupExportFailed": MessageLookupByLibrary.simpleMessage(
      "Could not export the backup.",
    ),
    "backupExported": MessageLookupByLibrary.simpleMessage("Backup exported."),
    "backupRestoreFailed": MessageLookupByLibrary.simpleMessage(
      "This backup could not be restored.",
    ),
    "backupRestored": MessageLookupByLibrary.simpleMessage(
      "Backup restored. Audio files must remain available locally.",
    ),
    "bookActions": MessageLookupByLibrary.simpleMessage("Book actions"),
    "bookRemovalFailed": MessageLookupByLibrary.simpleMessage(
      "The book could not be removed.",
    ),
    "bookUpdateFailed": MessageLookupByLibrary.simpleMessage(
      "The book could not be updated.",
    ),
    "bookmarkSaved": MessageLookupByLibrary.simpleMessage("Bookmark saved."),
    "booksCompleted": MessageLookupByLibrary.simpleMessage("Books completed"),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "changeCover": MessageLookupByLibrary.simpleMessage("Change cover"),
    "chapterAtPosition": m1,
    "chapterFallbackDescription": MessageLookupByLibrary.simpleMessage(
      "Stops even if a chapter boundary is missing",
    ),
    "chapterTimerFallback": MessageLookupByLibrary.simpleMessage(
      "Chapter timer fallback",
    ),
    "chapters": MessageLookupByLibrary.simpleMessage("Chapters"),
    "chaptersTitle": MessageLookupByLibrary.simpleMessage("Chapters"),
    "chooseAudioOutput": MessageLookupByLibrary.simpleMessage(
      "Choose audio output",
    ),
    "chooseAudiobooks": MessageLookupByLibrary.simpleMessage(
      "Choose audiobooks",
    ),
    "chooseSpeechModel": MessageLookupByLibrary.simpleMessage(
      "Choose speech model",
    ),
    "chooseSpeechModelDescription": MessageLookupByLibrary.simpleMessage(
      "Tap a model to select it. Models that are not on this device download automatically.",
    ),
    "clean": MessageLookupByLibrary.simpleMessage("Clean"),
    "clearDataFailed": MessageLookupByLibrary.simpleMessage(
      "Bookish could not remove all app data.",
    ),
    "close": MessageLookupByLibrary.simpleMessage("Close"),
    "continueSeries": MessageLookupByLibrary.simpleMessage("Continue series"),
    "continueSeriesDescription": MessageLookupByLibrary.simpleMessage(
      "Start the next unfinished volume automatically",
    ),
    "copyDiagnostic": MessageLookupByLibrary.simpleMessage("Copy diagnostic"),
    "copyErrorDetails": MessageLookupByLibrary.simpleMessage(
      "Copy error details",
    ),
    "copyFromFiles": MessageLookupByLibrary.simpleMessage("Copy from Files"),
    "copyFromFilesDescription": MessageLookupByLibrary.simpleMessage(
      "Keep the originals and copy them into Bookish",
    ),
    "couldNotLoadInsights": MessageLookupByLibrary.simpleMessage(
      "Could not load insights.",
    ),
    "couldNotLoadNotes": MessageLookupByLibrary.simpleMessage(
      "Could not load notes.",
    ),
    "dateAdded": MessageLookupByLibrary.simpleMessage("Date added"),
    "deleteAllUserDataDescription": MessageLookupByLibrary.simpleMessage(
      "Also delete notes, book details, cover, and listening history.",
    ),
    "deleteDiagnostics": MessageLookupByLibrary.simpleMessage(
      "Delete diagnostics",
    ),
    "deleteEverything": MessageLookupByLibrary.simpleMessage(
      "Delete everything",
    ),
    "deleteNote": MessageLookupByLibrary.simpleMessage("Delete note"),
    "diagnosticCopied": MessageLookupByLibrary.simpleMessage(
      "Diagnostic copied",
    ),
    "diagnosticFailureApology": MessageLookupByLibrary.simpleMessage(
      "We’re sorry for the inconvenience. Please try again. If the issue keeps happening, expand and copy the error details below and send them to us.",
    ),
    "diagnosticsDeleteFailed": MessageLookupByLibrary.simpleMessage(
      "Diagnostics could not be deleted.",
    ),
    "diagnosticsDeleted": MessageLookupByLibrary.simpleMessage(
      "Diagnostics deleted.",
    ),
    "diagnosticsDescription": MessageLookupByLibrary.simpleMessage(
      "Bookish keeps a bounded, sanitized error log on this device. It never includes book titles, notes, transcripts, or audio.",
    ),
    "diagnosticsExportFailed": MessageLookupByLibrary.simpleMessage(
      "Diagnostics could not be exported.",
    ),
    "diagnosticsExported": MessageLookupByLibrary.simpleMessage(
      "Diagnostics exported.",
    ),
    "diagnosticsNoRecords": MessageLookupByLibrary.simpleMessage(
      "There are no diagnostics to export.",
    ),
    "diagnosticsTitle": MessageLookupByLibrary.simpleMessage(
      "Local diagnostics",
    ),
    "dictateVoiceNote": MessageLookupByLibrary.simpleMessage(
      "Dictate voice note",
    ),
    "duplicateBooks": MessageLookupByLibrary.simpleMessage("Duplicate books"),
    "editAudiobook": MessageLookupByLibrary.simpleMessage("Edit audiobook"),
    "editMetadata": MessageLookupByLibrary.simpleMessage("Edit metadata"),
    "emptyListeningHistory": MessageLookupByLibrary.simpleMessage(
      "Your listening history will appear here.",
    ),
    "endOfChapter": MessageLookupByLibrary.simpleMessage("End of chapter"),
    "endOfChapterDescription": MessageLookupByLibrary.simpleMessage(
      "Stop at the next chapter boundary",
    ),
    "erase": MessageLookupByLibrary.simpleMessage("Erase"),
    "eraseAllAppData": MessageLookupByLibrary.simpleMessage(
      "Erase all app data",
    ),
    "eraseAllDataDescription": MessageLookupByLibrary.simpleMessage(
      "This permanently removes all audiobooks, covers, notes, listening history, settings, downloaded speech models, and app-managed files. This cannot be undone.",
    ),
    "eraseAllDataQuestion": MessageLookupByLibrary.simpleMessage(
      "Erase all Bookish data?",
    ),
    "eraseEverything": MessageLookupByLibrary.simpleMessage("Erase everything"),
    "errorDetails": MessageLookupByLibrary.simpleMessage("Error details"),
    "errorDetailsCopied": MessageLookupByLibrary.simpleMessage(
      "Error details copied",
    ),
    "exceptionAndStackTrace": MessageLookupByLibrary.simpleMessage(
      "Exception and stack trace",
    ),
    "exportBackup": MessageLookupByLibrary.simpleMessage("Export backup"),
    "exportBackupDescription": MessageLookupByLibrary.simpleMessage(
      "Save a portable Bookish JSON file",
    ),
    "exportDiagnostics": MessageLookupByLibrary.simpleMessage(
      "Export diagnostics",
    ),
    "exportNotes": MessageLookupByLibrary.simpleMessage("Export notes"),
    "externalOriginalsUnaffected": MessageLookupByLibrary.simpleMessage(
      "Original files outside Bookish are not affected.",
    ),
    "favorites": MessageLookupByLibrary.simpleMessage("Favorites"),
    "filterAndOrganizeLibrary": MessageLookupByLibrary.simpleMessage(
      "Filter and organize library",
    ),
    "finished": MessageLookupByLibrary.simpleMessage("Finished"),
    "finishedBook": MessageLookupByLibrary.simpleMessage("Finished book"),
    "folderField": MessageLookupByLibrary.simpleMessage("Folder"),
    "forwardInterval": MessageLookupByLibrary.simpleMessage("Forward interval"),
    "fromPosition": m2,
    "fullTitle": MessageLookupByLibrary.simpleMessage("Full title"),
    "gridLayout": MessageLookupByLibrary.simpleMessage("Grid"),
    "groupBy": MessageLookupByLibrary.simpleMessage("Group by"),
    "importAnalyzingChapters": MessageLookupByLibrary.simpleMessage(
      "Analyzing chapters",
    ),
    "importAudiobooks": MessageLookupByLibrary.simpleMessage(
      "Import audiobooks",
    ),
    "importCancelled": MessageLookupByLibrary.simpleMessage("Import cancelled"),
    "importCancelledDetail": m3,
    "importChooseFiles": MessageLookupByLibrary.simpleMessage(
      "Choose one or more audiobook files.",
    ),
    "importCopyProgress": m4,
    "importCopyingAudiobook": MessageLookupByLibrary.simpleMessage(
      "Copying audiobook",
    ),
    "importDiagnosticPrivacy": MessageLookupByLibrary.simpleMessage(
      "Book names, file paths, and raw errors are omitted.",
    ),
    "importExtractingArtwork": MessageLookupByLibrary.simpleMessage(
      "Extracting cover artwork",
    ),
    "importFailed": MessageLookupByLibrary.simpleMessage(
      "The audiobook could not be imported",
    ),
    "importFailureAtStage": m5,
    "importFailureForFileAtStage": m6,
    "importFileAccessFailed": MessageLookupByLibrary.simpleMessage(
      "Bookish could not access that file",
    ),
    "importFinderInstructions": MessageLookupByLibrary.simpleMessage(
      "In Finder, select your iPhone, open Files > Bookish, then drag audiobooks directly into the Bookish file area.",
    ),
    "importKeepOpen": MessageLookupByLibrary.simpleMessage(
      "Please keep Bookish open for a moment.",
    ),
    "importKeepOpenWithFile": m7,
    "importMalformedMetadata": MessageLookupByLibrary.simpleMessage(
      "The audiobook metadata is malformed",
    ),
    "importNoFilesSelected": MessageLookupByLibrary.simpleMessage(
      "No files were selected",
    ),
    "importNoTransferredAudiobooks": MessageLookupByLibrary.simpleMessage(
      "No transferred audiobooks found",
    ),
    "importOpeningFileBrowser": MessageLookupByLibrary.simpleMessage(
      "Opening file browser",
    ),
    "importOriginalsRemain": MessageLookupByLibrary.simpleMessage(
      "The book was copied, but the originals remain",
    ),
    "importOriginalsRemainDetail": MessageLookupByLibrary.simpleMessage(
      "The document provider did not allow Bookish to delete one or more originals. Your imported copy is safe. You can retry deletion or remove the originals in the Files app.",
    ),
    "importPreparingSelection": MessageLookupByLibrary.simpleMessage(
      "Preparing file selection",
    ),
    "importReadingAudioInformation": MessageLookupByLibrary.simpleMessage(
      "Reading audio information",
    ),
    "importRemovingOriginals": MessageLookupByLibrary.simpleMessage(
      "Removing originals",
    ),
    "importRemovingOriginalsDetail": MessageLookupByLibrary.simpleMessage(
      "The audiobook is safely copied. Bookish is now removing the selected original files.",
    ),
    "importSavingToLibrary": MessageLookupByLibrary.simpleMessage(
      "Saving to your library",
    ),
    "importSelectionCancelled": MessageLookupByLibrary.simpleMessage(
      "Android did not return any files to Bookish. You can open the file browser again or return to your library.",
    ),
    "importStageAnalyzingChapters": MessageLookupByLibrary.simpleMessage(
      "analyzing embedded chapters",
    ),
    "importStageCopyingFile": MessageLookupByLibrary.simpleMessage(
      "copying the file into Bookish",
    ),
    "importStageExtractingArtwork": MessageLookupByLibrary.simpleMessage(
      "reading embedded cover artwork",
    ),
    "importStageReadingDuration": MessageLookupByLibrary.simpleMessage(
      "opening the audio stream",
    ),
    "importStageRemovingOriginals": MessageLookupByLibrary.simpleMessage(
      "removing the selected original files",
    ),
    "importStageSavingBook": MessageLookupByLibrary.simpleMessage(
      "saving the library entry",
    ),
    "importStageSelectingFiles": MessageLookupByLibrary.simpleMessage(
      "receiving the file from the document provider",
    ),
    "importStageUnknown": MessageLookupByLibrary.simpleMessage(
      "processing the audiobook",
    ),
    "imported": MessageLookupByLibrary.simpleMessage("Imported"),
    "inLibrary": MessageLookupByLibrary.simpleMessage("In library"),
    "inProgress": MessageLookupByLibrary.simpleMessage("In progress"),
    "invalidBackup": MessageLookupByLibrary.simpleMessage(
      "This backup is invalid or incompatible.",
    ),
    "jump": MessageLookupByLibrary.simpleMessage("Jump"),
    "jumpToNote": MessageLookupByLibrary.simpleMessage("Jump to note"),
    "jumpToPositionQuestion": MessageLookupByLibrary.simpleMessage(
      "Jump to this position?",
    ),
    "keepUserDataDescription": MessageLookupByLibrary.simpleMessage(
      "Keep notes, book details, cover, and listening history.",
    ),
    "largeSeekBackward": m8,
    "largeSeekForward": m9,
    "lastMinutes": m10,
    "lastSeconds": m11,
    "lastSevenDays": MessageLookupByLibrary.simpleMessage("Last 7 days"),
    "lastThirtyDays": MessageLookupByLibrary.simpleMessage("Last 30 days"),
    "lastTwelveMonths": MessageLookupByLibrary.simpleMessage("Last 12 months"),
    "libraryLayoutSaveFailed": MessageLookupByLibrary.simpleMessage(
      "The library layout could not be saved.",
    ),
    "libraryLoadFailed": MessageLookupByLibrary.simpleMessage(
      "Could not open your library.",
    ),
    "librarySearchHint": MessageLookupByLibrary.simpleMessage(
      "Search title, author, narrator, or series",
    ),
    "librarySettingsDescription": MessageLookupByLibrary.simpleMessage(
      "Review your listening and manage local audiobook storage.",
    ),
    "libraryTitle": MessageLookupByLibrary.simpleMessage("Library"),
    "libraryView": MessageLookupByLibrary.simpleMessage("Library view"),
    "listLayout": MessageLookupByLibrary.simpleMessage("List"),
    "listening": MessageLookupByLibrary.simpleMessage("Listening"),
    "listeningActivity": MessageLookupByLibrary.simpleMessage(
      "Listening activity",
    ),
    "listeningInsightsDescription": MessageLookupByLibrary.simpleMessage(
      "Listening time, activity, and completed books",
    ),
    "listeningInsightsLoadFailed": MessageLookupByLibrary.simpleMessage(
      "Listening insights could not be loaded.",
    ),
    "listeningInsightsTitle": MessageLookupByLibrary.simpleMessage(
      "Listening insights",
    ),
    "listeningStatus": MessageLookupByLibrary.simpleMessage("Listening status"),
    "listeningTime": MessageLookupByLibrary.simpleMessage("Listening time"),
    "localDataDescription": MessageLookupByLibrary.simpleMessage(
      "Back up progress, notes, metadata, and settings without a cloud account.",
    ),
    "localDataTitle": MessageLookupByLibrary.simpleMessage("Local data"),
    "localTranscriptionDescription": MessageLookupByLibrary.simpleMessage(
      "Choose and download the on-device speech model used to turn audiobook ranges into quotes.",
    ),
    "localTranscriptionTitle": MessageLookupByLibrary.simpleMessage(
      "Local transcription",
    ),
    "managedStorage": m12,
    "markFinished": MessageLookupByLibrary.simpleMessage("Mark finished"),
    "markUnfinished": MessageLookupByLibrary.simpleMessage("Mark unfinished"),
    "metadataEditorLoadFailed": MessageLookupByLibrary.simpleMessage(
      "The audiobook editor could not be opened.",
    ),
    "metadataSaveFailed": MessageLookupByLibrary.simpleMessage(
      "Could not save audiobook metadata.",
    ),
    "minutesRemaining": m13,
    "minutesShort": m14,
    "missingAudioDescription": MessageLookupByLibrary.simpleMessage(
      "Its audio file is no longer available.",
    ),
    "missingFiles": MessageLookupByLibrary.simpleMessage("Missing files"),
    "modelAvailableToDownload": MessageLookupByLibrary.simpleMessage(
      "Available to download",
    ),
    "modelDownloaded": MessageLookupByLibrary.simpleMessage("Downloaded"),
    "modelNotDownloaded": MessageLookupByLibrary.simpleMessage(
      "Not downloaded",
    ),
    "modelSelected": MessageLookupByLibrary.simpleMessage("Selected"),
    "modelSize": m15,
    "month": MessageLookupByLibrary.simpleMessage("Month"),
    "moveFromFinderDescription": MessageLookupByLibrary.simpleMessage(
      "Copy into Bookish, then remove the transferred originals",
    ),
    "moveFromFinderTransfer": MessageLookupByLibrary.simpleMessage(
      "Move from Finder transfer",
    ),
    "narratorField": MessageLookupByLibrary.simpleMessage("Narrator"),
    "nextChapter": MessageLookupByLibrary.simpleMessage("Next chapter"),
    "noAudiobookSelected": MessageLookupByLibrary.simpleMessage(
      "No audiobook selected",
    ),
    "noBooksMatchFilters": MessageLookupByLibrary.simpleMessage(
      "No books match these filters.",
    ),
    "noDuplicateBooks": MessageLookupByLibrary.simpleMessage(
      "No duplicate books detected.",
    ),
    "noNotesYet": MessageLookupByLibrary.simpleMessage(
      "No notes yet. Add one while you listen.",
    ),
    "noSeries": MessageLookupByLibrary.simpleMessage("No series"),
    "noSpeechDetected": MessageLookupByLibrary.simpleMessage(
      "No speech was detected in this range.",
    ),
    "noSpeechModelsAvailable": MessageLookupByLibrary.simpleMessage(
      "No speech models available",
    ),
    "none": MessageLookupByLibrary.simpleMessage("None"),
    "notStarted": MessageLookupByLibrary.simpleMessage("Not started"),
    "noteAtPosition": m16,
    "noteCount": m17,
    "noteThoughtHint": MessageLookupByLibrary.simpleMessage(
      "A thought worth returning to…",
    ),
    "noteTitle": MessageLookupByLibrary.simpleMessage("Note"),
    "notes": MessageLookupByLibrary.simpleMessage("Notes"),
    "notesAndBookmarks": MessageLookupByLibrary.simpleMessage(
      "Notes and bookmarks",
    ),
    "notesAndBookmarksTitle": MessageLookupByLibrary.simpleMessage(
      "Notes & bookmarks",
    ),
    "notesEmptyDescription": MessageLookupByLibrary.simpleMessage(
      "Notes you save while listening will live here.",
    ),
    "notesExported": MessageLookupByLibrary.simpleMessage("Notes exported."),
    "notesGallery": MessageLookupByLibrary.simpleMessage("Notes gallery"),
    "notesLoadFailed": MessageLookupByLibrary.simpleMessage(
      "Your notes could not be loaded.",
    ),
    "notesTitle": MessageLookupByLibrary.simpleMessage("Notes"),
    "nowPlaying": MessageLookupByLibrary.simpleMessage("NOW PLAYING"),
    "off": MessageLookupByLibrary.simpleMessage("Off"),
    "openFileBrowserAgain": MessageLookupByLibrary.simpleMessage(
      "Open file browser again",
    ),
    "openSourceLicenses": MessageLookupByLibrary.simpleMessage(
      "Open-source licenses",
    ),
    "openSourceLicensesDescription": MessageLookupByLibrary.simpleMessage(
      "Licenses for Flutter and every package used by Bookish",
    ),
    "optionalTitle": MessageLookupByLibrary.simpleMessage("Title (optional)"),
    "output": MessageLookupByLibrary.simpleMessage("Output"),
    "pause": MessageLookupByLibrary.simpleMessage("Pause"),
    "paused": MessageLookupByLibrary.simpleMessage("Paused"),
    "play": MessageLookupByLibrary.simpleMessage("Play"),
    "playbackDescription": MessageLookupByLibrary.simpleMessage(
      "Tune Bookish for narration, sleep, and precise seeking.",
    ),
    "playbackPositionChanged": MessageLookupByLibrary.simpleMessage(
      "Playback position changed.",
    ),
    "playbackResetFailed": MessageLookupByLibrary.simpleMessage(
      "Playback could not be reset safely.",
    ),
    "playbackSettingsSaveFailed": MessageLookupByLibrary.simpleMessage(
      "Could not save playback settings.",
    ),
    "playbackSpeed": MessageLookupByLibrary.simpleMessage("Playback speed"),
    "playbackTitle": MessageLookupByLibrary.simpleMessage("Playback"),
    "playing": MessageLookupByLibrary.simpleMessage("Playing"),
    "possibleDuplicates": MessageLookupByLibrary.simpleMessage(
      "Possible duplicates",
    ),
    "previewQuote": MessageLookupByLibrary.simpleMessage("Preview quote"),
    "previousChapter": MessageLookupByLibrary.simpleMessage("Previous chapter"),
    "quietShelfDescription": MessageLookupByLibrary.simpleMessage(
      "Import MP3, M4A, M4B, AAC, FLAC, WAV, OGG, or Opus files from your device or cloud storage.",
    ),
    "quietShelfTitle": MessageLookupByLibrary.simpleMessage(
      "A quiet shelf, for now",
    ),
    "quote": MessageLookupByLibrary.simpleMessage("Quote"),
    "quoteSavedToNotes": MessageLookupByLibrary.simpleMessage(
      "Quote saved to notes.",
    ),
    "quoteShareSubject": m18,
    "quoteTimeRange": MessageLookupByLibrary.simpleMessage("Quote time range"),
    "quoteTranscriptionFailed": MessageLookupByLibrary.simpleMessage(
      "The quote could not be transcribed.",
    ),
    "rangeAccessibilityValue": m19,
    "rangeInChapter": m20,
    "recentlyAdded": MessageLookupByLibrary.simpleMessage("Recently added"),
    "reclaimableStorage": m21,
    "removeAudioOnly": MessageLookupByLibrary.simpleMessage(
      "Remove audio only",
    ),
    "removeBookQuestion": m22,
    "removeEntry": MessageLookupByLibrary.simpleMessage("Remove entry"),
    "removeFavorite": MessageLookupByLibrary.simpleMessage("Remove favorite"),
    "removeFromDevice": MessageLookupByLibrary.simpleMessage(
      "Remove from device",
    ),
    "removeMissingBookDescription": m23,
    "removeMissingEntryQuestion": MessageLookupByLibrary.simpleMessage(
      "Remove missing entry?",
    ),
    "removeMissingLibraryEntry": MessageLookupByLibrary.simpleMessage(
      "Remove missing library entry",
    ),
    "removeUnusedFiles": MessageLookupByLibrary.simpleMessage(
      "Remove unused files",
    ),
    "removeUnusedFilesQuestion": MessageLookupByLibrary.simpleMessage(
      "Remove unused files?",
    ),
    "resetBookish": MessageLookupByLibrary.simpleMessage("Reset Bookish"),
    "resetDataDescription": MessageLookupByLibrary.simpleMessage(
      "Remove every book, note, setting, listening record, speech model, and app-managed file.",
    ),
    "restoreBackup": MessageLookupByLibrary.simpleMessage("Restore backup"),
    "restoreBackupDescription": MessageLookupByLibrary.simpleMessage(
      "Replace local library data from a backup",
    ),
    "reviewAndEdit": MessageLookupByLibrary.simpleMessage("Review and edit"),
    "reviewTranscriptionDescription": MessageLookupByLibrary.simpleMessage(
      "Correct the local transcription before saving or sharing it.",
    ),
    "rewindInterval": MessageLookupByLibrary.simpleMessage("Rewind interval"),
    "save": MessageLookupByLibrary.simpleMessage("Save"),
    "saveDetails": MessageLookupByLibrary.simpleMessage("Save details"),
    "saveNote": MessageLookupByLibrary.simpleMessage("Save note"),
    "saveToNotes": MessageLookupByLibrary.simpleMessage("Save to notes"),
    "saveVoiceNote": MessageLookupByLibrary.simpleMessage("Save voice note"),
    "secondsEarlier": m24,
    "secondsLater": m25,
    "secondsShort": m26,
    "seriesField": MessageLookupByLibrary.simpleMessage("Series"),
    "settingsLoadFailed": MessageLookupByLibrary.simpleMessage(
      "Could not load appearance settings.",
    ),
    "settingsTitle": MessageLookupByLibrary.simpleMessage("Settings"),
    "share": MessageLookupByLibrary.simpleMessage("Share"),
    "shareErrorDetailsDescription": MessageLookupByLibrary.simpleMessage(
      "Share these details if the issue repeats",
    ),
    "shareNote": MessageLookupByLibrary.simpleMessage("Share note"),
    "shortenSilence": MessageLookupByLibrary.simpleMessage("Shorten silence"),
    "shortenSilenceDescription": MessageLookupByLibrary.simpleMessage(
      "Gently skips quiet gaps on supported devices",
    ),
    "show": MessageLookupByLibrary.simpleMessage("Show"),
    "sleepTimer": MessageLookupByLibrary.simpleMessage("Sleep timer"),
    "sortBy": MessageLookupByLibrary.simpleMessage("Sort by"),
    "speechModelDescription": MessageLookupByLibrary.simpleMessage(
      "Choose a model to use it. If needed, it downloads automatically. Audio and generated text stay on this device.",
    ),
    "speechModelDownloadFailed": MessageLookupByLibrary.simpleMessage(
      "Could not download the speech model.",
    ),
    "speechModelDownloaded": MessageLookupByLibrary.simpleMessage(
      "Speech model downloaded and ready.",
    ),
    "speechModelsLoadFailed": MessageLookupByLibrary.simpleMessage(
      "Could not load speech models.",
    ),
    "speechRecognitionFailed": MessageLookupByLibrary.simpleMessage(
      "Speech recognition stopped unexpectedly.",
    ),
    "speechRecognitionUnavailable": MessageLookupByLibrary.simpleMessage(
      "Speech recognition is not available.",
    ),
    "speechToTextModel": MessageLookupByLibrary.simpleMessage(
      "Speech-to-text model",
    ),
    "speedBrisk": MessageLookupByLibrary.simpleMessage("Brisk"),
    "speedFast": MessageLookupByLibrary.simpleMessage("Fast"),
    "speedFocused": MessageLookupByLibrary.simpleMessage("Focused"),
    "speedNatural": MessageLookupByLibrary.simpleMessage("Natural"),
    "speedRelaxed": MessageLookupByLibrary.simpleMessage("Relaxed"),
    "speedVeryFast": MessageLookupByLibrary.simpleMessage("Very fast"),
    "startListening": MessageLookupByLibrary.simpleMessage("Start listening"),
    "startTimeSeconds": MessageLookupByLibrary.simpleMessage(
      "Start time in seconds",
    ),
    "stopListening": MessageLookupByLibrary.simpleMessage("Stop listening"),
    "stopsAtEndOfChapter": MessageLookupByLibrary.simpleMessage(
      "Stops at end of chapter",
    ),
    "storageAssistantDescription": MessageLookupByLibrary.simpleMessage(
      "Find missing, duplicate, and unused files",
    ),
    "storageAssistantTitle": MessageLookupByLibrary.simpleMessage(
      "Storage assistant",
    ),
    "storageInspectFailed": MessageLookupByLibrary.simpleMessage(
      "Storage could not be inspected.",
    ),
    "technicalDetails": MessageLookupByLibrary.simpleMessage(
      "Technical details",
    ),
    "themeDark": MessageLookupByLibrary.simpleMessage("Dark"),
    "themeDarkDescription": MessageLookupByLibrary.simpleMessage(
      "Comfortable listening after lights out",
    ),
    "themeFollowSystem": MessageLookupByLibrary.simpleMessage("Follow system"),
    "themeFollowSystemDescription": MessageLookupByLibrary.simpleMessage(
      "Match your device appearance automatically",
    ),
    "themeLight": MessageLookupByLibrary.simpleMessage("Light"),
    "themeLightDescription": MessageLookupByLibrary.simpleMessage(
      "Warm paper and dark ink",
    ),
    "thisBook": MessageLookupByLibrary.simpleMessage("this book"),
    "timeRemaining": MessageLookupByLibrary.simpleMessage("Time remaining"),
    "timer": MessageLookupByLibrary.simpleMessage("Timer"),
    "timerActive": MessageLookupByLibrary.simpleMessage("Timer active"),
    "titleField": MessageLookupByLibrary.simpleMessage("Title"),
    "toPosition": m27,
    "trackOrder": MessageLookupByLibrary.simpleMessage("Track order"),
    "transcribeQuote": MessageLookupByLibrary.simpleMessage(
      "Transcribe a quote",
    ),
    "transcribeRange": MessageLookupByLibrary.simpleMessage("Transcribe range"),
    "transcribingOnDevice": MessageLookupByLibrary.simpleMessage(
      "Transcribing on device…",
    ),
    "transcriptionPlaceholder": MessageLookupByLibrary.simpleMessage(
      "The transcription will appear here.",
    ),
    "transcriptionRangeDescription": MessageLookupByLibrary.simpleMessage(
      "Choose the exact part of the audiobook. Transcription happens on this device and can take a while, especially for longer selections.",
    ),
    "tryAgain": MessageLookupByLibrary.simpleMessage("Try again"),
    "turnOffTimer": MessageLookupByLibrary.simpleMessage("Turn off timer"),
    "undo": MessageLookupByLibrary.simpleMessage("Undo"),
    "unknown": MessageLookupByLibrary.simpleMessage("Unknown"),
    "unknownAuthor": MessageLookupByLibrary.simpleMessage("Unknown author"),
    "unknownBook": MessageLookupByLibrary.simpleMessage("Unknown book"),
    "unusedFilesExplanation": MessageLookupByLibrary.simpleMessage(
      "Bookish will delete copied audio and cover files that are not referenced by any library entry.",
    ),
    "unusedFilesRemoved": MessageLookupByLibrary.simpleMessage(
      "Unused files removed.",
    ),
    "useProgressStatus": MessageLookupByLibrary.simpleMessage(
      "Use progress status",
    ),
    "viewFullTitle": MessageLookupByLibrary.simpleMessage("View full title"),
    "voiceBoost": MessageLookupByLibrary.simpleMessage("Voice boost"),
    "voiceBoostDescription": MessageLookupByLibrary.simpleMessage(
      "Emphasizes narration on supported devices",
    ),
    "voiceNote": MessageLookupByLibrary.simpleMessage("Voice note"),
    "voiceNotePrompt": MessageLookupByLibrary.simpleMessage(
      "Tap the microphone and speak.",
    ),
    "volumeNumberField": MessageLookupByLibrary.simpleMessage("Volume number"),
    "volumeNumberHint": MessageLookupByLibrary.simpleMessage(
      "For example 2 or 2.5",
    ),
    "wantToListen": MessageLookupByLibrary.simpleMessage("Want to listen"),
    "week": MessageLookupByLibrary.simpleMessage("Week"),
    "year": MessageLookupByLibrary.simpleMessage("Year"),
    "yearField": MessageLookupByLibrary.simpleMessage("Year"),
    "yourLibrary": MessageLookupByLibrary.simpleMessage("Your library"),
    "yourNotes": MessageLookupByLibrary.simpleMessage("Your notes"),
  };
}
