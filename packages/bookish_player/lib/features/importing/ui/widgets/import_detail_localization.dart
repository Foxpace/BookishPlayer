part of 'import_state_localization.dart';

extension ImportDetailLocalization on ImportState {
  String localizeDetail(BuildContext context) {
    final l10n = S.of(context);
    return switch (detail) {
      ImportDetail.chooseFiles => l10n.importChooseFiles,
      ImportDetail.keepAppOpen => switch (currentTitle) {
        final title? => l10n.importKeepOpenWithFile(title),
        null => l10n.importKeepOpen,
      },
      ImportDetail.copyProgress => l10n.importCopyProgress(
        currentTitle ?? '',
        _formatByteCount(copiedBytes ?? 0),
        _formatByteCount(totalBytes ?? 0),
      ),
      ImportDetail.removingOriginals => l10n.importRemovingOriginalsDetail,
      ImportDetail.finderInstructions => l10n.importFinderInstructions,
      ImportDetail.selectionCancelled => l10n.importSelectionCancelled,
      ImportDetail.originalsRemain => l10n.importOriginalsRemainDetail,
      ImportDetail.stageFailed => l10n.importFailureAtStage(
        _localizeImportStage(l10n, failureStage),
      ),
    };
  }
}
