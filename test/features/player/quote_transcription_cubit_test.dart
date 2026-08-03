import 'package:bookish_player/features/library/domain/audiobook.dart';
import 'package:bookish_player/features/player/domain/quote_share_repository.dart';
import 'package:bookish_player/features/player/presentation/quote_transcription_cubit.dart';
import 'package:bookish_player/features/player/presentation/quote_transcription_state.dart';
import 'package:bookish_player/features/settings/domain/settings_repository.dart';
import 'package:bookish_player/features/settings/domain/theme_preference.dart';
import 'package:bookish_player/features/transcription/domain/transcription_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'transcription workflow maps range intent and output into state',
    () async {
      final sharing = _Sharing();
      final cubit = QuoteTranscriptionCubit(
        _Transcription(),
        _Settings(),
        sharing,
      );
      addTearDown(cubit.close);
      final book = Audiobook(
        id: 'book',
        title: 'Book',
        filePath: '/book.mp3',
        durationMs: 120000,
        addedAt: DateTime(2026),
      );

      cubit.prepare(
        book: book,
        chapterTitle: 'Chapter',
        chapterStart: const Duration(seconds: 30),
        chapterDuration: const Duration(minutes: 1),
        anchor: const Duration(seconds: 45),
      );
      cubit.applyPreset(const Duration(seconds: 15));
      await cubit.transcribe();

      expect(cubit.state.status, QuoteTranscriptionStatus.complete);
      expect(cubit.state.draft?.text, 'local quote');
      expect(cubit.state.draft?.start, const Duration(minutes: 1));

      await cubit.shareDraft('edited quote');
      expect(sharing.text, contains('edited quote'));
      expect(sharing.text, contains('Chapter'));
    },
  );
}

class _Transcription implements TranscriptionRepository {
  @override
  Future<String> transcribeRange({
    required Audiobook book,
    required Duration start,
    required Duration end,
    required String model,
  }) async => 'local quote';

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
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

class _Settings implements SettingsRepository {
  @override
  Future<String?> getSpeechModel() async => 'whisper-tiny';

  @override
  Future<ThemePreference> getThemePreference() async => ThemePreference.system;

  @override
  Future<String?> getLibraryLayout() async => null;

  @override
  Future<void> setLibraryLayout(String layout) async {}

  @override
  Future<void> setSpeechModel(String model) async {}

  @override
  Future<void> setThemePreference(ThemePreference preference) async {}
}
