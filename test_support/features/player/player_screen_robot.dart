import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/robots/widget_robot.dart';

final class PlayerScreenRobot extends WidgetRobot {
  const PlayerScreenRobot(super.tester);

  void expectMiniPlayer({required String title, required String status}) {
    expectText(title);
    expectText(status);
  }

  Future<void> togglePlayback(String tooltip) =>
      tapTooltip(tooltip, settle: false);

  void expectPlaying({required String pauseTooltip, required String status}) {
    expect(find.byTooltip(pauseTooltip), findsOneWidget);
    expectText(status);
  }

  void expectBookHidden(String title) {
    expectText(title, matcher: findsNothing);
  }

  Future<void> goBackToLibrary(String tooltip) => tapTooltip(tooltip);

  void expectLibrary(String label) => expectText(label);

  void expectActiveChapter({required String semantics, required String title}) {
    expectTextContaining(semantics);
    expectText(title);
  }

  Future<void> openNotes(String tooltip) => tapTooltip(tooltip);

  Text notePreview(String text) => tester.widget<Text>(find.text(text));

  Future<void> openNote(String text) => tapText(text);

  void expectNoteDetailReady({
    required String shareTooltip,
    required String titleHint,
  }) {
    expect(find.byTooltip(shareTooltip), findsOneWidget);
    expectText(titleHint);
    expect(tester.testTextInput.isVisible, isFalse);
    expect(
      tester
          .widgetList<TextField>(find.byType(TextField))
          .every((field) => field.focusNode?.hasFocus != true),
      isTrue,
    );
  }

  Future<void> editNote({required String title, required String text}) async {
    await enterText(find.byType(TextField).first, title);
    await enterText(find.byType(TextField).last, text);
  }

  Future<void> shareNote(String tooltip) => tapTooltip(tooltip, settle: false);

  Future<void> saveNote(String label) => tapText(label);
}
