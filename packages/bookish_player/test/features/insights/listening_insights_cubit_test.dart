import 'package:bookish_player/core/presentation/app_message.dart';
import 'package:bookish_player/features/insights/use_cases/load_listening_insights_use_case.dart';
import 'package:bookish_player/features/insights/use_cases/insights_use_cases.dart';
import 'package:bookish_player/features/insights/cubits/listening_insights_cubit.dart';
import 'package:bookish_player/features/insights/cubits/insights_cubits.dart';
import 'package:bookish_player/features/insights/repos/implementations/library_listening_insights_repository.dart';
import 'package:bookish_player/features/library/models/library_models.dart';
import 'package:bookish_player/features/library/repos/book_metadata_repository.dart';
import 'package:bookish_player/features/library/repos/listening_history_repository.dart';
import 'package:bookish_player/features/library/models/listening_session.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/fakes/fake_clock.dart';

void main() {
  group('Malformed listening metadata', () {
    test(
      'Given malformed listening metadata, When listening insights are loaded, Then a typed revisioned failure is emitted',
      () async {
        // GIVEN
        final sut = ListeningInsightsCubit(
          InsightsUseCases(
            loadListeningInsights: LoadListeningInsightsUseCase(
              LibraryListeningInsightsRepository(
                _BrokenMetadata(),
                _EmptyHistory(),
              ),
              FakeClock(),
            ),
          ),
        );
        addTearDown(sut.close);

        // WHEN
        await sut.load();

        // THEN
        expect(sut.state.status, ListeningInsightsStatus.failure);
        expect(sut.state.message, AppMessage.listeningInsightsLoadFailed);
        expect(sut.state.effectRevision, 1);
      },
    );
  });
}

class _BrokenMetadata implements BookMetadataRepository {
  @override
  Future<List<BookMetadata>> getBookMetadata() {
    throw const FormatException(
      'Could not parse audiobook metadata record "broken-book"',
    );
  }

  @override
  Future<BookMetadata?> findBookMetadata(String fingerprint) async => null;
}

class _EmptyHistory implements ListeningHistoryRepository {
  @override
  Future<List<ListeningSession>> getListeningSessions() async => const [];

  @override
  Future<void> saveListeningSession(ListeningSession session) async {}
}
