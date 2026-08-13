// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a sk locale. All the
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
  String get localeName => 'sk';

  static String m0(version) => "Verzia ${version}";

  static String m1(chapter, position) => "${chapter} · ${position}";

  static String m2(position) => "Od ${position}";

  static String m3(file, copied, total) =>
      "${file}\nSkopírované ${copied} z ${total}";

  static String m4(stage) =>
      "Zlyhanie nastalo počas činnosti: ${stage}. Úplnú diagnostiku nižšie môžete skopírovať pri nahlasovaní problému.";

  static String m5(file) => "${file}\nPonechajte Bookish chvíľu otvorený.";

  static String m6(duration) => "Posunie prehrávanie o ${duration} dozadu.";

  static String m7(duration) => "Posunie prehrávanie o ${duration} dopredu.";

  static String m8(count) => "Posledných ${count} min";

  static String m9(count) => "Posledných ${count} s";

  static String m10(size) => "Spravované: ${size}";

  static String m11(count) => "Zostáva približne ${count} minút";

  static String m12(count) => "${count} min";

  static String m13(size) => "${size} MB";

  static String m14(position) => "Poznámka na pozícii ${position}";

  static String m15(count) =>
      "${Intl.plural(count, one: '1 poznámka', few: '${count} poznámky', other: '${count} poznámok')}";

  static String m16(title) => "Citát z knihy ${title}";

  static String m17(start, end) => "${start} až ${end}";

  static String m18(start, end) => "${start} – ${end} v kapitole";

  static String m19(size) => "Bezpečne možno uvoľniť ${size}";

  static String m20(title) => "Odstrániť „${title}“?";

  static String m21(title) =>
      "„${title}“ bude odstránená z knižnice, pretože jej zvuk už nie je dostupný.";

  static String m22(count) => "o ${count} s skôr";

  static String m23(count) => "o ${count} s neskôr";

  static String m24(count) => "${count} s";

  static String m25(position) => "Do ${position}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "aboutBookish": MessageLookupByLibrary.simpleMessage("O aplikácii Bookish"),
    "aboutDescription": MessageLookupByLibrary.simpleMessage(
      "Informácie o aplikácii, verzia a oznámenia o otvorenom softvéri.",
    ),
    "aboutTitle": MessageLookupByLibrary.simpleMessage("O aplikácii"),
    "activeDays": MessageLookupByLibrary.simpleMessage("Aktívne dni"),
    "add": MessageLookupByLibrary.simpleMessage("Pridať"),
    "addBookmarkAtCurrentPosition": MessageLookupByLibrary.simpleMessage(
      "Pridať záložku na aktuálnej pozícii",
    ),
    "addChapter": MessageLookupByLibrary.simpleMessage("Pridať kapitolu"),
    "addFavorite": MessageLookupByLibrary.simpleMessage(
      "Pridať medzi obľúbené",
    ),
    "addNoteAtCurrentPosition": MessageLookupByLibrary.simpleMessage(
      "Pridať poznámku na aktuálnej pozícii",
    ),
    "allBooks": MessageLookupByLibrary.simpleMessage("Všetky knihy"),
    "allDataRemoved": MessageLookupByLibrary.simpleMessage(
      "Všetky dáta Bookish boli odstránené.",
    ),
    "allLibraryFilesAvailable": MessageLookupByLibrary.simpleMessage(
      "Všetky súbory knižnice sú dostupné.",
    ),
    "allTimeListening": MessageLookupByLibrary.simpleMessage(
      "Celkový čas počúvania",
    ),
    "appDescription": MessageLookupByLibrary.simpleMessage(
      "Pokojný offline prehrávač audiokníh.",
    ),
    "appTitle": MessageLookupByLibrary.simpleMessage("Bookish"),
    "appVersion": m0,
    "appearanceDescription": MessageLookupByLibrary.simpleMessage(
      "Vyberte, ako bude Bookish vyzerať na tomto zariadení.",
    ),
    "appearanceSettingsSaveFailed": MessageLookupByLibrary.simpleMessage(
      "Nastavenia vzhľadu sa nepodarilo uložiť.",
    ),
    "appearanceTitle": MessageLookupByLibrary.simpleMessage("Vzhľad"),
    "applicationLegalese": MessageLookupByLibrary.simpleMessage(
      "Autorské práva © 2026 prispievatelia Bookish",
    ),
    "archived": MessageLookupByLibrary.simpleMessage("Archivované"),
    "audioOutputsOpenFailed": MessageLookupByLibrary.simpleMessage(
      "Zvukové výstupy sa nepodarilo otvoriť.",
    ),
    "audiobook": MessageLookupByLibrary.simpleMessage("Audiokniha"),
    "audiobookImported": MessageLookupByLibrary.simpleMessage(
      "Audiokniha bola importovaná do Bookish",
    ),
    "audiobookNotFound": MessageLookupByLibrary.simpleMessage(
      "Audiokniha sa nenašla",
    ),
    "audiobookOpenFailed": MessageLookupByLibrary.simpleMessage(
      "Túto audioknihu sa nepodarilo otvoriť.",
    ),
    "audiobookPlaybackFailed": MessageLookupByLibrary.simpleMessage(
      "Túto audioknihu sa nepodarilo prehrať.",
    ),
    "authorField": MessageLookupByLibrary.simpleMessage("Autor"),
    "backToLibrary": MessageLookupByLibrary.simpleMessage("Späť do knižnice"),
    "backToLibraryTooltip": MessageLookupByLibrary.simpleMessage(
      "Späť do knižnice",
    ),
    "backupExportFailed": MessageLookupByLibrary.simpleMessage(
      "Zálohu sa nepodarilo exportovať.",
    ),
    "backupExported": MessageLookupByLibrary.simpleMessage(
      "Záloha bola exportovaná.",
    ),
    "backupRestoreFailed": MessageLookupByLibrary.simpleMessage(
      "Túto zálohu sa nepodarilo obnoviť.",
    ),
    "backupRestored": MessageLookupByLibrary.simpleMessage(
      "Záloha bola obnovená. Zvukové súbory musia zostať dostupné lokálne.",
    ),
    "bookActions": MessageLookupByLibrary.simpleMessage("Akcie knihy"),
    "bookRemovalFailed": MessageLookupByLibrary.simpleMessage(
      "Knihu sa nepodarilo odstrániť.",
    ),
    "bookUpdateFailed": MessageLookupByLibrary.simpleMessage(
      "Knihu sa nepodarilo aktualizovať.",
    ),
    "bookmarkSaved": MessageLookupByLibrary.simpleMessage("Záložka uložená."),
    "booksCompleted": MessageLookupByLibrary.simpleMessage("Dopočúvané knihy"),
    "cancel": MessageLookupByLibrary.simpleMessage("Zrušiť"),
    "changeCover": MessageLookupByLibrary.simpleMessage("Zmeniť obálku"),
    "chapterAtPosition": m1,
    "chapterFallbackDescription": MessageLookupByLibrary.simpleMessage(
      "Zastaví sa aj vtedy, keď chýba hranica kapitoly",
    ),
    "chapterTimerFallback": MessageLookupByLibrary.simpleMessage(
      "Náhradný časovač kapitoly",
    ),
    "chapters": MessageLookupByLibrary.simpleMessage("Kapitoly"),
    "chaptersTitle": MessageLookupByLibrary.simpleMessage("Kapitoly"),
    "chooseAudioOutput": MessageLookupByLibrary.simpleMessage(
      "Vybrať zvukový výstup",
    ),
    "chooseAudiobooks": MessageLookupByLibrary.simpleMessage(
      "Vybrať audioknihy",
    ),
    "chooseSpeechModel": MessageLookupByLibrary.simpleMessage(
      "Vybrať model reči",
    ),
    "chooseSpeechModelDescription": MessageLookupByLibrary.simpleMessage(
      "Klepnutím vyberte model. Modely, ktoré nie sú v zariadení, sa stiahnu automaticky.",
    ),
    "clean": MessageLookupByLibrary.simpleMessage("Vyčistiť"),
    "clearDataFailed": MessageLookupByLibrary.simpleMessage(
      "Bookish nedokázal odstrániť všetky dáta aplikácie.",
    ),
    "close": MessageLookupByLibrary.simpleMessage("Zavrieť"),
    "continueSeries": MessageLookupByLibrary.simpleMessage(
      "Pokračovať v sérii",
    ),
    "continueSeriesDescription": MessageLookupByLibrary.simpleMessage(
      "Automaticky spustí ďalší nedokončený diel",
    ),
    "copyDiagnostic": MessageLookupByLibrary.simpleMessage(
      "Kopírovať diagnostiku",
    ),
    "copyErrorDetails": MessageLookupByLibrary.simpleMessage(
      "Kopírovať podrobnosti chyby",
    ),
    "copyFromFiles": MessageLookupByLibrary.simpleMessage(
      "Kopírovať zo Súborov",
    ),
    "copyFromFilesDescription": MessageLookupByLibrary.simpleMessage(
      "Ponechať originály a skopírovať ich do Bookish",
    ),
    "couldNotLoadInsights": MessageLookupByLibrary.simpleMessage(
      "Štatistiky sa nepodarilo načítať.",
    ),
    "couldNotLoadNotes": MessageLookupByLibrary.simpleMessage(
      "Poznámky sa nepodarilo načítať.",
    ),
    "dateAdded": MessageLookupByLibrary.simpleMessage("Dátum pridania"),
    "deleteAllUserDataDescription": MessageLookupByLibrary.simpleMessage(
      "Odstráni aj poznámky, údaje knihy, obal a históriu počúvania.",
    ),
    "deleteDiagnostics": MessageLookupByLibrary.simpleMessage(
      "Odstrániť diagnostiku",
    ),
    "deleteEverything": MessageLookupByLibrary.simpleMessage(
      "Odstrániť všetko",
    ),
    "deleteNote": MessageLookupByLibrary.simpleMessage("Odstrániť poznámku"),
    "diagnosticCopied": MessageLookupByLibrary.simpleMessage(
      "Diagnostika skopírovaná",
    ),
    "diagnosticFailureApology": MessageLookupByLibrary.simpleMessage(
      "Ospravedlňujeme sa za nepríjemnosti. Skúste to znova. Ak problém pretrváva, rozbaľte a skopírujte podrobnosti chyby nižšie a pošlite nám ich.",
    ),
    "diagnosticsDeleteFailed": MessageLookupByLibrary.simpleMessage(
      "Diagnostiku sa nepodarilo odstrániť.",
    ),
    "diagnosticsDeleted": MessageLookupByLibrary.simpleMessage(
      "Diagnostika bola odstránená.",
    ),
    "diagnosticsDescription": MessageLookupByLibrary.simpleMessage(
      "Bookish uchováva v zariadení obmedzený a anonymizovaný denník chýb. Nikdy neobsahuje názvy kníh, poznámky, prepisy ani zvuk.",
    ),
    "diagnosticsExportFailed": MessageLookupByLibrary.simpleMessage(
      "Diagnostiku sa nepodarilo exportovať.",
    ),
    "diagnosticsExported": MessageLookupByLibrary.simpleMessage(
      "Diagnostika bola exportovaná.",
    ),
    "diagnosticsNoRecords": MessageLookupByLibrary.simpleMessage(
      "Nie je k dispozícii žiadna diagnostika na export.",
    ),
    "diagnosticsTitle": MessageLookupByLibrary.simpleMessage(
      "Lokálna diagnostika",
    ),
    "dictateVoiceNote": MessageLookupByLibrary.simpleMessage(
      "Nadiktovať hlasovú poznámku",
    ),
    "duplicateBooks": MessageLookupByLibrary.simpleMessage("Duplicitné knihy"),
    "editAudiobook": MessageLookupByLibrary.simpleMessage("Upraviť audioknihu"),
    "editMetadata": MessageLookupByLibrary.simpleMessage("Upraviť metadáta"),
    "emptyListeningHistory": MessageLookupByLibrary.simpleMessage(
      "História počúvania sa zobrazí tu.",
    ),
    "endOfChapter": MessageLookupByLibrary.simpleMessage("Koniec kapitoly"),
    "endOfChapterDescription": MessageLookupByLibrary.simpleMessage(
      "Zastaviť na najbližšej hranici kapitoly",
    ),
    "erase": MessageLookupByLibrary.simpleMessage("Vymazať"),
    "eraseAllAppData": MessageLookupByLibrary.simpleMessage(
      "Vymazať všetky údaje aplikácie",
    ),
    "eraseAllDataDescription": MessageLookupByLibrary.simpleMessage(
      "Natrvalo odstráni všetky audioknihy, obaly, poznámky, históriu počúvania, nastavenia, stiahnuté modely reči a súbory spravované aplikáciou. Túto akciu nemožno vrátiť späť.",
    ),
    "eraseAllDataQuestion": MessageLookupByLibrary.simpleMessage(
      "Vymazať všetky údaje Bookish?",
    ),
    "eraseEverything": MessageLookupByLibrary.simpleMessage("Vymazať všetko"),
    "errorDetails": MessageLookupByLibrary.simpleMessage("Podrobnosti chyby"),
    "errorDetailsCopied": MessageLookupByLibrary.simpleMessage(
      "Podrobnosti chyby skopírované",
    ),
    "exceptionAndStackTrace": MessageLookupByLibrary.simpleMessage(
      "Výnimka a zásobník volaní",
    ),
    "exportBackup": MessageLookupByLibrary.simpleMessage("Exportovať zálohu"),
    "exportBackupDescription": MessageLookupByLibrary.simpleMessage(
      "Uložiť prenosný súbor Bookish vo formáte JSON",
    ),
    "exportDiagnostics": MessageLookupByLibrary.simpleMessage(
      "Exportovať diagnostiku",
    ),
    "exportNotes": MessageLookupByLibrary.simpleMessage("Exportovať poznámky"),
    "externalOriginalsUnaffected": MessageLookupByLibrary.simpleMessage(
      "Pôvodné súbory mimo Bookish zostanú nedotknuté.",
    ),
    "favorites": MessageLookupByLibrary.simpleMessage("Obľúbené"),
    "filterAndOrganizeLibrary": MessageLookupByLibrary.simpleMessage(
      "Filtrovať a usporiadať knižnicu",
    ),
    "finished": MessageLookupByLibrary.simpleMessage("Dokončené"),
    "finishedBook": MessageLookupByLibrary.simpleMessage("Dopočúvaná kniha"),
    "folderField": MessageLookupByLibrary.simpleMessage("Priečinok"),
    "forwardInterval": MessageLookupByLibrary.simpleMessage(
      "Interval pretočenia dopredu",
    ),
    "fromPosition": m2,
    "fullTitle": MessageLookupByLibrary.simpleMessage("Celý názov"),
    "gridLayout": MessageLookupByLibrary.simpleMessage("Mriežka"),
    "groupBy": MessageLookupByLibrary.simpleMessage("Zoskupiť podľa"),
    "importAnalyzingChapters": MessageLookupByLibrary.simpleMessage(
      "Analýza kapitol",
    ),
    "importAudiobooks": MessageLookupByLibrary.simpleMessage(
      "Importovať audioknihy",
    ),
    "importChooseFiles": MessageLookupByLibrary.simpleMessage(
      "Vyberte jeden alebo viac súborov audiokníh.",
    ),
    "importCopyProgress": m3,
    "importCopyingAudiobook": MessageLookupByLibrary.simpleMessage(
      "Kopírovanie audioknihy",
    ),
    "importExtractingArtwork": MessageLookupByLibrary.simpleMessage(
      "Extrahovanie obálky",
    ),
    "importFailed": MessageLookupByLibrary.simpleMessage(
      "Audioknihu sa nepodarilo importovať",
    ),
    "importFailureAtStage": m4,
    "importFileAccessFailed": MessageLookupByLibrary.simpleMessage(
      "Bookish nemohol pristúpiť k súboru",
    ),
    "importFinderInstructions": MessageLookupByLibrary.simpleMessage(
      "Vo Finderi vyberte iPhone, otvorte Súbory > Bookish a presuňte audioknihy priamo do priestoru súborov Bookish.",
    ),
    "importKeepOpen": MessageLookupByLibrary.simpleMessage(
      "Ponechajte Bookish chvíľu otvorený.",
    ),
    "importKeepOpenWithFile": m5,
    "importMalformedMetadata": MessageLookupByLibrary.simpleMessage(
      "Metadáta audioknihy sú poškodené",
    ),
    "importNoFilesSelected": MessageLookupByLibrary.simpleMessage(
      "Neboli vybrané žiadne súbory",
    ),
    "importNoTransferredAudiobooks": MessageLookupByLibrary.simpleMessage(
      "Nenašli sa prenesené audioknihy",
    ),
    "importOpeningFileBrowser": MessageLookupByLibrary.simpleMessage(
      "Otváranie prehliadača súborov",
    ),
    "importOriginalsRemain": MessageLookupByLibrary.simpleMessage(
      "Kniha bola skopírovaná, ale originály zostali",
    ),
    "importOriginalsRemainDetail": MessageLookupByLibrary.simpleMessage(
      "Poskytovateľ dokumentov nepovolil Bookish odstrániť niektoré originály. Importovaná kópia je v bezpečí. Odstránenie môžete zopakovať alebo originály odstrániť v aplikácii Súbory.",
    ),
    "importPreparingSelection": MessageLookupByLibrary.simpleMessage(
      "Príprava výberu súborov",
    ),
    "importReadingAudioInformation": MessageLookupByLibrary.simpleMessage(
      "Načítavanie informácií o zvuku",
    ),
    "importRemovingOriginals": MessageLookupByLibrary.simpleMessage(
      "Odstraňovanie originálov",
    ),
    "importRemovingOriginalsDetail": MessageLookupByLibrary.simpleMessage(
      "Audiokniha je bezpečne skopírovaná. Bookish teraz odstraňuje vybrané pôvodné súbory.",
    ),
    "importSavingToLibrary": MessageLookupByLibrary.simpleMessage(
      "Ukladanie do knižnice",
    ),
    "importSelectionCancelled": MessageLookupByLibrary.simpleMessage(
      "Android nevrátil Bookish žiadne súbory. Môžete znova otvoriť prehliadač súborov alebo sa vrátiť do knižnice.",
    ),
    "importStageAnalyzingChapters": MessageLookupByLibrary.simpleMessage(
      "analýzy vložených kapitol",
    ),
    "importStageCopyingFile": MessageLookupByLibrary.simpleMessage(
      "kopírovania súboru do Bookish",
    ),
    "importStageExtractingArtwork": MessageLookupByLibrary.simpleMessage(
      "načítavania vloženej obálky",
    ),
    "importStageReadingDuration": MessageLookupByLibrary.simpleMessage(
      "otvárania zvukového toku",
    ),
    "importStageRemovingOriginals": MessageLookupByLibrary.simpleMessage(
      "odstraňovania vybraných pôvodných súborov",
    ),
    "importStageSavingBook": MessageLookupByLibrary.simpleMessage(
      "ukladania záznamu knižnice",
    ),
    "importStageSelectingFiles": MessageLookupByLibrary.simpleMessage(
      "prijímania súboru od poskytovateľa dokumentov",
    ),
    "importStageUnknown": MessageLookupByLibrary.simpleMessage(
      "spracovania audioknihy",
    ),
    "imported": MessageLookupByLibrary.simpleMessage("Importované"),
    "inLibrary": MessageLookupByLibrary.simpleMessage("V knižnici"),
    "inProgress": MessageLookupByLibrary.simpleMessage("Rozpočúvané"),
    "invalidBackup": MessageLookupByLibrary.simpleMessage(
      "Táto záloha je neplatná alebo nekompatibilná.",
    ),
    "jump": MessageLookupByLibrary.simpleMessage("Preskočiť"),
    "jumpToNote": MessageLookupByLibrary.simpleMessage("Preskočiť na poznámku"),
    "jumpToPositionQuestion": MessageLookupByLibrary.simpleMessage(
      "Preskočiť na túto pozíciu?",
    ),
    "keepUserDataDescription": MessageLookupByLibrary.simpleMessage(
      "Ponechá poznámky, údaje knihy, obal a históriu počúvania.",
    ),
    "largeSeekBackward": m6,
    "largeSeekForward": m7,
    "lastMinutes": m8,
    "lastSeconds": m9,
    "lastSevenDays": MessageLookupByLibrary.simpleMessage("Posledných 7 dní"),
    "lastThirtyDays": MessageLookupByLibrary.simpleMessage("Posledných 30 dní"),
    "lastTwelveMonths": MessageLookupByLibrary.simpleMessage(
      "Posledných 12 mesiacov",
    ),
    "libraryLayoutSaveFailed": MessageLookupByLibrary.simpleMessage(
      "Rozloženie knižnice sa nepodarilo uložiť.",
    ),
    "libraryLoadFailed": MessageLookupByLibrary.simpleMessage(
      "Knižnicu sa nepodarilo otvoriť.",
    ),
    "librarySearchHint": MessageLookupByLibrary.simpleMessage(
      "Hľadať názov, autora, rozprávača alebo sériu",
    ),
    "librarySettingsDescription": MessageLookupByLibrary.simpleMessage(
      "Prezrite si počúvanie a spravujte miestne úložisko audiokníh.",
    ),
    "libraryTitle": MessageLookupByLibrary.simpleMessage("Knižnica"),
    "libraryView": MessageLookupByLibrary.simpleMessage("Zobrazenie knižnice"),
    "listLayout": MessageLookupByLibrary.simpleMessage("Zoznam"),
    "listening": MessageLookupByLibrary.simpleMessage("Počúvanie"),
    "listeningActivity": MessageLookupByLibrary.simpleMessage(
      "Aktivita počúvania",
    ),
    "listeningInsightsDescription": MessageLookupByLibrary.simpleMessage(
      "Čas počúvania, aktivita a dokončené knihy",
    ),
    "listeningInsightsLoadFailed": MessageLookupByLibrary.simpleMessage(
      "Štatistiky počúvania sa nepodarilo načítať.",
    ),
    "listeningInsightsTitle": MessageLookupByLibrary.simpleMessage(
      "Štatistiky počúvania",
    ),
    "listeningStatus": MessageLookupByLibrary.simpleMessage("Stav počúvania"),
    "listeningTime": MessageLookupByLibrary.simpleMessage("Čas počúvania"),
    "localDataDescription": MessageLookupByLibrary.simpleMessage(
      "Zálohujte priebeh, poznámky, metadáta a nastavenia bez cloudového účtu.",
    ),
    "localDataTitle": MessageLookupByLibrary.simpleMessage("Lokálne údaje"),
    "localTranscriptionDescription": MessageLookupByLibrary.simpleMessage(
      "Vyberte a stiahnite model reči v zariadení, ktorý zmení úseky audioknihy na citáty.",
    ),
    "localTranscriptionTitle": MessageLookupByLibrary.simpleMessage(
      "Lokálny prepis",
    ),
    "managedStorage": m10,
    "markFinished": MessageLookupByLibrary.simpleMessage(
      "Označiť ako dokončené",
    ),
    "markUnfinished": MessageLookupByLibrary.simpleMessage(
      "Označiť ako nedokončené",
    ),
    "metadataEditorLoadFailed": MessageLookupByLibrary.simpleMessage(
      "Editor audioknihy sa nepodarilo otvoriť.",
    ),
    "metadataSaveFailed": MessageLookupByLibrary.simpleMessage(
      "Metadáta audioknihy sa nepodarilo uložiť.",
    ),
    "minutesRemaining": m11,
    "minutesShort": m12,
    "missingAudioDescription": MessageLookupByLibrary.simpleMessage(
      "Jeho zvukový súbor už nie je dostupný.",
    ),
    "missingFiles": MessageLookupByLibrary.simpleMessage("Chýbajúce súbory"),
    "modelAvailableToDownload": MessageLookupByLibrary.simpleMessage(
      "Dostupný na stiahnutie",
    ),
    "modelDownloaded": MessageLookupByLibrary.simpleMessage("Stiahnutý"),
    "modelNotDownloaded": MessageLookupByLibrary.simpleMessage("Nestiahnutý"),
    "modelSelected": MessageLookupByLibrary.simpleMessage("Vybraný"),
    "modelSize": m13,
    "month": MessageLookupByLibrary.simpleMessage("Mesiac"),
    "moveFromFinderDescription": MessageLookupByLibrary.simpleMessage(
      "Skopírovať do Bookish a potom odstrániť prenesené originály",
    ),
    "moveFromFinderTransfer": MessageLookupByLibrary.simpleMessage(
      "Presunúť z prenosu Finder",
    ),
    "narratorField": MessageLookupByLibrary.simpleMessage("Rozprávač"),
    "nextChapter": MessageLookupByLibrary.simpleMessage("Nasledujúca kapitola"),
    "noAudiobookSelected": MessageLookupByLibrary.simpleMessage(
      "Nie je vybraná audiokniha",
    ),
    "noBooksMatchFilters": MessageLookupByLibrary.simpleMessage(
      "Žiadne knihy nezodpovedajú týmto filtrom.",
    ),
    "noDuplicateBooks": MessageLookupByLibrary.simpleMessage(
      "Nenašli sa duplicitné knihy.",
    ),
    "noNotesYet": MessageLookupByLibrary.simpleMessage(
      "Zatiaľ žiadne poznámky. Pridajte ich počas počúvania.",
    ),
    "noSeries": MessageLookupByLibrary.simpleMessage("Bez série"),
    "noSpeechDetected": MessageLookupByLibrary.simpleMessage(
      "V tomto úseku nebola rozpoznaná reč.",
    ),
    "noSpeechModelsAvailable": MessageLookupByLibrary.simpleMessage(
      "Nie sú dostupné žiadne modely reči",
    ),
    "none": MessageLookupByLibrary.simpleMessage("Žiadne"),
    "notStarted": MessageLookupByLibrary.simpleMessage("Nezačaté"),
    "noteAtPosition": m14,
    "noteCount": m15,
    "noteThoughtHint": MessageLookupByLibrary.simpleMessage(
      "Myšlienka, ku ktorej sa oplatí vrátiť…",
    ),
    "noteTitle": MessageLookupByLibrary.simpleMessage("Poznámka"),
    "notes": MessageLookupByLibrary.simpleMessage("Poznámky"),
    "notesAndBookmarks": MessageLookupByLibrary.simpleMessage(
      "Poznámky a záložky",
    ),
    "notesAndBookmarksTitle": MessageLookupByLibrary.simpleMessage(
      "Poznámky a záložky",
    ),
    "notesEmptyDescription": MessageLookupByLibrary.simpleMessage(
      "Poznámky uložené počas počúvania sa zobrazia tu.",
    ),
    "notesExported": MessageLookupByLibrary.simpleMessage(
      "Poznámky exportované.",
    ),
    "notesGallery": MessageLookupByLibrary.simpleMessage("Galéria poznámok"),
    "notesLoadFailed": MessageLookupByLibrary.simpleMessage(
      "Poznámky sa nepodarilo načítať.",
    ),
    "notesTitle": MessageLookupByLibrary.simpleMessage("Poznámky"),
    "nowPlaying": MessageLookupByLibrary.simpleMessage("PRÁVE SA PREHRÁVA"),
    "off": MessageLookupByLibrary.simpleMessage("Vypnuté"),
    "openFileBrowserAgain": MessageLookupByLibrary.simpleMessage(
      "Znova otvoriť prehliadač súborov",
    ),
    "openSourceLicenses": MessageLookupByLibrary.simpleMessage(
      "Licencie otvoreného softvéru",
    ),
    "openSourceLicensesDescription": MessageLookupByLibrary.simpleMessage(
      "Licencie Fluttera a všetkých balíkov použitých v Bookish",
    ),
    "optionalTitle": MessageLookupByLibrary.simpleMessage("Názov (voliteľné)"),
    "output": MessageLookupByLibrary.simpleMessage("Výstup"),
    "pause": MessageLookupByLibrary.simpleMessage("Pozastaviť"),
    "paused": MessageLookupByLibrary.simpleMessage("Pozastavené"),
    "play": MessageLookupByLibrary.simpleMessage("Prehrať"),
    "playbackDescription": MessageLookupByLibrary.simpleMessage(
      "Prispôsobte rozprávanie, spánok a presné posúvanie.",
    ),
    "playbackPositionChanged": MessageLookupByLibrary.simpleMessage(
      "Pozícia prehrávania bola zmenená.",
    ),
    "playbackResetFailed": MessageLookupByLibrary.simpleMessage(
      "Prehrávanie sa nepodarilo bezpečne obnoviť.",
    ),
    "playbackSettingsSaveFailed": MessageLookupByLibrary.simpleMessage(
      "Nastavenia prehrávania sa nepodarilo uložiť.",
    ),
    "playbackSpeed": MessageLookupByLibrary.simpleMessage(
      "Rýchlosť prehrávania",
    ),
    "playbackTitle": MessageLookupByLibrary.simpleMessage("Prehrávanie"),
    "playing": MessageLookupByLibrary.simpleMessage("Prehráva sa"),
    "possibleDuplicates": MessageLookupByLibrary.simpleMessage(
      "Možné duplikáty",
    ),
    "previewQuote": MessageLookupByLibrary.simpleMessage("Náhľad citátu"),
    "previousChapter": MessageLookupByLibrary.simpleMessage(
      "Predchádzajúca kapitola",
    ),
    "quietShelfDescription": MessageLookupByLibrary.simpleMessage(
      "Importujte zo zariadenia alebo cloudového úložiska súbory MP3, M4A, M4B, AAC, FLAC, WAV, OGG alebo Opus.",
    ),
    "quietShelfTitle": MessageLookupByLibrary.simpleMessage(
      "Zatiaľ tichá polica",
    ),
    "quote": MessageLookupByLibrary.simpleMessage("Citát"),
    "quoteSavedToNotes": MessageLookupByLibrary.simpleMessage(
      "Citát bol uložený do poznámok.",
    ),
    "quoteShareSubject": m16,
    "quoteTimeRange": MessageLookupByLibrary.simpleMessage(
      "Časový rozsah citátu",
    ),
    "quoteTranscriptionFailed": MessageLookupByLibrary.simpleMessage(
      "Citát sa nepodarilo prepísať.",
    ),
    "rangeAccessibilityValue": m17,
    "rangeInChapter": m18,
    "recentlyAdded": MessageLookupByLibrary.simpleMessage("Nedávno pridané"),
    "reclaimableStorage": m19,
    "removeAudioOnly": MessageLookupByLibrary.simpleMessage(
      "Odstrániť iba zvuk",
    ),
    "removeBookQuestion": m20,
    "removeEntry": MessageLookupByLibrary.simpleMessage("Odstrániť záznam"),
    "removeFavorite": MessageLookupByLibrary.simpleMessage(
      "Odobrať z obľúbených",
    ),
    "removeFromDevice": MessageLookupByLibrary.simpleMessage(
      "Odstrániť zo zariadenia",
    ),
    "removeMissingBookDescription": m21,
    "removeMissingEntryQuestion": MessageLookupByLibrary.simpleMessage(
      "Odstrániť chýbajúci záznam?",
    ),
    "removeMissingLibraryEntry": MessageLookupByLibrary.simpleMessage(
      "Odstrániť chýbajúci záznam knižnice",
    ),
    "removeUnusedFiles": MessageLookupByLibrary.simpleMessage(
      "Odstrániť nepoužívané súbory",
    ),
    "removeUnusedFilesQuestion": MessageLookupByLibrary.simpleMessage(
      "Odstrániť nepoužívané súbory?",
    ),
    "resetBookish": MessageLookupByLibrary.simpleMessage("Obnoviť Bookish"),
    "resetDataDescription": MessageLookupByLibrary.simpleMessage(
      "Odstráni všetky knihy, poznámky, nastavenia, záznamy počúvania, modely reči a súbory spravované aplikáciou.",
    ),
    "restoreBackup": MessageLookupByLibrary.simpleMessage("Obnoviť zálohu"),
    "restoreBackupDescription": MessageLookupByLibrary.simpleMessage(
      "Nahradiť lokálne údaje knižnice zo zálohy",
    ),
    "reviewAndEdit": MessageLookupByLibrary.simpleMessage(
      "Skontrolovať a upraviť",
    ),
    "reviewTranscriptionDescription": MessageLookupByLibrary.simpleMessage(
      "Pred uložením alebo zdieľaním opravte miestny prepis.",
    ),
    "rewindInterval": MessageLookupByLibrary.simpleMessage(
      "Interval pretočenia späť",
    ),
    "save": MessageLookupByLibrary.simpleMessage("Uložiť"),
    "saveDetails": MessageLookupByLibrary.simpleMessage("Uložiť podrobnosti"),
    "saveNote": MessageLookupByLibrary.simpleMessage("Uložiť poznámku"),
    "saveToNotes": MessageLookupByLibrary.simpleMessage("Uložiť do poznámok"),
    "saveVoiceNote": MessageLookupByLibrary.simpleMessage(
      "Uložiť hlasovú poznámku",
    ),
    "secondsEarlier": m22,
    "secondsLater": m23,
    "secondsShort": m24,
    "seriesField": MessageLookupByLibrary.simpleMessage("Séria"),
    "settingsLoadFailed": MessageLookupByLibrary.simpleMessage(
      "Nastavenia vzhľadu sa nepodarilo načítať.",
    ),
    "settingsTitle": MessageLookupByLibrary.simpleMessage("Nastavenia"),
    "share": MessageLookupByLibrary.simpleMessage("Zdieľať"),
    "shareErrorDetailsDescription": MessageLookupByLibrary.simpleMessage(
      "Ak sa problém zopakuje, zdieľajte tieto podrobnosti",
    ),
    "shareNote": MessageLookupByLibrary.simpleMessage("Zdieľať poznámku"),
    "shortenSilence": MessageLookupByLibrary.simpleMessage("Skracovať ticho"),
    "shortenSilenceDescription": MessageLookupByLibrary.simpleMessage(
      "Na podporovaných zariadeniach jemne preskakuje tiché úseky",
    ),
    "show": MessageLookupByLibrary.simpleMessage("Zobraziť"),
    "sleepTimer": MessageLookupByLibrary.simpleMessage("Časovač spánku"),
    "sortBy": MessageLookupByLibrary.simpleMessage("Zoradiť podľa"),
    "speechModelDescription": MessageLookupByLibrary.simpleMessage(
      "Vyberte model, ktorý chcete používať. V prípade potreby sa stiahne automaticky. Zvuk aj vytvorený text zostanú v tomto zariadení.",
    ),
    "speechModelDownloadFailed": MessageLookupByLibrary.simpleMessage(
      "Model reči sa nepodarilo stiahnuť.",
    ),
    "speechModelDownloaded": MessageLookupByLibrary.simpleMessage(
      "Model reči je stiahnutý a pripravený.",
    ),
    "speechModelsLoadFailed": MessageLookupByLibrary.simpleMessage(
      "Modely reči sa nepodarilo načítať.",
    ),
    "speechRecognitionFailed": MessageLookupByLibrary.simpleMessage(
      "Rozpoznávanie reči sa neočakávane zastavilo.",
    ),
    "speechRecognitionUnavailable": MessageLookupByLibrary.simpleMessage(
      "Rozpoznávanie reči nie je dostupné.",
    ),
    "speechToTextModel": MessageLookupByLibrary.simpleMessage(
      "Model prevodu reči na text",
    ),
    "speedBrisk": MessageLookupByLibrary.simpleMessage("Svižná"),
    "speedFast": MessageLookupByLibrary.simpleMessage("Rýchla"),
    "speedFocused": MessageLookupByLibrary.simpleMessage("Sústredená"),
    "speedNatural": MessageLookupByLibrary.simpleMessage("Prirodzená"),
    "speedRelaxed": MessageLookupByLibrary.simpleMessage("Pokojná"),
    "speedVeryFast": MessageLookupByLibrary.simpleMessage("Veľmi rýchla"),
    "startListening": MessageLookupByLibrary.simpleMessage("Začať počúvať"),
    "startTimeSeconds": MessageLookupByLibrary.simpleMessage(
      "Začiatok v sekundách",
    ),
    "stopListening": MessageLookupByLibrary.simpleMessage("Zastaviť počúvanie"),
    "stopsAtEndOfChapter": MessageLookupByLibrary.simpleMessage(
      "Zastaví sa na konci kapitoly",
    ),
    "storageAssistantDescription": MessageLookupByLibrary.simpleMessage(
      "Nájdite chýbajúce, duplicitné a nepoužívané súbory",
    ),
    "storageAssistantTitle": MessageLookupByLibrary.simpleMessage(
      "Správca úložiska",
    ),
    "storageInspectFailed": MessageLookupByLibrary.simpleMessage(
      "Úložisko sa nepodarilo skontrolovať.",
    ),
    "technicalDetails": MessageLookupByLibrary.simpleMessage(
      "Technické podrobnosti",
    ),
    "themeDark": MessageLookupByLibrary.simpleMessage("Tmavý"),
    "themeDarkDescription": MessageLookupByLibrary.simpleMessage(
      "Pohodlné počúvanie po zhasnutí svetiel",
    ),
    "themeFollowSystem": MessageLookupByLibrary.simpleMessage("Podľa systému"),
    "themeFollowSystemDescription": MessageLookupByLibrary.simpleMessage(
      "Automaticky prispôsobiť vzhľad zariadeniu",
    ),
    "themeLight": MessageLookupByLibrary.simpleMessage("Svetlý"),
    "themeLightDescription": MessageLookupByLibrary.simpleMessage(
      "Teplý papier a tmavý atrament",
    ),
    "thisBook": MessageLookupByLibrary.simpleMessage("táto kniha"),
    "timeRemaining": MessageLookupByLibrary.simpleMessage("Zostávajúci čas"),
    "timer": MessageLookupByLibrary.simpleMessage("Časovač"),
    "timerActive": MessageLookupByLibrary.simpleMessage("Časovač je aktívny"),
    "titleField": MessageLookupByLibrary.simpleMessage("Názov"),
    "toPosition": m25,
    "trackOrder": MessageLookupByLibrary.simpleMessage("Poradie stôp"),
    "transcribeQuote": MessageLookupByLibrary.simpleMessage("Prepísať citát"),
    "transcribeRange": MessageLookupByLibrary.simpleMessage("Prepísať rozsah"),
    "transcribingOnDevice": MessageLookupByLibrary.simpleMessage(
      "Prepisuje sa v zariadení…",
    ),
    "transcriptionPlaceholder": MessageLookupByLibrary.simpleMessage(
      "Prepis sa zobrazí tu.",
    ),
    "transcriptionRangeDescription": MessageLookupByLibrary.simpleMessage(
      "Vyberte presnú časť audioknihy. Prepis prebieha v tomto zariadení a najmä pri dlhších výberoch môže chvíľu trvať.",
    ),
    "tryAgain": MessageLookupByLibrary.simpleMessage("Skúsiť znova"),
    "turnOffTimer": MessageLookupByLibrary.simpleMessage("Vypnúť časovač"),
    "undo": MessageLookupByLibrary.simpleMessage("Späť"),
    "unknown": MessageLookupByLibrary.simpleMessage("Neznáme"),
    "unknownAuthor": MessageLookupByLibrary.simpleMessage("Neznámy autor"),
    "unknownBook": MessageLookupByLibrary.simpleMessage("Neznáma kniha"),
    "unusedFilesExplanation": MessageLookupByLibrary.simpleMessage(
      "Bookish odstráni skopírované zvukové súbory a obálky, na ktoré neodkazuje žiadny záznam knižnice.",
    ),
    "unusedFilesRemoved": MessageLookupByLibrary.simpleMessage(
      "Nepoužívané súbory boli odstránené.",
    ),
    "useProgressStatus": MessageLookupByLibrary.simpleMessage(
      "Použiť stav podľa priebehu",
    ),
    "viewFullTitle": MessageLookupByLibrary.simpleMessage(
      "Zobraziť celý názov",
    ),
    "voiceBoost": MessageLookupByLibrary.simpleMessage("Zvýrazniť hlas"),
    "voiceBoostDescription": MessageLookupByLibrary.simpleMessage(
      "Na podporovaných zariadeniach zvýrazní rozprávanie",
    ),
    "voiceNote": MessageLookupByLibrary.simpleMessage("Hlasová poznámka"),
    "voiceNotePrompt": MessageLookupByLibrary.simpleMessage(
      "Ťuknite na mikrofón a hovorte.",
    ),
    "volumeNumberField": MessageLookupByLibrary.simpleMessage("Číslo dielu"),
    "volumeNumberHint": MessageLookupByLibrary.simpleMessage(
      "Napríklad 2 alebo 2,5",
    ),
    "wantToListen": MessageLookupByLibrary.simpleMessage("Chcem počúvať"),
    "week": MessageLookupByLibrary.simpleMessage("Týždeň"),
    "year": MessageLookupByLibrary.simpleMessage("Rok"),
    "yearField": MessageLookupByLibrary.simpleMessage("Rok"),
    "yourLibrary": MessageLookupByLibrary.simpleMessage("Vaša knižnica"),
    "yourNotes": MessageLookupByLibrary.simpleMessage("Vaše poznámky"),
  };
}
