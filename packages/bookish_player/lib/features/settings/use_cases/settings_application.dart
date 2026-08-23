import 'package:injectable/injectable.dart';

import '../../../core/foundation/result.dart';
import '../models/appearance_preferences.dart';
import '../models/playback_preferences.dart';
import '../repos/settings_repository.dart';

typedef LoadedSettings = ({
  AppearancePreferences appearance,
  PlaybackPreferences playback,
});

@injectable
class SettingsApplication {
  const SettingsApplication(this._repository);

  final SettingsRepository _repository;

  Future<Result<LoadedSettings>> load() async {
    try {
      return await _load();
    } catch (error) {
      return Result.failure(
        AppFailure.operationFailed('settings.load', error: error),
      );
    }
  }

  Future<Result<LoadedSettings>> _load() async {
    final (appearance, playback) = await (
      _repository.getAppearancePreferences(),
      _repository.getPlaybackPreferences(),
    ).wait;

    return Result.success((appearance: appearance, playback: playback));
  }

  Future<Result<bool>> saveAppearancePreferences(
    AppearancePreferences preferences,
  ) => _save(() => _repository.setAppearancePreferences(preferences));

  Future<Result<bool>> savePlaybackPreferences(
    PlaybackPreferences preferences,
  ) => _save(() => _repository.setPlaybackPreferences(preferences));

  Future<Result<bool>> _save(Future<void> Function() operation) async {
    try {
      return await _runSave(operation);
    } catch (error) {
      return Result.failure(
        AppFailure.operationFailed('settings.save', error: error),
      );
    }
  }

  Future<Result<bool>> _runSave(Future<void> Function() operation) async {
    await operation();
    return const Result.success(true);
  }
}
