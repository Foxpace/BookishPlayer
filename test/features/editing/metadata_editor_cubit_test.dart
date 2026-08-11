import 'package:bookish_player/core/presentation/app_message.dart';
import 'package:bookish_player/features/editing/cubits/metadata_editor_cubit.dart';
import 'package:bookish_player/features/editing/cubits/editing_cubits.dart';
import 'package:bookish_player/features/library/models/library_models.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/fakes/fake_library_test_support.dart';
import '../../support/fixtures.dart';
import 'editing_test_builder.dart';

void main() {
  group('Audiobook metadata editor', () {
    late FakeLibraryBooks books;
    late FakeLibraryFiles files;
    late MetadataEditorCubit sut;

    setUp(() {
      books = FakeLibraryBooks([_editableBook()]);
      files = FakeLibraryFiles();
      sut = createMetadataEditorCubit(books, files);
    });

    tearDown(() => sut.close());

    test(
      'Given an audiobook metadata editor, When metadata and chapters are edited, Then validated values and cohesive ordering are persisted',
      () async {
        // GIVEN
        await sut.load('book-1');
        await sut.saveDetails((
          title: '  Revised  ',
          author: ' Author ',
          series: ' Saga ',
          seriesPosition: '2.5',
          narrator: ' Narrator ',
          year: '3026',
          folder: ' ',
        ));
        await sut.reorderTrack(0, 1);
        await sut.addChapter(' Later ', const Duration(seconds: 20));
        final bookWithChapter = sut.state.book;
        if (bookWithChapter == null) {
          fail('The editor must retain the loaded book.');
        }
        // WHEN
        await sut.deleteChapter(bookWithChapter.chapters.first);

        // THEN
        expect(sut.state.status, MetadataEditorStatus.saved);
        final editedBook = sut.state.book;
        if (editedBook == null) {
          fail('The editor must expose the saved book.');
        }
        expect(editedBook.title, 'Revised');
        expect(editedBook.seriesPosition, 2.5);
        expect(editedBook.year, isNull);
        expect(editedBook.folder, 'Imported');
        expect(editedBook.tracks.map((track) => track.order), [0, 1]);
        expect(editedBook.chapters.single.title, 'Later');
      },
    );

    test(
      'Given an audiobook metadata editor, When a cover is replaced, Then the new cover is saved and the old imported cover is deleted',
      () async {
        // GIVEN
        files.pickedCover = '/covers/new.jpg';
        await sut.load('book-1');

        // WHEN
        await sut.changeCover();

        // THEN
        expect(sut.state.book?.artworkPath, '/covers/new.jpg');
        expect(files.deletedPaths, ['/covers/old.jpg']);
      },
    );

    test(
      'Given an audiobook metadata editor, When loading or saving fails, Then typed revisioned failures are emitted and retry remains available',
      () async {
        // GIVEN
        books.getBookFailure = Exception('load');
        // WHEN
        await sut.load('book-1');
        // THEN
        expect(sut.state.message, AppMessage.metadataEditorLoadFailed);
        expect(sut.state.effectRevision, 1);

        books.getBookFailure = null;
        await sut.retryLoad();
        books.saveBookFailure = Exception('save');
        await sut.saveDetails((
          title: 'Valid',
          author: '',
          series: '',
          seriesPosition: '',
          narrator: '',
          year: '2026',
          folder: 'Shelf',
        ));

        expect(sut.state.message, AppMessage.metadataSaveFailed);
        expect(sut.state.effectRevision, 2);
      },
    );
  });
}

Audiobook _editableBook() => audiobookFixture().copyWith(
  artworkPath: '/covers/old.jpg',
  tracks: const [
    AudioTrack(
      id: 'one',
      title: 'One',
      filePath: '/one.mp3',
      durationMs: 1000,
      order: 0,
    ),
    AudioTrack(
      id: 'two',
      title: 'Two',
      filePath: '/two.mp3',
      durationMs: 1000,
      order: 1,
    ),
  ],
  chapters: const [AudioChapter(title: 'Opening', startMs: 0)],
);
