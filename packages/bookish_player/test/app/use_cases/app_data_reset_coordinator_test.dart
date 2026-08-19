import 'package:bookish_player/app/use_cases/app_data_reset_coordinator.dart';
import 'package:bookish_player/core/use_cases/app_data_reset_outcome.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Application data reset', () {
    test(
      'Given available reset steps, When reset runs, Then operations complete in dependency order',
      () async {
        // GIVEN
        final steps = _ResetSteps();
        final sut = steps.build();
        // WHEN
        final outcome = await sut.reset();
        // THEN
        expect(outcome, AppDataResetOutcome.completed);
        expect(steps.calls, ['playback', 'delete', 'settings']);
      },
    );

    test(
      'Given playback reset failure, When reset runs, Then persistent deletion does not start',
      () async {
        // GIVEN
        final steps = _ResetSteps(failure: _ResetStep.playback);
        // WHEN
        final outcome = await steps.build().reset();
        // THEN
        expect(outcome, AppDataResetOutcome.playbackResetFailed);
        expect(steps.calls, ['playback']);
      },
    );

    test(
      'Given persistent deletion failure, When reset runs, Then settings reload does not start',
      () async {
        // GIVEN
        final steps = _ResetSteps(failure: _ResetStep.delete);
        // WHEN
        final outcome = await steps.build().reset();
        // THEN
        expect(outcome, AppDataResetOutcome.persistentDeletionFailed);
        expect(steps.calls, ['playback', 'delete']);
      },
    );

    test(
      'Given settings reload failure after deletion, When reset runs, Then deletion remains committed',
      () async {
        // GIVEN
        final steps = _ResetSteps(failure: _ResetStep.settings);
        // WHEN
        final outcome = await steps.build().reset();
        // THEN
        expect(outcome, AppDataResetOutcome.completedWithSettingsReloadWarning);
        expect(outcome.dataRemoved, isTrue);
        expect(steps.calls, ['playback', 'delete', 'settings']);
      },
    );
  });
}

enum _ResetStep { playback, delete, settings }

final class _ResetSteps {
  _ResetSteps({this.failure});

  final _ResetStep? failure;
  final calls = <String>[];

  AppDataResetCoordinator build() => AppDataResetCoordinator(
    resetPlayback: () => _run(_ResetStep.playback),
    deletePersistentData: () => _run(_ResetStep.delete),
    reloadSettings: () => _run(_ResetStep.settings),
  );

  Future<void> _run(_ResetStep step) async {
    calls.add(step.name);
    if (failure == step) {
      throw StateError('${step.name} failed');
    }
  }
}
