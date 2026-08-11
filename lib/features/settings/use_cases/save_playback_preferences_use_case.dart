import 'package:injectable/injectable.dart';
import '../models/playback_preferences.dart';
import '../repos/settings_repository.dart';

@injectable
class SavePlaybackPreferencesUseCase {
  const SavePlaybackPreferencesUseCase(this._repository);
  final SettingsRepository _repository;
  Future<void> call(PlaybackPreferences value) =>
      _repository.setPlaybackPreferences(value);
}
