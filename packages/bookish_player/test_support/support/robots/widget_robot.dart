import 'package:flutter_test/flutter_test.dart';

abstract base class WidgetRobot {
  const WidgetRobot(this.tester);

  final WidgetTester tester;

  void expectText(String label, {Matcher matcher = findsOneWidget}) {
    expect(find.text(label), matcher);
  }

  void expectTextContaining(String label, {Matcher matcher = findsOneWidget}) {
    expect(find.textContaining(label), matcher);
  }

  Future<void> tapText(String label, {bool settle = true}) async {
    await tap(find.text(label), settle: settle);
  }

  Future<void> tapTooltip(String label, {bool settle = true}) async {
    await tap(find.byTooltip(label), settle: settle);
  }

  Future<void> tap(Finder finder, {bool settle = true}) async {
    await tester.ensureVisible(finder);
    await tester.tap(finder);
    if (settle) {
      await tester.pumpAndSettle();
    } else {
      await tester.pump();
    }
  }

  Future<void> enterText(Finder finder, String value) async {
    await tester.ensureVisible(finder);
    await tester.enterText(finder, value);
  }
}
