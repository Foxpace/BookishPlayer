import 'package:bookish_cactus_transcription/bookish_cactus_transcription.dart';
import 'package:bookish_player/app/app_capabilities.dart';
import 'package:bookish_player/app/run_bookish.dart';
import 'package:bookish_player/core/di/injection.dart';
import 'package:bookish_player/features/transcription/repos/transcription_repository.dart';

import 'repos/bookish_cactus_transcription_repository.dart';

Future<void> main() => runBookish(
  capabilities: const AppCapabilities(transcriptionEnabled: true),
  registerOptionalDependencies: _registerCactusTranscription,
);

Future<void> _registerCactusTranscription() async {
  const audio = CactusPcmStreamFactory();
  getIt.registerLazySingleton<TranscriptionRepository>(
    () => BookishCactusTranscriptionRepository(
      CactusTranscriptionRepository(audio),
    ),
  );
}
