import 'package:bookish_player/core/database/bookish_database.dart';
import 'package:bookish_player/features/library/repos/implementations/audiobook_dao.dart';
import 'package:bookish_player/features/library/models/library_models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sembast/sembast_memory.dart';

void main() {
  group('Audiobook dao completion', () {
    test(
      'Given the audiobook dao completion, When its behavior is exercised, Then completed books can be read back from storage',
      () async {
        // GIVEN
        final database = await databaseFactoryMemory.openDatabase(
          'completion.db',
        );
        addTearDown(database.close);
        final sut = AudiobookDao(BookishDatabase.forTesting(database));
        final completedAt = DateTime.utc(2026, 8, 8, 12, 30);
        final book = Audiobook(
          id: 'completed-book',
          title: 'Completed Book',
          filePath: '/audio/completed.m4b',
          durationMs: 120000,
          addedAt: DateTime.utc(2026, 8),
          positionMs: 120000,
          completedAt: completedAt,
        );

        await sut.putBook(book);

        // WHEN
        final stored = await sut.getBook(book.id);
        // THEN
        expect(stored?.completedAt, completedAt);
        expect(stored?.isFinished, isTrue);
      },
    );
  });
}
