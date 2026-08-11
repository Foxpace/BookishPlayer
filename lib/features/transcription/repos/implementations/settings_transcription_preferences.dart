import 'package:injectable/injectable.dart';

import '../../../settings/repos/settings_repository.dart';
import '../transcription_preferences.dart';

@LazySingleton(as: TranscriptionPreferences)
class SettingsTranscriptionPreferences implements TranscriptionPreferences {
  SettingsTranscriptionPreferences(this._settings);

  final SettingsRepository _settings;

  @override
  Future<String?> getSelectedModel() => _settings.getSpeechModel();

  @override
  Future<void> setSelectedModel(String model) =>
      _settings.setSpeechModel(model);
}
