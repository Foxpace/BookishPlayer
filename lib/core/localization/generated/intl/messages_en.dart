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

  static String m1(date, duration) => "${date} · ${duration}";

  static String m2(size) => "${size} MB";

  static String m3(speed) => "${speed}×";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "aboutBookish": MessageLookupByLibrary.simpleMessage("About Bookish"),
    "aboutDescription": MessageLookupByLibrary.simpleMessage(
      "App information, version, and open-source notices.",
    ),
    "aboutTitle": MessageLookupByLibrary.simpleMessage("About"),
    "activeDays": MessageLookupByLibrary.simpleMessage("Active days"),
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
    "appearanceTitle": MessageLookupByLibrary.simpleMessage("Appearance"),
    "applicationLegalese": MessageLookupByLibrary.simpleMessage(
      "Copyright © 2026 Bookish contributors",
    ),
    "booksCompleted": MessageLookupByLibrary.simpleMessage("Books completed"),
    "chooseSpeechModel": MessageLookupByLibrary.simpleMessage(
      "Choose speech model",
    ),
    "chooseSpeechModelDescription": MessageLookupByLibrary.simpleMessage(
      "Tap a model to select it. Models that are not on this device download automatically.",
    ),
    "couldNotLoadInsights": MessageLookupByLibrary.simpleMessage(
      "Could not load insights.",
    ),
    "emptyListeningHistory": MessageLookupByLibrary.simpleMessage(
      "Your listening history will appear here.",
    ),
    "exportBackup": MessageLookupByLibrary.simpleMessage("Export backup"),
    "exportBackupDescription": MessageLookupByLibrary.simpleMessage(
      "Save a portable Bookish JSON file",
    ),
    "finishedBook": MessageLookupByLibrary.simpleMessage("Finished book"),
    "lastSevenDays": MessageLookupByLibrary.simpleMessage("Last 7 days"),
    "listeningInsightsTitle": MessageLookupByLibrary.simpleMessage(
      "Listening insights",
    ),
    "listeningSessionDetails": m1,
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
    "modelAvailableToDownload": MessageLookupByLibrary.simpleMessage(
      "Available to download",
    ),
    "modelDownloaded": MessageLookupByLibrary.simpleMessage("Downloaded"),
    "modelNotDownloaded": MessageLookupByLibrary.simpleMessage(
      "Not downloaded",
    ),
    "modelSelected": MessageLookupByLibrary.simpleMessage("Selected"),
    "modelSize": m2,
    "noSpeechModelsAvailable": MessageLookupByLibrary.simpleMessage(
      "No speech models available",
    ),
    "openSourceLicenses": MessageLookupByLibrary.simpleMessage(
      "Open-source licenses",
    ),
    "openSourceLicensesDescription": MessageLookupByLibrary.simpleMessage(
      "Licenses for Flutter and every package used by Bookish",
    ),
    "playbackSpeed": m3,
    "recentSessions": MessageLookupByLibrary.simpleMessage("Recent sessions"),
    "removedBook": MessageLookupByLibrary.simpleMessage("Removed book"),
    "restoreBackup": MessageLookupByLibrary.simpleMessage("Restore backup"),
    "restoreBackupDescription": MessageLookupByLibrary.simpleMessage(
      "Replace local library data from a backup",
    ),
    "settingsTitle": MessageLookupByLibrary.simpleMessage("Settings"),
    "speechModelDescription": MessageLookupByLibrary.simpleMessage(
      "Choose a model to use it. If needed, it downloads automatically. Audio and generated text stay on this device.",
    ),
    "speechToTextModel": MessageLookupByLibrary.simpleMessage(
      "Speech-to-text model",
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
  };
}
