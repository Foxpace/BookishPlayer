import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';
import 'package:meta/meta.dart';

import 'bookish_database_migrations.dart';

class BookishDatabase {
  BookishDatabase._(this.database);

  @visibleForTesting
  BookishDatabase.forTesting(this.database);

  final Database database;

  static const appStoreNames = <String>{
    'books',
    'book_metadata',
    'notes',
    'listening_sessions',
    'settings',
  };

  static Future<BookishDatabase> open() async {
    final directory = await getApplicationSupportDirectory();
    return openWithFactory(
      databaseFactoryIo,
      p.join(directory.path, 'bookish_player.db'),
    );
  }

  @visibleForTesting
  static Future<BookishDatabase> openWithFactory(
    DatabaseFactory factory,
    String path,
  ) async {
    final database = await factory.openDatabase(
      path,
      version: BookishDatabaseMigrations.currentVersion,
      onVersionChanged: BookishDatabaseMigrations.migrate,
    );
    return BookishDatabase._(database);
  }
}
