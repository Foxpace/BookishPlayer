import 'package:sembast/sembast.dart';

class BookishDatabaseMigrations {
  const BookishDatabaseMigrations._();

  static const currentVersion = 3;
  static final _settings = stringMapStoreFactory.store('settings');
  static final _notes = stringMapStoreFactory.store('notes');
  static const _supportedThemes = {'system', 'light', 'dark'};

  static Future<void> migrate(
    Database database,
    int oldVersion,
    int newVersion,
  ) async {
    if (oldVersion < 2 && newVersion >= 2) {
      await _normalizeAppearance(database);
    }
    if (oldVersion < 3 && newVersion >= 3) {
      await _removeBookmarks(database);
    }
  }

  static Future<void> _removeBookmarks(Database database) async {
    await _notes.delete(
      database,
      finder: Finder(filter: Filter.equals('kind', 'bookmark')),
    );
  }

  static Future<void> _normalizeAppearance(Database database) async {
    final record = _settings.record('appearance');
    final appearance = await record.get(database);
    final theme = appearance?['theme'];
    if (theme is String && _supportedThemes.contains(theme)) {
      return;
    }
    await record.put(database, {...?appearance, 'theme': 'system'});
  }
}
