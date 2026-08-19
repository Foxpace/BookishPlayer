enum AppDataResetOutcome {
  completed,
  completedWithSettingsReloadWarning,
  playbackResetFailed,
  persistentDeletionFailed;

  bool get dataRemoved => switch (this) {
    completed || completedWithSettingsReloadWarning => true,
    playbackResetFailed || persistentDeletionFailed => false,
  };
}
