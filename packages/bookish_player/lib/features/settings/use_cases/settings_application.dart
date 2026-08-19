import 'package:injectable/injectable.dart';

import '../../../core/foundation/result.dart';
import '../models/playback_preferences.dart';
import '../models/theme_preference.dart';
import '../repos/settings_repository.dart';

typedef LoadedSettings = ({
  ThemePreference theme,
  PlaybackPreferences playback,
});

@injectable
class SettingsApplication {
  const SettingsApplication(this._repository);

  final SettingsRepository _repository;

  Future<Result<LoadedSettings>> load() async {
    try {
      final (theme, playback) = await (
        _repository.getThemePreference(),
        _repository.getPlaybackPreferences(),
      ).wait;

      return Result.success((theme: theme, playback: playback));
    } catch (error) {
      return Result.failure(
        AppFailure.operationFailed('settings.load', error: error),
      );
    }
  }

  Future<Result<bool>> saveThemePreference(ThemePreference preference) =>
      _save(() => _repository.setThemePreference(preference));

  Future<Result<bool>> savePlaybackPreferences(
    PlaybackPreferences preferences,
  ) => _save(() => _repository.setPlaybackPreferences(preferences));

  Future<Result<bool>> _save(Future<void> Function() operation) async {
    try {
      await operation();
      return const Result.success(true);
    } catch (error) {
      return Result.failure(
        AppFailure.operationFailed('settings.save', error: error),
      );
    }
  }
}
