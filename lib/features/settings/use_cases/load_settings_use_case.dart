part of 'settings_use_cases.dart';

@injectable
class LoadSettingsUseCase {
  const LoadSettingsUseCase(this._repository);
  final SettingsRepository _repository;

  Future<LoadedSettings> call() async {
    final (theme, playback) = await (
      _repository.getThemePreference(),
      _repository.getPlaybackPreferences(),
    ).wait;

    return (theme: theme, playback: playback);
  }
}
