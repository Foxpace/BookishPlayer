import 'package:bookish_player/features/player/repos/player_repositories.dart';
import 'package:bookish_player/features/transcription/repos/transcription_preferences.dart';
import 'package:bookish_player/features/transcription/repos/transcription_repositories.dart';
import 'package:bookish_player/features/transcription/use_cases/transcription_use_case_bundle.dart';

QuoteTranscriptionUseCases buildQuoteTranscriptionUseCases({
  required TranscriptionRepository transcription,
  required TranscriptionPreferences preferences,
  required QuoteShareRepository sharing,
}) => QuoteTranscriptionUseCases(
  TranscribeQuoteUseCase(transcription, preferences),
  ShareTranscriptionDraftUseCase(sharing),
);

SpeechModelUseCases buildSpeechModelUseCases({
  required TranscriptionRepository transcription,
  required TranscriptionPreferences preferences,
}) => SpeechModelUseCases(
  loadCachedModels: LoadCachedSpeechModelsUseCase(transcription),
  refreshModels: RefreshSpeechModelsUseCase(transcription),
  selectedModel: ReadSelectedSpeechModelUseCase(preferences),
  selectModel: SelectSpeechModelUseCase(preferences),
  downloadModel: DownloadSpeechModelUseCase(transcription),
);
