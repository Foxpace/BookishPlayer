import 'package:flutter_test/flutter_test.dart';

import '../../support/robots/widget_robot.dart';

final class StorageAssistantRobot extends WidgetRobot {
  const StorageAssistantRobot(super.tester);

  void expectReport(Iterable<String> labels) {
    for (final label in labels) {
      expectText(label);
    }
  }

  Future<void> cleanUnusedFiles({
    required String cleanLabel,
    required String dialogTitle,
    required String confirmLabel,
  }) async {
    await tapText(cleanLabel);
    expectText(dialogTitle);
    await tap(find.text(confirmLabel).last);
  }

  void expectUnusedFilesRemoved(String message) => expectText(message);

  Future<void> removeMissingEntry({
    required String tooltip,
    required String confirmationText,
    required String confirmLabel,
  }) async {
    await tapTooltip(tooltip);
    expectTextContaining(confirmationText);
    await tapText(confirmLabel);
  }

  Future<void> eraseEverything({
    required String eraseLabel,
    required String confirmLabel,
  }) async {
    await tapText(eraseLabel);
    await tapText(confirmLabel);
  }

  void expectEraseFailure(String message) => expectTextContaining(message);

  void expectResetWarning(String message) => expectTextContaining(message);

  void expectLibraryDestination(String label) => expectText(label);
}
