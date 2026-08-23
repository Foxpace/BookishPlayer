import 'package:bookish_player/core/theme/bookish_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Bookish theme', () {
    test(
      'Given the bookish theme, When its behavior is exercised, Then provides distinct complete light and dark themes',
      () {
        // THEN
        expect(BookishTheme.light.brightness, Brightness.light);
        expect(BookishTheme.dark.brightness, Brightness.dark);
        expect(
          BookishTheme.light.scaffoldBackgroundColor,
          isNot(BookishTheme.dark.scaffoldBackgroundColor),
        );
        expect(BookishTheme.dark.cardTheme.color, isNotNull);
        expect(BookishTheme.dark.inputDecorationTheme.fillColor, isNotNull);
        expect(
          BookishTheme.light.textTheme.diagnostics?.fontFamily,
          'monospace',
        );
      },
    );

    test(
      'Given manual app colors, When different primary colors are selected, Then each theme derives a distinct Material color scheme',
      () {
        // WHEN
        final blue = BookishTheme.lightFrom(seedColor: Colors.blue);
        final green = BookishTheme.lightFrom(seedColor: Colors.green);

        // THEN
        expect(blue.colorScheme.primary, isNot(green.colorScheme.primary));
      },
    );

    test(
      'Given the app theme changes, When the status bar renders, Then its text brightness follows the theme',
      () {
        // GIVEN
        final lightStyle = BookishTheme.light.appBarTheme.systemOverlayStyle;
        final darkStyle = BookishTheme.dark.appBarTheme.systemOverlayStyle;

        // THEN
        expect(lightStyle?.statusBarBrightness, Brightness.light);
        expect(lightStyle?.statusBarIconBrightness, Brightness.dark);
        expect(darkStyle?.statusBarBrightness, Brightness.dark);
        expect(darkStyle?.statusBarIconBrightness, Brightness.light);
      },
    );

    test(
      'Given an Android system color scheme, When the theme is built, Then system surfaces and primary colors are used',
      () {
        // GIVEN
        final system = ColorScheme.fromSeed(
          seedColor: Colors.purple,
          brightness: Brightness.light,
        );

        // WHEN
        final theme = BookishTheme.lightFrom(systemColorScheme: system);

        // THEN
        expect(theme.colorScheme.primary, system.primary);
        expect(theme.scaffoldBackgroundColor, system.surface);
        expect(theme.cardTheme.color, system.surfaceContainerLow);
      },
    );
  });
}
