import 'package:bookish_player/features/settings/repos/settings_repository.dart';
import 'package:bookish_player/features/settings/use_cases/settings_application.dart';

SettingsApplication buildSettingsApplication(SettingsRepository repository) =>
    SettingsApplication(repository);
