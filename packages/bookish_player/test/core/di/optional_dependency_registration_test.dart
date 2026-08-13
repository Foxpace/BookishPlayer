import 'package:bookish_player/app/dependency_registration.dart';
import 'package:bookish_player/core/di/injection.dart';
import 'package:bookish_player/features/transcription/cubits/quote_transcription_cubit.dart';
import 'package:bookish_player/features/transcription/cubits/speech_models_cubit.dart';
import 'package:bookish_player/features/transcription/repos/transcription_preferences.dart';
import 'package:bookish_player/features/transcription/use_cases/transcription_use_case_bundle.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

void main() {
  group('Optional transcription dependency registrations', () {
    test(
      'Given the store environment, When dependencies are configured, Then transcription factories are absent',
      () async {
        // GIVEN
        final container = GetIt.asNewInstance();
        addTearDown(() => container.reset(dispose: true));

        // WHEN
        await configureDependencies(
          container: container,
          environments: const {'test'},
        );

        // THEN
        expect(container.isRegistered<TranscriptionPreferences>(), isFalse);
        expect(container.isRegistered<SpeechModelUseCases>(), isFalse);
        expect(container.isRegistered<QuoteTranscriptionUseCases>(), isFalse);
        expect(container.isRegistered<SpeechModelsCubit>(), isFalse);
        expect(container.isRegistered<QuoteTranscriptionCubit>(), isFalse);
      },
    );

    test(
      'Given the internal environment, When dependencies are configured, Then transcription factories are present',
      () async {
        // GIVEN
        final container = GetIt.asNewInstance();
        addTearDown(() => container.reset(dispose: true));

        // WHEN
        await configureDependencies(
          container: container,
          environments: const {'test', internalEnvironment},
        );

        // THEN
        expect(container.isRegistered<TranscriptionPreferences>(), isTrue);
        expect(container.isRegistered<SpeechModelUseCases>(), isTrue);
        expect(container.isRegistered<QuoteTranscriptionUseCases>(), isTrue);
        expect(container.isRegistered<SpeechModelsCubit>(), isTrue);
        expect(container.isRegistered<QuoteTranscriptionCubit>(), isTrue);
      },
    );
  });
}
