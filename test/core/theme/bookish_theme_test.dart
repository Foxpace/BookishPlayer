import 'package:bookish_player/core/theme/bookish_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('provides distinct complete light and dark themes', () {
    expect(BookishTheme.light.brightness, Brightness.light);
    expect(BookishTheme.dark.brightness, Brightness.dark);
    expect(
      BookishTheme.light.scaffoldBackgroundColor,
      isNot(BookishTheme.dark.scaffoldBackgroundColor),
    );
    expect(BookishTheme.dark.cardTheme.color, isNotNull);
    expect(BookishTheme.dark.inputDecorationTheme.fillColor, isNotNull);
  });
}
