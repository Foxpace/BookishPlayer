import 'package:injectable/injectable.dart';
import '../repos/transcription_preferences.dart';

@injectable
class ReadSelectedSpeechModelUseCase {
  const ReadSelectedSpeechModelUseCase(this._preferences);

  final TranscriptionPreferences _preferences;

  Future<String?> call() => _preferences.getSelectedModel();
}
