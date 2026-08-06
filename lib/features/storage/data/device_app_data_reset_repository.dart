import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';

import '../../../core/database/bookish_database.dart';
import '../domain/app_data_reset_repository.dart';

@LazySingleton(as: AppDataResetRepository)
class DeviceAppDataResetRepository implements AppDataResetRepository {
  DeviceAppDataResetRepository(BookishDatabase database)
    : _database = database.database;

  final Database _database;

  @override
  Future<void> clearAll() async {
    await clearAppData(
      database: _database,
      supportDirectory: await getApplicationSupportDirectory(),
      documentsDirectory: await getApplicationDocumentsDirectory(),
      temporaryDirectory: await getTemporaryDirectory(),
    );
    try {
      await FilePicker.platform.clearTemporaryFiles();
    } catch (_) {
      // The platform picker cache is best-effort and may not exist.
    }
  }
}

Future<void> clearAppData({
  required Database database,
  required Directory supportDirectory,
  required Directory documentsDirectory,
  required Directory temporaryDirectory,
}) async {
  await database.transaction((transaction) async {
    for (final name in BookishDatabase.appStoreNames) {
      await stringMapStoreFactory.store(name).delete(transaction);
    }
  });

  for (final name in const ['audiobooks', 'covers']) {
    await _deleteEntity(Directory(p.join(supportDirectory.path, name)));
  }
  if (documentsDirectory.existsSync()) {
    await for (final entity in documentsDirectory.list(followLinks: false)) {
      await _deleteEntity(entity);
    }
  }
  if (temporaryDirectory.existsSync()) {
    await for (final entity in temporaryDirectory.list(followLinks: false)) {
      if (p.basename(entity.path).startsWith('bookish_')) {
        await _deleteEntity(entity);
      }
    }
  }
}

Future<void> _deleteEntity(FileSystemEntity entity) async {
  if (entity.existsSync()) {
    await entity.delete(recursive: true);
  }
}
