import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/robots/widget_robot.dart';

final class NoteGalleryRobot extends WidgetRobot {
  const NoteGalleryRobot(super.tester);

  void expectGallerySummary(Iterable<String> labels) {
    for (final label in labels) {
      expectText(label);
    }
  }

  Future<void> openBook(String title) => tapText(title);

  void expectBookNotes(Iterable<String> notes) {
    for (final note in notes) {
      expectText(note);
    }
  }

  Future<void> openNote(String text) => tapText(text);

  void expectNoteDetail({required String title, required String titleHint}) {
    expect(find.widgetWithText(AppBar, title), findsOneWidget);
    expectText(titleHint);
  }

  Future<void> replaceNoteText(String text) {
    return enterText(find.byType(TextField).last, text);
  }

  Future<void> saveNote(String label) => tapText(label);

  void expectNoteText(String text) => expectText(text);
}
