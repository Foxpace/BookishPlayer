import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/robots/widget_robot.dart';

final class MetadataEditorRobot extends WidgetRobot {
  const MetadataEditorRobot(super.tester);

  void expectLoaded({
    required String heading,
    required String trackOrderLabel,
    required Iterable<String> trackTitles,
  }) {
    expectText(heading);
    expectText(trackOrderLabel);
    for (final title in trackTitles) {
      expectText(title);
    }
  }

  Future<void> reviseDetails({
    required String title,
    required String author,
    required String saveLabel,
  }) async {
    await enterText(find.byType(TextField).at(0), title);
    await enterText(find.byType(TextField).at(1), author);
    await tapText(saveLabel);
  }

  Future<void> changeCover(String label) => tapText(label);

  Future<void> addChapter({
    required String title,
    required String positionSeconds,
    required String addTooltip,
    required String confirmLabel,
  }) async {
    await tapTooltip(addTooltip);
    final fields = find.byType(TextField);
    await enterText(fields.at(fields.evaluate().length - 2), title);
    await enterText(fields.last, positionSeconds);
    await tapText(confirmLabel);
  }

  void expectChapter(String title) => expectText(title);

  Future<void> deleteFirstChapter(IconData icon) {
    return tap(find.byIcon(icon).first);
  }

  void expectLoadFailure(String message) => expectText(message);

  Future<void> retry(String label) => tapText(label);

  void expectRecovered(Iterable<String> labels) {
    for (final label in labels) {
      expectText(label);
    }
  }
}
