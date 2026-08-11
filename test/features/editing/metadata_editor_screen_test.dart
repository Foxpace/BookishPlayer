import 'package:bookish_player/features/editing/cubits/metadata_editor_cubit.dart';
import 'package:bookish_player/features/editing/cubits/editing_cubits.dart';
import 'package:bookish_player/features/editing/ui/metadata_editor_screen.dart';
import 'package:bookish_player/features/editing/ui/widgets/chapter_editor_dialog.dart';
import 'package:bookish_player/features/library/models/library_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/fakes/fake_library_test_support.dart';
import '../../support/fixtures.dart';
import '../../support/pump_bookish_app.dart';
import 'editing_test_builder.dart';
import 'metadata_editor_robot.dart';

void main() {
  group('Editable audiobook', () {
    late FakeLibraryBooks books;
    late FakeLibraryFiles files;
    late MetadataEditorCubit cubit;

    setUp(() async {
      books = FakeLibraryBooks([_book()]);
      files = FakeLibraryFiles()..pickedCover = '/covers/replacement.jpg';
      cubit = createMetadataEditorCubit(books, files);
      await cubit.load('book-1');
    });

    tearDown(() => cubit.close());

    testWidgets(
      'Given an editable audiobook, When details, artwork, and chapters are edited, Then named intents persist each cohesive edit',
      (tester) async {
        final robot = MetadataEditorRobot(tester);

        // WHEN
        await tester.pumpBookishApp(
          display: const (
            themeMode: ThemeMode.light,
            locale: Locale('en'),
            viewport: Size(500, 1100),
            textScale: 1,
          ),
          child: _MetadataHarness(cubit: cubit),
        );

        // THEN
        robot.expectLoaded(
          heading: 'Edit audiobook',
          trackOrderLabel: 'Track order',
          trackTitles: const ['Track One', 'Track Two'],
        );

        await robot.reviseDetails(
          title: 'Revised title',
          author: 'Revised author',
          saveLabel: 'Save details',
        );

        expect(books.books.single.title, 'Revised title');
        expect(books.books.single.author, 'Revised author');

        await robot.changeCover('Change cover');
        expect(books.books.single.artworkPath, '/covers/replacement.jpg');
        expect(files.deletedPaths, ['/covers/original.jpg']);

        await robot.addChapter(
          title: 'Finale',
          positionSeconds: '42',
          addTooltip: 'Add chapter',
          confirmLabel: 'Add',
        );

        robot.expectChapter('Finale');
        expect(books.books.single.chapters.last.startMs, 42_000);

        await robot.deleteFirstChapter(Icons.delete_outline_rounded);
        expect(books.books.single.chapters, hasLength(1));
      },
    );
  });

  group('Audiobook that temporarily fails to load', () {
    testWidgets(
      'Given an audiobook that temporarily fails to load, When retry is requested, Then the failure view recovers to the editor form',
      (tester) async {
        final robot = MetadataEditorRobot(tester);

        // GIVEN
        final books = FakeLibraryBooks([_book()])
          ..getBookFailure = Exception('database busy');
        final cubit = createMetadataEditorCubit(books, FakeLibraryFiles());
        addTearDown(cubit.close);
        await cubit.load('book-1');

        // WHEN
        await tester.pumpBookishApp(child: _MetadataHarness(cubit: cubit));
        // THEN
        robot.expectLoadFailure('The audiobook editor could not be opened.');

        books.getBookFailure = null;
        await robot.retry('Try again');

        robot.expectRecovered(const ['Change cover', 'A Test Audiobook']);
      },
    );
  });
}

class _MetadataHarness extends StatelessWidget {
  const _MetadataHarness({required this.cubit});

  final MetadataEditorCubit cubit;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MetadataEditorCubit, MetadataEditorState>(
      bloc: cubit,
      builder: (context, state) => MetadataEditorScreen(
        state: state,
        intents: (
          retry: cubit.retryLoad,
          changeCover: cubit.changeCover,
          saveDetails: cubit.saveDetails,
          reorderTrack: cubit.reorderTrack,
          addChapter: () => _addChapter(context),
          deleteChapter: cubit.deleteChapter,
        ),
      ),
    );
  }

  Future<void> _addChapter(BuildContext context) async {
    final chapter = await showChapterEditorDialog(context);
    if (chapter != null && context.mounted) {
      await cubit.addChapter(chapter.title, chapter.position);
    }
  }
}

Audiobook _book() => audiobookFixture().copyWith(
  artworkPath: '/covers/original.jpg',
  tracks: const [
    AudioTrack(
      id: 'track-1',
      title: 'Track One',
      filePath: '/audio/one.mp3',
      durationMs: 30_000,
      order: 0,
    ),
    AudioTrack(
      id: 'track-2',
      title: 'Track Two',
      filePath: '/audio/two.mp3',
      durationMs: 30_000,
      order: 1,
    ),
  ],
  chapters: const [AudioChapter(title: 'Opening', startMs: 0)],
);
