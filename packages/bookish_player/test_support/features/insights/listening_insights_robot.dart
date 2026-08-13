import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/robots/widget_robot.dart';

final class ListeningInsightsRobot extends WidgetRobot {
  const ListeningInsightsRobot(super.tester);

  void expectPopulatedSummary(Iterable<String> labels) {
    for (final label in labels) {
      expectText(label);
    }
    expect(find.byType(LinearProgressIndicator), findsWidgets);
  }

  Future<void> selectPeriod(String label) => tapText(label);

  void expectPeriodSummary(String label) => expectText(label);

  void expectEmpty(String message) => expectText(message);

  void expectLoadFailure(String message) => expectText(message);

  Future<void> retry(String label) => tapText(label);

  void expectRecovered(String label) => expectText(label);
}
