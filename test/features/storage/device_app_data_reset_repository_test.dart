import 'dart:io';

import 'package:bookish_player/core/database/bookish_database.dart';
import 'package:bookish_player/features/storage/data/device_app_data_reset_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:sembast/sembast_memory.dart';

void main() {
  test('clearAppData removes every app store and managed file', () async {
    final root = await Directory.systemTemp.createTemp('bookish_reset_test_');
    addTearDown(() => root.delete(recursive: true));
    final support = Directory(p.join(root.path, 'support'))..createSync();
    final documents = Directory(p.join(root.path, 'documents'))..createSync();
    final temporary = Directory(p.join(root.path, 'temporary'))..createSync();
    final database = await databaseFactoryMemory.openDatabase('reset.db');
    addTearDown(database.close);

    for (final name in BookishDatabase.appStoreNames) {
      await stringMapStoreFactory.store(name).record('value').put(database, {
        'present': true,
      });
    }
    final audio = File(p.join(support.path, 'audiobooks', 'book.m4b'));
    final cover = File(p.join(support.path, 'covers', 'cover.jpg'));
    final model = File(p.join(documents.path, 'models', 'tiny', 'model.bin'));
    final transfer = File(p.join(documents.path, 'transfer.m4b'));
    final clip = File(p.join(temporary.path, 'bookish_quote_1.wav'));
    final unrelatedTemporary = File(p.join(temporary.path, 'other.tmp'));
    for (final file in [
      audio,
      cover,
      model,
      transfer,
      clip,
      unrelatedTemporary,
    ]) {
      await file.create(recursive: true);
      await file.writeAsString('data');
    }

    await clearAppData(
      database: database,
      supportDirectory: support,
      documentsDirectory: documents,
      temporaryDirectory: temporary,
    );

    for (final name in BookishDatabase.appStoreNames) {
      expect(await stringMapStoreFactory.store(name).count(database), 0);
    }
    expect(audio.existsSync(), isFalse);
    expect(cover.existsSync(), isFalse);
    expect(model.existsSync(), isFalse);
    expect(transfer.existsSync(), isFalse);
    expect(clip.existsSync(), isFalse);
    expect(unrelatedTemporary.existsSync(), isTrue);
  });
}
