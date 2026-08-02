import 'package:injectable/injectable.dart';
import 'package:sembast/sembast.dart';

import '../../../core/database/bookish_database.dart';

@lazySingleton
class SettingsDao {
  SettingsDao(BookishDatabase database) : _database = database.database;

  final Database _database;
  final _settings = stringMapStoreFactory.store('settings');

  Future<String?> getThemePreference() async {
    final value = await _settings.record('appearance').get(_database);
    return value?['theme'] as String?;
  }

  Future<void> setThemePreference(String preference) {
    return _settings.record('appearance').put(_database, {'theme': preference});
  }
}
