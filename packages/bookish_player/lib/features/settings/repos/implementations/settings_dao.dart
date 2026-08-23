import 'package:injectable/injectable.dart';
import 'package:sembast/sembast.dart';

import '../../../../core/database/bookish_database.dart';

@lazySingleton
class SettingsDao {
  SettingsDao(BookishDatabase database) : _database = database.database;

  final Database _database;
  final _settings = stringMapStoreFactory.store('settings');

  Future<Map<String, Object?>?> getAppearancePreferences() async {
    final value = await _settings.record('appearance').get(_database);
    return value == null ? null : Map<String, Object?>.from(value);
  }

  Future<void> setAppearancePreferences(Map<String, Object?> preferences) =>
      _settings.record('appearance').put(_database, preferences);

  Future<String?> getLibraryLayout() async {
    final value = await _settings.record('library').get(_database);
    return value?['layout'] as String?;
  }

  Future<void> setLibraryLayout(String layout) {
    return _settings.record('library').put(_database, {'layout': layout});
  }

  Future<String?> getSpeechModel() async {
    final value = await _settings.record('transcription').get(_database);
    return value?['model'] as String?;
  }

  Future<void> setSpeechModel(String model) {
    return _settings.record('transcription').put(_database, {'model': model});
  }

  Future<Map<String, dynamic>?> getPlaybackPreferences() async {
    final value = await _settings.record('playback').get(_database);
    return value == null ? null : Map<String, dynamic>.from(value);
  }

  Future<void> setPlaybackPreferences(Map<String, dynamic> preferences) =>
      _settings.record('playback').put(_database, preferences);
}
