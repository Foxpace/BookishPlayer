import 'package:bookish_player/core/database/bookish_database.dart';
import 'package:bookish_player/features/library/data/audiobook_dao.dart';
import 'package:bookish_player/features/library/domain/audiobook.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sembast/sembast_memory.dart';

void main() {
  test('completed books can be read back from storage', () async {
    final database = await databaseFactoryMemory.openDatabase('completion.db');
    addTearDown(database.close);
    final books = AudiobookDao(BookishDatabase.forTesting(database));
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

    await books.putBook(book);

    final stored = await books.getBook(book.id);
    expect(stored?.completedAt, completedAt);
    expect(stored?.isFinished, isTrue);
  });
}
