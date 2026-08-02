import 'package:injectable/injectable.dart';

import '../domain/settings_repository.dart';
import '../domain/theme_preference.dart';
import 'settings_dao.dart';

@LazySingleton(as: SettingsRepository)
class SembastSettingsRepository implements SettingsRepository {
  SembastSettingsRepository(this._dao);

  final SettingsDao _dao;

  @override
  Future<ThemePreference> getThemePreference() async {
    return ThemePreference.fromStorage(await _dao.getThemePreference());
  }

  @override
  Future<void> setThemePreference(ThemePreference preference) {
    return _dao.setThemePreference(preference.name);
  }
}
