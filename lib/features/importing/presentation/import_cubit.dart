import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as p;
import 'package:uuid/uuid.dart';

import '../../library/domain/audiobook.dart';
import '../../library/domain/audiobook_repository.dart';
import '../../player/domain/audio_player_repository.dart';
import '../domain/audiobook_artwork_extractor.dart';
import '../domain/file_import_repository.dart';
import '../domain/import_diagnostics_repository.dart';
import '../domain/m4b_chapter_parser.dart';
import 'import_state.dart';

@injectable
class ImportCubit extends Cubit<ImportState> {
  ImportCubit(
    this._files,
    this._audio,
    this._books,
    this._chapters,
    this._artwork,
    this._diagnostics,
  ) : super(const ImportState());

  final FileImportRepository _files;
  final AudioPlayerRepository _audio;
  final AudiobookRepository _books;
  final M4bChapterParser _chapters;
  final AudiobookArtworkExtractor _artwork;
  final ImportDiagnosticsRepository _diagnostics;
  ImportStage _activeStage = ImportStage.selectingFiles;
  String? _activeFile;
  List<String> _parserDiagnostics = const [];
  DateTime? _stageStartedAt;
  final _stageHistory = <String>[];
  Future<void> Function()? _retryAction;

  Future<void> start() async {
    await _start(_files.pickAudioFiles);
  }

  Future<void> startFinderTransfer() async {
    await _start(
      _files.findTransferredAudioFiles,
      emptyHeading: 'No transferred audiobooks found',
      emptyDetail:
          'In Finder, select your iPhone, open Files > Bookish, then drag audiobooks directly into the Bookish file area.',
      removeAfterImport: true,
    );
  }

  Future<void> _start(
    Future<List<SelectedAudioFile>> Function() selectFiles, {
    String? emptyHeading,
    String? emptyDetail,
    bool removeAfterImport = false,
  }) async {
    _retryAction = () => _start(
      selectFiles,
      emptyHeading: emptyHeading,
      emptyDetail: emptyDetail,
      removeAfterImport: removeAfterImport,
    );
    try {
      _activeFile = null;
      _parserDiagnostics = const [];
      _stageStartedAt = null;
      _stageHistory.clear();
      _emitStage(
        ImportStage.selectingFiles,
        heading: 'Preparing file selection',
        detail: 'Waiting for your device’s document provider…',
      );
      // Give Flutter a frame to paint the loading state before presenting the
      // native document browser. Some providers keep resolving large/cloud
      // files briefly after their browser has disappeared.
      await Future<void>.delayed(const Duration(milliseconds: 50));
      final selectedFiles = await selectFiles();
      if (selectedFiles.isEmpty) {
        if (emptyHeading == null) {
          emit(state.copyWith(status: ImportStatus.cancelled));
        } else {
          emit(
            state.copyWith(
              status: ImportStatus.failure,
              heading: emptyHeading,
              detail: emptyDetail ?? '',
              diagnostics: null,
              progress: null,
            ),
          );
        }
        return;
      }
      if (selectedFiles.length > 1) {
        await _importCombinedBook(selectedFiles);
        if (removeAfterImport) {
          await _files.removeTransferredAudioFiles(selectedFiles);
        }
        emit(state.copyWith(status: ImportStatus.complete, importedCount: 1));
        return;
      }
      for (var index = 0; index < selectedFiles.length; index++) {
        final selected = selectedFiles[index];
        final title = _titleFromFilename(selected.displayName);
        _emitStage(
          ImportStage.copyingFile,
          selected: selected,
          index: index,
          total: selectedFiles.length,
          title: title,
        );
        final file = await _files.importFile(selected);
        _emitStage(
          ImportStage.readingDuration,
          selected: selected,
          index: index,
          total: selectedFiles.length,
          title: title,
        );
        final duration = await _audio.probeDuration(file.path);
        _emitStage(
          ImportStage.analyzingChapters,
          selected: selected,
          index: index,
          total: selectedFiles.length,
          title: title,
        );
        final chapterReport = await _chapters.analyze(file.path);
        _parserDiagnostics = [
          ...chapterReport.diagnostics,
          ...chapterReport.warnings,
        ];
        _emitStage(
          ImportStage.extractingArtwork,
          selected: selected,
          index: index,
          total: selectedFiles.length,
          title: title,
        );
        final artworkPath = await _artwork.extract(file.path);
        _emitStage(
          ImportStage.savingBook,
          selected: selected,
          index: index,
          total: selectedFiles.length,
          title: title,
        );
        await _books.saveBook(
          Audiobook(
            id: const Uuid().v4(),
            title: title,
            filePath: file.path,
            durationMs: duration.inMilliseconds,
            addedAt: DateTime.now(),
            chapters: chapterReport.chapters,
            artworkPath: artworkPath,
            artworkScanned: true,
          ),
        );
      }
      if (removeAfterImport) {
        await _files.removeTransferredAudioFiles(selectedFiles);
      }
      emit(
        state.copyWith(
          status: ImportStatus.complete,
          importedCount: selectedFiles.length,
        ),
      );
    } catch (error, stackTrace) {
      emit(
        state.copyWith(
          status: ImportStatus.failure,
          heading: _failureHeading(error),
          detail: _failureDetail(error),
          diagnostics: _buildDiagnostics(error, stackTrace),
          progress: null,
        ),
      );
    }
  }

  Future<void> _importCombinedBook(
    List<SelectedAudioFile> selectedFiles,
  ) async {
    final ordered = [...selectedFiles]
      ..sort(
        (a, b) =>
            _naturalKey(a.displayName).compareTo(_naturalKey(b.displayName)),
      );
    final title = _combinedTitle(ordered.first.displayName);
    _emitStage(
      ImportStage.copyingFile,
      selected: ordered.first,
      total: ordered.length,
      title: title,
    );
    final tracks = <AudioTrack>[];
    final chapters = <AudioChapter>[];
    String? artworkPath;
    var durationMs = 0;
    for (var index = 0; index < ordered.length; index++) {
      final selected = ordered[index];
      _emitStage(
        ImportStage.copyingFile,
        selected: selected,
        index: index,
        total: ordered.length,
        title: title,
      );
      final imported = await _files.importFile(selected);
      _emitStage(
        ImportStage.readingDuration,
        selected: selected,
        index: index,
        total: ordered.length,
        title: title,
      );
      final duration = await _audio.probeDuration(imported.path);
      _emitStage(
        ImportStage.analyzingChapters,
        selected: selected,
        index: index,
        total: ordered.length,
        title: title,
      );
      final chapterReport = await _chapters.analyze(imported.path);
      _parserDiagnostics = [
        ...chapterReport.diagnostics,
        ...chapterReport.warnings,
      ];
      _emitStage(
        ImportStage.extractingArtwork,
        selected: selected,
        index: index,
        total: ordered.length,
        title: title,
      );
      artworkPath ??= await _artwork.extract(imported.path);
      final trackTitle = _titleFromFilename(selected.displayName);
      tracks.add(
        AudioTrack(
          id: const Uuid().v4(),
          title: trackTitle,
          filePath: imported.path,
          durationMs: duration.inMilliseconds,
          order: index,
        ),
      );
      if (chapterReport.chapters.isEmpty) {
        chapters.add(AudioChapter(title: trackTitle, startMs: durationMs));
      } else {
        chapters.addAll(
          chapterReport.chapters.map(
            (chapter) =>
                chapter.copyWith(startMs: durationMs + chapter.startMs),
          ),
        );
      }
      durationMs += duration.inMilliseconds;
      emit(state.copyWith(importedCount: index + 1));
    }
    _emitStage(
      ImportStage.savingBook,
      selected: ordered.last,
      index: ordered.length,
      total: ordered.length,
      title: title,
    );
    await _books.saveBook(
      Audiobook(
        id: const Uuid().v4(),
        title: title,
        filePath: tracks.first.filePath,
        durationMs: durationMs,
        addedAt: DateTime.now(),
        artworkPath: artworkPath,
        artworkScanned: true,
        folder: p.basename(p.dirname(ordered.first.sourcePath)),
        tracks: tracks,
        chapters: chapters,
      ),
    );
  }

  Future<void> copyDiagnostics() async {
    final value = state.diagnostics;
    if (value != null) {
      await _diagnostics.copy(value);
    }
  }

  Future<void> retry() => _retryAction?.call() ?? start();

  void _emitStage(
    ImportStage stage, {
    SelectedAudioFile? selected,
    int index = 0,
    int total = 0,
    String? title,
    String? heading,
    String? detail,
  }) {
    final now = DateTime.now();
    if (_stageStartedAt case final started?) {
      _stageHistory.add(
        '${_activeStage.name}: ${now.difference(started).inMilliseconds} ms',
      );
    }
    _stageStartedAt = now;
    _activeStage = stage;
    _activeFile = selected?.displayName;
    final stageText = switch (stage) {
      ImportStage.selectingFiles => 'Preparing file selection',
      ImportStage.copyingFile => 'Copying audiobook',
      ImportStage.readingDuration => 'Reading audio information',
      ImportStage.analyzingChapters => 'Analyzing chapters',
      ImportStage.extractingArtwork => 'Extracting cover artwork',
      ImportStage.savingBook => 'Saving to your library',
    };
    final fileText = selected?.displayName ?? title;
    emit(
      state.copyWith(
        status: ImportStatus.importing,
        stage: stage,
        importedCount: index,
        totalFiles: total,
        currentTitle: title ?? fileText,
        heading: heading ?? stageText,
        detail:
            detail ??
            (fileText == null
                ? 'Please keep Bookish open for a moment.'
                : '$fileText\nPlease keep Bookish open for a moment.'),
        progress: total > 1 ? index / total : null,
        diagnostics: null,
      ),
    );
  }

  String _failureHeading(Object error) {
    if (error is FileSystemException) {
      return 'Bookish could not access that file';
    }
    if (error is FormatException) {
      return 'The audiobook metadata is malformed';
    }
    return 'The audiobook could not be imported';
  }

  String _failureDetail(Object error) {
    final stage = switch (_activeStage) {
      ImportStage.selectingFiles =>
        'receiving the file from the document provider',
      ImportStage.copyingFile => 'copying the file into Bookish',
      ImportStage.readingDuration => 'opening the audio stream',
      ImportStage.analyzingChapters => 'analyzing embedded chapters',
      ImportStage.extractingArtwork => 'reading embedded cover artwork',
      ImportStage.savingBook => 'saving the library entry',
    };
    final advice = error is FileSystemException
        ? 'Check that the file is still available, fully downloaded, and that the device has enough free storage.'
        : 'The detailed diagnostic below can be copied when reporting the problem.';
    return 'The failure happened while $stage. $advice';
  }

  String _buildDiagnostics(Object error, StackTrace stackTrace) {
    final lines = <String>[
      'Bookish import diagnostic',
      'Time: ${DateTime.now().toIso8601String()}',
      'Stage: ${_activeStage.name}',
      if (_activeFile != null) 'File: $_activeFile',
      'Platform: ${Platform.operatingSystem} ${Platform.operatingSystemVersion}',
      'Error type: ${error.runtimeType}',
      'Error: $error',
      '',
      'Completed stage timings:',
      if (_stageHistory.isEmpty) 'None' else ..._stageHistory,
      if (_stageStartedAt case final started?)
        '${_activeStage.name} before failure: '
            '${DateTime.now().difference(started).inMilliseconds} ms',
      '',
      'Stack trace:',
      '$stackTrace',
    ];
    if (_parserDiagnostics.isNotEmpty) {
      lines.addAll([
        '',
        'Latest chapter-parser analysis:',
        ..._parserDiagnostics,
      ]);
    }
    return lines.join('\n');
  }

  String _naturalKey(String value) {
    return value.toLowerCase().replaceAllMapped(
      RegExp(r'\d+'),
      (match) => match.group(0)!.padLeft(12, '0'),
    );
  }

  String _combinedTitle(String filename) {
    final base = p
        .basenameWithoutExtension(filename)
        .replaceAll(
          RegExp(
            r'[\s._-]*(?:cd|disc|part|chapter|track)?[\s._-]*\d+$',
            caseSensitive: false,
          ),
          '',
        );
    return _titleFromFilename(base.isEmpty ? filename : base);
  }

  String _titleFromFilename(String filename) {
    final raw = p
        .basenameWithoutExtension(filename)
        .replaceAll(RegExp('[_-]+'), ' ')
        .trim();
    if (raw.isEmpty) {
      return 'Untitled audiobook';
    }
    return raw
        .split(RegExp(r'\s+'))
        .map(
          (word) => word.isEmpty
              ? word
              : '${word[0].toUpperCase()}${word.substring(1)}',
        )
        .join(' ');
  }
}
