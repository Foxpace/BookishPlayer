import 'package:bookish_player/features/settings/repos/settings_repository.dart';
import 'package:bookish_player/features/settings/use_cases/settings_use_case_bundle.dart';

SettingsUseCases buildSettingsUseCases(SettingsRepository repository) =>
    SettingsUseCases(
      LoadSettingsUseCase(repository),
      SavePlaybackPreferencesUseCase(repository),
      SaveThemePreferenceUseCase(repository),
    );
