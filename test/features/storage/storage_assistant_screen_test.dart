import 'package:bookish_player/core/navigation/app_navigation.dart';
import 'package:bookish_player/features/library/models/library_models.dart';
import 'package:bookish_player/features/library/repos/audiobook_catalog_repository.dart';
import 'package:bookish_player/features/library/models/audiobook_removal_mode.dart';
import 'package:bookish_player/features/storage/use_cases/storage_assistant_workflow.dart';
import 'package:bookish_player/features/storage/repos/app_data_reset_repository.dart';
import 'package:bookish_player/features/storage/repos/library_storage_repository.dart';
import 'package:bookish_player/features/storage/models/storage_report.dart';
import 'package:bookish_player/features/storage/cubits/storage_assistant_cubit.dart';
import 'package:bookish_player/features/transcription/repos/transcription_repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import '../../support/fixtures.dart';
import '../../support/pump_bookish_app.dart';
import 'storage_assistant_robot.dart';
import 'storage_assistant_test_harness.dart';
import 'storage_test_builder.dart';

void main() {
  group('Inspected local library', () {
    late _Books books;
    late _Storage storage;
    late _Reset reset;
    late _Transcription transcription;
    late StorageAssistantCubit cubit;
    var playbackResetCalls = 0;
    var settingsReloadCalls = 0;

    setUp(() async {
      books = _Books([
        audiobookFixture().copyWith(folder: 'History'),
        audiobookFixture(
          id: 'book-2',
        ).copyWith(title: 'A Duplicate Audiobook', folder: 'Archive'),
      ]);
      storage = _Storage();
      reset = _Reset();
      transcription = _Transcription();
      cubit = createStorageCubit(
        StorageAssistantWorkflow(books, storage, reset, transcription),
        resetPlayback: () async {
          playbackResetCalls++;
        },
        reloadSettings: () async {
          settingsReloadCalls++;
        },
      );
      await cubit.load();
    });

    tearDown(() => cubit.close());

    testWidgets(
      'Given an inspected local library, When the storage report is rendered and cleanup is confirmed, Then details render and cleanup intents reach the Cubit',
      (tester) async {
        final robot = StorageAssistantRobot(tester);

        // WHEN
        await tester.pumpBookishApp(
          child: StorageAssistantTestHarness(cubit: cubit),
        );

        // THEN
        robot.expectReport(const [
          '2.0 GB managed',
          '2.0 MB can be reclaimed safely',
          'Missing files · 1',
          'Possible duplicates · 1',
          'History · Archive',
        ]);

        await robot.cleanUnusedFiles(
          cleanLabel: 'Clean',
          dialogTitle: 'Remove unused files?',
          confirmLabel: 'Remove unused files',
        );

        expect(storage.deletedPaths, ['/orphan.tmp']);
        robot.expectUnusedFilesRemoved('Unused files removed.');

        await robot.removeMissingEntry(
          tooltip: 'Remove missing library entry',
          confirmationText: 'will be removed from the library',
          confirmLabel: 'Remove entry',
        );

        expect(books.deletedIds, ['book-1']);
      },
    );

    testWidgets(
      'Given an inspected local library, When playback cannot be reset before erasing data, Then destructive clearing stops and a diagnostic is shown',
      (tester) async {
        final robot = StorageAssistantRobot(tester);

        // GIVEN
        final failingCubit = createStorageCubit(
          StorageAssistantWorkflow(books, storage, reset, transcription),
          resetPlayback: () => throw StateError('audio busy'),
        );
        addTearDown(failingCubit.close);
        await failingCubit.load();
        await tester.pumpBookishApp(
          child: StorageAssistantTestHarness(cubit: failingCubit),
        );

        // WHEN
        await robot.eraseEverything(
          eraseLabel: 'Erase',
          confirmLabel: 'Erase everything',
        );

        // THEN
        expect(reset.clearCalls, 0);
        robot.expectEraseFailure('Bookish could not remove all app data.');
      },
    );

    testWidgets(
      'Given an inspected local library, When erasing all data succeeds, Then settings reload and navigation returns to the library',
      (tester) async {
        final robot = StorageAssistantRobot(tester);

        // GIVEN
        final router = GoRouter(
          initialLocation: '/storage',
          routes: [
            GoRoute(
              path: '/',
              name: AppRoutes.library,
              builder: (_, _) =>
                  const Scaffold(body: Text('Library destination')),
            ),
            GoRoute(
              path: '/storage',
              builder: (_, _) => StorageAssistantTestHarness(
                cubit: cubit,
                navigateAfterReset: true,
              ),
            ),
          ],
        );
        addTearDown(router.dispose);

        await tester.pumpBookishApp(
          router: router,
          blocProviders: [
            (child) => BlocProvider.value(value: cubit, child: child),
          ],
        );
        // WHEN
        await robot.eraseEverything(
          eraseLabel: 'Erase',
          confirmLabel: 'Erase everything',
        );

        // THEN
        expect(playbackResetCalls, 1);
        expect(transcription.resetCalls, 1);
        expect(reset.clearCalls, 1);
        expect(settingsReloadCalls, 1);
        robot.expectLibraryDestination('Library destination');
      },
    );
  });
}

class _Books implements AudiobookCatalogRepository {
  _Books(this.books);

  List<Audiobook> books;
  final deletedIds = <String>[];

  @override
  Future<List<Audiobook>> getBooks() async => books;

  @override
  Future<Audiobook?> getBook(String id) async {
    for (final book in books) {
      if (book.id == id) {
        return book;
      }
    }
    return null;
  }

  @override
  Future<void> saveBook(Audiobook book) async => books.add(book);

  @override
  Future<void> updateProgress(String id, Duration position) async {}

  @override
  Future<void> updatePlaybackSpeed(String id, double speed) async {}

  @override
  Future<void> deleteBook(
    String id, {
    AudiobookRemovalMode mode = AudiobookRemovalMode.keepUserData,
  }) async {
    deletedIds.add(id);
    books = books.where((book) => book.id != id).toList();
  }
}

class _Storage implements LibraryStorageRepository {
  final deletedPaths = <String>[];

  @override
  Future<StorageReport> inspect(List<Audiobook> books) async =>
      const StorageReport(
        managedBytes: 2 * 1024 * 1024 * 1024,
        reclaimableBytes: 2 * 1024 * 1024,
        missingBookIds: ['book-1'],
        duplicateBookIds: [
          ['book-1', 'book-2'],
        ],
        orphanPaths: ['/orphan.tmp'],
      );

  @override
  Future<void> deleteOrphans(List<String> paths) async {
    deletedPaths.addAll(paths);
  }
}

class _Reset implements AppDataResetRepository {
  var clearCalls = 0;

  @override
  Future<void> clearAll() async {
    clearCalls++;
  }
}

class _Transcription implements TranscriptionRepository {
  var resetCalls = 0;

  @override
  Future<void> reset() async {
    resetCalls++;
  }

  @override
  Future<List<SpeechModel>> getModels({bool refresh = true}) async => const [];

  @override
  Future<bool> isModelDownloaded(String slug) async => false;

  @override
  Future<void> downloadModel(
    String slug, {
    TranscriptionDownloadProgress? onProgress,
  }) async {}

  @override
  Future<String> transcribeRange({
    required Audiobook book,
    required Duration start,
    required Duration end,
    required String model,
  }) async => '';
}
