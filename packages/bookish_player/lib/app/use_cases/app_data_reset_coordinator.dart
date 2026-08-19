import '../../core/use_cases/app_data_reset.dart';
import '../../core/use_cases/app_data_reset_outcome.dart';

class AppDataResetCoordinator implements AppDataReset {
  factory AppDataResetCoordinator({
    required Future<void> Function() resetPlayback,
    required Future<void> Function() deletePersistentData,
    required Future<void> Function() reloadSettings,
  }) => AppDataResetCoordinator._(
    resetPlayback,
    deletePersistentData,
    reloadSettings,
  );

  const AppDataResetCoordinator._(
    this._resetPlayback,
    this._deletePersistentData,
    this._reloadSettings,
  );

  final Future<void> Function() _resetPlayback;
  final Future<void> Function() _deletePersistentData;
  final Future<void> Function() _reloadSettings;

  @override
  Future<AppDataResetOutcome> reset() async {
    try {
      await _resetPlayback();
    } catch (_) {
      return AppDataResetOutcome.playbackResetFailed;
    }

    try {
      await _deletePersistentData();
    } catch (_) {
      return AppDataResetOutcome.persistentDeletionFailed;
    }

    try {
      return await _reloadSettingsAndComplete();
    } catch (_) {
      return AppDataResetOutcome.completedWithSettingsReloadWarning;
    }
  }

  Future<AppDataResetOutcome> _reloadSettingsAndComplete() async {
    await _reloadSettings();
    return AppDataResetOutcome.completed;
  }
}
