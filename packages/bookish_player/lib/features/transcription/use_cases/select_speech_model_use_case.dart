import 'package:injectable/injectable.dart';

import '../repos/transcription_preferences.dart';

@Environment('internal')
@injectable
class SelectSpeechModelUseCase {
  const SelectSpeechModelUseCase(this._preferences);

  final TranscriptionPreferences _preferences;

  Future<void> call(String slug) => _preferences.setSelectedModel(slug);
}
