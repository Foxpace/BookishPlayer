import 'package:bookish_player/core/database/bookish_database.dart';
import 'package:bookish_player/core/database/bookish_database_migrations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sembast/sembast_memory.dart';

void main() {
  final settings = stringMapStoreFactory.store('settings');

  group('Version-one database with an invalid stored theme', () {
    test(
      'Given a version-one database with an invalid stored theme, When the database is opened by the current application, Then it is migrated transactionally to a safe theme',
      () async {
        // GIVEN
        final factory = newDatabaseFactoryMemory();
        final legacy = await factory.openDatabase(
          'bookish-migration.db',
          version: 1,
          onVersionChanged: (database, _, _) => settings
              .record('appearance')
              .put(database, {'theme': 'removed-theme', 'retained': true}),
        );
        await legacy.close();

        final migrated = await BookishDatabase.openWithFactory(
          factory,
          'bookish-migration.db',
        );
        // WHEN
        final appearance = await settings
            .record('appearance')
            .get(migrated.database);

        // THEN
        expect(
          migrated.database.version,
          BookishDatabaseMigrations.currentVersion,
        );
        expect(appearance, {'theme': 'system', 'retained': true});
        await migrated.database.close();
      },
    );
  });

  group('Existing supported appearance preference', () {
    test(
      'Given an existing supported appearance preference, When the database schema is upgraded, Then the preference is preserved',
      () async {
        // GIVEN
        final factory = newDatabaseFactoryMemory();
        final legacy = await factory.openDatabase(
          'bookish-preserved.db',
          version: 1,
          onVersionChanged: (database, _, _) =>
              settings.record('appearance').put(database, {'theme': 'dark'}),
        );
        await legacy.close();

        // WHEN
        final migrated = await BookishDatabase.openWithFactory(
          factory,
          'bookish-preserved.db',
        );

        // THEN
        expect(await settings.record('appearance').get(migrated.database), {
          'theme': 'dark',
        });
        await migrated.database.close();
      },
    );
  });
}
