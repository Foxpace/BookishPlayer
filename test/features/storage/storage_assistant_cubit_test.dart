import 'package:bookish_player/core/presentation/app_message.dart';
import 'package:bookish_player/features/library/models/library_models.dart';
import 'package:bookish_player/features/library/repos/audiobook_catalog_repository.dart';
import 'package:bookish_player/features/library/models/audiobook_removal_mode.dart';
import 'package:bookish_player/features/storage/use_cases/storage_assistant_workflow.dart';
import 'package:bookish_player/features/storage/repos/app_data_reset_repository.dart';
import 'package:bookish_player/features/storage/repos/library_storage_repository.dart';
import 'package:bookish_player/features/storage/models/storage_report.dart';
import 'package:bookish_player/features/storage/cubits/storage_assistant_cubit.dart';
import 'package:bookish_player/features/transcription/repos/transcription_repositories.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/fixtures.dart';
import 'storage_test_builder.dart';

void main() {
  group('Local library storage', () {
    late _Books books;
    late _Storage storage;
    late _Reset reset;
    late _Transcription transcription;
    late StorageAssistantCubit sut;

    setUp(() {
      books = _Books([audiobookFixture()]);
      storage = _Storage();
      reset = _Reset();
      transcription = _Transcription();
      sut = createStorageCubit(
        StorageAssistantWorkflow(books, storage, reset, transcription),
      );
    });

    tearDown(() => sut.close());

    test(
      'Given local library storage, When storage is inspected and cleaned, Then reports, deletion intents, and revisioned effects are emitted',
      () async {
        // GIVEN
        await sut.load();
        // WHEN
        await sut.cleanOrphans();

        // THEN
        expect(storage.inspectedBooks, hasLength(2));
        expect(storage.deletedPaths, ['/orphan.tmp']);
        expect(sut.state.message, AppMessage.unusedFilesRemoved);
        expect(sut.state.effectRevision, 1);

        await sut.removeMissingBook('book-1');
        expect(books.deletedIds, ['book-1']);
      },
    );

    test(
      'Given local library storage, When all application data is erased, Then transcription resets before persistent data is cleared',
      () async {
        // WHEN
        final cleared = await sut.clearAll();

        // THEN
        expect(cleared, isTrue);
        expect(transcription.resetCalls, 1);
        expect(reset.clearCalls, 1);
        expect(sut.state.message, AppMessage.allDataRemoved);
      },
    );

    test(
      'Given local library storage, When inspection or clearing fails, Then typed failure effects are emitted without throwing',
      () async {
        // GIVEN
        storage.failure = Exception('inspect');
        // WHEN
        await sut.load();
        // THEN
        expect(sut.state.message, AppMessage.storageInspectFailed);
        expect(sut.state.effectRevision, 1);

        storage.failure = null;
        reset.failure = Exception('clear');
        expect(await sut.clearAll(), isFalse);
        expect(sut.state.message, AppMessage.clearDataFailed);
        expect(sut.state.effectRevision, 2);
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
  Future<Audiobook?> getBook(String id) async => null;
  @override
  Future<void> saveBook(Audiobook book) async {}
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
  final report = const StorageReport(orphanPaths: ['/orphan.tmp']);
  final inspectedBooks = <Audiobook>[];
  final deletedPaths = <String>[];
  Exception? failure;

  @override
  Future<StorageReport> inspect(List<Audiobook> books) async {
    if (failure case final value?) {
      throw value;
    }
    inspectedBooks.addAll(books);
    return report;
  }

  @override
  Future<void> deleteOrphans(List<String> paths) async {
    if (failure case final value?) {
      throw value;
    }
    deletedPaths.addAll(paths);
  }
}

class _Reset implements AppDataResetRepository {
  var clearCalls = 0;
  Exception? failure;

  @override
  Future<void> clearAll() async {
    clearCalls++;
    if (failure case final value?) {
      throw value;
    }
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
