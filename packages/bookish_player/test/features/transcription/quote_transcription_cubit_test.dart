import 'package:bookish_player/core/foundation/result.dart';
import 'package:bookish_player/features/library/models/library_models.dart';
import 'package:bookish_player/features/player/models/share_origin.dart';
import 'package:bookish_player/features/player/repos/quote_share_repository.dart';
import 'package:bookish_player/features/transcription/cubits/quote_transcription_cubit.dart';
import 'package:bookish_player/features/transcription/cubits/transcription_cubits.dart';
import 'package:bookish_player/features/transcription/repos/transcription_preferences.dart';
import 'package:bookish_player/features/transcription/models/speech_model.dart';
import 'package:bookish_player/features/transcription/models/transcription_download.dart';
import 'package:bookish_player/features/transcription/repos/transcription_repository.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_support/features/transcription/transcription_test_builder.dart';

void main() {
  group('Quote transcription cubit', () {
    test('Given a saved model that is no longer downloaded, When transcribing, Then another downloaded model is used', () async {
      // GIVEN
      final transcription = _Transcription()
        ..models = const [
          SpeechModel(slug: 'whisper-tiny', isDownloaded: false),
          SpeechModel(slug: 'whisper-base', isDownloaded: true),
        ];
      final application = buildQuoteTranscriptionApplication(
        transcription: transcription,
        preferences: _Settings(),
        sharing: _Sharing(),
      );

      // WHEN
      await application.transcribe(
        book: Audiobook(
          id: 'book',
          title: 'Book',
          filePath: '/book.mp3',
          durationMs: 60000,
          addedAt: DateTime(2026),
        ),
        start: Duration.zero,
        end: const Duration(seconds: 5),
      );

      // THEN
      expect(transcription.selectedModel, 'whisper-base');
    });

    test('Given the quote transcription cubit, When its behavior is exercised, Then transcription workflow maps range intent and output into state', () async {
      // GIVEN
      final sharing = _Sharing();
      final transcription = _Transcription();
      final application = buildQuoteTranscriptionApplication(
        transcription: transcription,
        preferences: _Settings(),
        sharing: sharing,
      );
      final sut = QuoteTranscriptionCubit(application);
      addTearDown(sut.close);
      final book = Audiobook(
        id: 'book',
        title: 'Book',
        filePath: '/book.mp3',
        durationMs: 120000,
        addedAt: DateTime(2026),
      );

      sut.prepare(
        book: book,
        chapterTitle: 'Chapter',
        chapterStart: const Duration(seconds: 30),
        chapterDuration: const Duration(minutes: 1),
        anchor: const Duration(seconds: 45),
      );
      sut.applyPreset(const Duration(seconds: 15));
      // WHEN
      await sut.transcribe();

      // THEN
      expect(sut.state.status, QuoteTranscriptionStatus.complete);
      expect(sut.state.draft?.text, 'local quote');
      expect(sut.state.draft?.start, const Duration(minutes: 1));
      expect(transcription.selectedModel, 'whisper-base');

      final draft = sut.state.draft;
      expect(draft, isNotNull);
      if (draft != null) {
        await application.shareDraft(
          draft,
          'edited quote',
          subject: 'Quote from Book',
        );
      }
      expect(
        sharing.text,
        'edited quote\n\nChapter · 00:30–00:45\n— Book',
      );
    });
  });
}

class _Transcription implements TranscriptionRepository {
  String? selectedModel;
  var models = const <SpeechModel>[
    SpeechModel(slug: 'whisper-base', isDownloaded: true),
  ];
  @override
  Future<void> downloadModel(
    String slug, {
    TranscriptionDownloadProgress? onProgress,
  }) async {}

  @override
  Future<List<SpeechModel>> listModels() async => models;

  @override
  Future<bool> isModelDownloaded(String slug) async => true;

  @override
  Future<void> removeModel(String slug) async {}

  @override
  Future<Result<String>> transcribeRange({
    required Audiobook book,
    required Duration start,
    required Duration end,
    required String model,
  }) async {
    selectedModel = model;
    return const Result.success('local quote');
  }
}

class _Sharing implements QuoteShareRepository {
  String? text;

  @override
  Future<void> share({
    required String text,
    required String subject,
    ShareOrigin? origin,
  }) async {
    this.text = text;
  }
}

class _Settings implements TranscriptionPreferences {
  @override
  Future<String?> getSelectedModel() async => 'whisper-tiny';

  @override
  Future<void> setSelectedModel(String model) async {}
}
