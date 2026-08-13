import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/robots/widget_robot.dart';

final class LibraryScreenRobot extends WidgetRobot {
  const LibraryScreenRobot(super.tester);

  void expectFinishedBook({
    required String finishedLabel,
    required String remainingText,
  }) {
    expectText(finishedLabel);
    expectTextContaining(remainingText, matcher: findsNothing);
  }

  Future<void> search(String query) {
    return enterText(find.byType(SearchBar), query);
  }

  void expectSearchFocused() {
    expect(_searchField.focusNode.hasFocus, isTrue);
  }

  Future<void> openBook(String title) => tapText(title);

  void expectSearchUnfocused() {
    expect(find.byType(SearchBar), findsOneWidget);
    expect(_searchField.focusNode.hasFocus, isFalse);
  }

  EditableText get _searchField {
    return tester.widget<EditableText>(find.byType(EditableText));
  }
}
