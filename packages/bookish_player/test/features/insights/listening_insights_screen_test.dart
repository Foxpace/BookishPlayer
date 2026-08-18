import 'package:bookish_player/features/insights/use_cases/load_listening_insights_use_case.dart';
import 'package:bookish_player/features/insights/use_cases/insights_use_cases.dart';
import 'package:bookish_player/features/insights/cubits/listening_insights_cubit.dart';
import 'package:bookish_player/features/insights/cubits/listening_insights_state.dart';
import 'package:bookish_player/features/insights/repos/implementations/library_listening_insights_repository.dart';
import 'package:bookish_player/features/insights/ui/listening_insights_screen.dart';
import 'package:bookish_player/features/library/models/library_models.dart';
import 'package:bookish_player/features/library/repos/book_metadata_repository.dart';
import 'package:bookish_player/features/library/repos/listening_history_repository.dart';
import 'package:bookish_player/features/library/models/listening_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_support/support/fakes/fake_clock.dart';
import '../../../test_support/support/fixtures.dart';
import '../../../test_support/support/pump_bookish_app.dart';
import '../../../test_support/features/insights/listening_insights_robot.dart';

void main() {
  group('Populated local listening history', () {
    late _Metadata metadata;
    late _History history;
    late ListeningInsightsCubit cubit;

    setUp(() async {
      metadata = _Metadata([
        bookMetadataFixture().copyWith(completedAt: fixtureTime),
        bookMetadataFixture(id: 'metadata-2', activeBookId: 'book-2'),
      ]);
      history = _History([
        listeningSessionFixture(),
        listeningSessionFixture(id: 'session-2').copyWith(
          startedAt: fixtureTime.add(const Duration(days: 1)),
          endedAt: fixtureTime.add(const Duration(days: 1, minutes: 20)),
          listenedMs: 1_200_000,
        ),
      ]);
      cubit = ListeningInsightsCubit(
        _useCases(
          metadata,
          history,
          FakeClock(fixtureTime.add(const Duration(days: 1))),
        ),
      );
      await cubit.load();
    });

    tearDown(() => cubit.close());

    testWidgets(
      'Given populated local listening history, When the summary and period controls are rendered, Then totals render and period intents update the activity',
      (tester) async {
        final robot = ListeningInsightsRobot(tester);

        // WHEN
        await tester.pumpBookishApp(
          display: const (
            themeMode: ThemeMode.light,
            locale: Locale('en'),
            viewport: Size(600, 1100),
            textScale: 1,
          ),
          child: _insightsScreen(cubit),
        );

        // THEN
        robot.expectPopulatedSummary(const [
          'All-time listening',
          'Listening activity',
          '1',
          '2',
          'Last 7 days',
        ]);

        await robot.selectPeriod('Month');
        expect(cubit.state.selectedPeriod.name, 'month');
        robot.expectPeriodSummary('Last 30 days');

        await robot.selectPeriod('Year');
        expect(cubit.state.selectedPeriod.name, 'year');
        robot.expectPeriodSummary('Last 12 months');
      },
    );
  });

  group('Empty or temporarily unavailable listening history', () {
    testWidgets(
      'Given empty or temporarily unavailable listening history, When an empty summary is rendered, Then a localized empty state is shown',
      (tester) async {
        final robot = ListeningInsightsRobot(tester);

        // GIVEN
        final cubit = ListeningInsightsCubit(
          _useCases(_Metadata(), _History(), FakeClock()),
        );
        addTearDown(cubit.close);
        await cubit.load();

        // WHEN
        await tester.pumpBookishApp(child: _insightsScreen(cubit));

        // THEN
        robot.expectEmpty('Your listening history will appear here.');
      },
    );

    testWidgets(
      'Given empty or temporarily unavailable listening history, When loading fails and is retried, Then a typed failure recovers to the ready state',
      (tester) async {
        final robot = ListeningInsightsRobot(tester);

        // GIVEN
        final metadata = _Metadata()..failure = Exception('corrupt record');
        final cubit = ListeningInsightsCubit(
          _useCases(metadata, _History(), FakeClock()),
        );
        addTearDown(cubit.close);
        await cubit.load();

        // WHEN
        await tester.pumpBookishApp(child: _insightsScreen(cubit));
        // THEN
        robot.expectLoadFailure('Listening insights could not be loaded.');

        metadata.failure = null;
        await robot.retry('Try again');

        robot.expectRecovered('All-time listening');
      },
    );
  });
}

Widget _insightsScreen(ListeningInsightsCubit cubit) {
  return BlocBuilder<ListeningInsightsCubit, ListeningInsightsState>(
    bloc: cubit,
    builder: (_, state) => ListeningInsightsScreen(
      state: state,
      onRetry: cubit.load,
      onPeriodSelected: cubit.selectPeriod,
    ),
  );
}

InsightsUseCases _useCases(
  BookMetadataRepository metadata,
  ListeningHistoryRepository history,
  FakeClock clock,
) => InsightsUseCases(
  loadListeningInsights: LoadListeningInsightsUseCase(
    LibraryListeningInsightsRepository(metadata, history),
    clock,
  ),
);

class _Metadata implements BookMetadataRepository {
  _Metadata([this.records = const []]);

  List<BookMetadata> records;
  Exception? failure;

  @override
  Future<List<BookMetadata>> getBookMetadata() async {
    if (failure case final value?) {
      throw value;
    }
    return records;
  }

  @override
  Future<BookMetadata?> findBookMetadata(String fingerprint) async {
    for (final record in records) {
      if (record.fingerprint == fingerprint) {
        return record;
      }
    }
    return null;
  }
}

class _History implements ListeningHistoryRepository {
  _History([this.sessions = const []]);

  List<ListeningSession> sessions;

  @override
  Future<List<ListeningSession>> getListeningSessions() async => sessions;

  @override
  Future<void> saveListeningSession(ListeningSession session) async {
    sessions = [...sessions, session];
  }
}
