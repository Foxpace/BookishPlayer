import 'package:bookish_player/features/player/repos/quote_share_repository.dart';
import 'package:bookish_player/features/transcription/repos/transcription_preferences.dart';
import 'package:bookish_player/features/transcription/repos/transcription_repository.dart';
import 'package:bookish_player/features/transcription/use_cases/quote_transcription_application.dart';
import 'package:bookish_player/features/transcription/use_cases/speech_model_application.dart';

QuoteTranscriptionApplication buildQuoteTranscriptionApplication({
  required TranscriptionRepository transcription,
  required TranscriptionPreferences preferences,
  required QuoteShareRepository sharing,
}) => QuoteTranscriptionApplication(transcription, preferences, sharing);

SpeechModelApplication buildSpeechModelApplication({
  required TranscriptionRepository transcription,
  required TranscriptionPreferences preferences,
}) => SpeechModelApplication(transcription, preferences);
