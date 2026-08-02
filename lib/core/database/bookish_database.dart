import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast_io.dart';

class BookishDatabase {
  BookishDatabase._(this.database);

  final Database database;

  static Future<BookishDatabase> open() async {
    final directory = await getApplicationSupportDirectory();
    final database = await databaseFactoryIo.openDatabase(
      p.join(directory.path, 'bookish_player.db'),
    );
    return BookishDatabase._(database);
  }
}
