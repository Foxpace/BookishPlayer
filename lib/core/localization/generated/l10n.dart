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
