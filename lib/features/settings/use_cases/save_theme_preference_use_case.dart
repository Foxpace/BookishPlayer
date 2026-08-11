import 'package:injectable/injectable.dart';
import '../models/theme_preference.dart';
import '../repos/settings_repository.dart';

@injectable
class SaveThemePreferenceUseCase {
  const SaveThemePreferenceUseCase(this._repository);
  final SettingsRepository _repository;
  Future<void> call(ThemePreference value) =>
      _repository.setThemePreference(value);
}
