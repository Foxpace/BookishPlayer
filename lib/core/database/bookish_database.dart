import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';
import 'package:meta/meta.dart';

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
    final database = await databaseFactoryIo.openDatabase(
      p.join(directory.path, 'bookish_player.db'),
    );
    return BookishDatabase._(database);
  }
}
