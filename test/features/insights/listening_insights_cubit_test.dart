import 'package:bookish_player/features/insights/presentation/listening_insights_cubit.dart';
import 'package:bookish_player/features/insights/presentation/listening_insights_state.dart';
import 'package:bookish_player/features/library/domain/book_metadata.dart';
import 'package:bookish_player/features/library/domain/book_metadata_repository.dart';
import 'package:bookish_player/features/library/domain/listening_history_repository.dart';
import 'package:bookish_player/features/library/domain/listening_session.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'load failure exposes the operation, type, and parsing detail',
    () async {
      final cubit = ListeningInsightsCubit(_BrokenMetadata(), _EmptyHistory());
      addTearDown(cubit.close);

      await cubit.load();

      expect(cubit.state.status, ListeningInsightsStatus.failure);
      expect(cubit.state.message, contains('could not be loaded'));
      expect(cubit.state.message, contains('FormatException'));
      expect(cubit.state.message, contains('metadata record "broken-book"'));
    },
  );
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
