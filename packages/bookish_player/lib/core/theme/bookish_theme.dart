import 'package:flutter/material.dart';

import 'bookish_theme_seed.dart';

part 'bookish_text_styles.dart';

abstract final class BookishTheme {
  static const _bodyFontFamily = 'serif';
  static const _diagnosticFontFamily = 'monospace';
  static const _lightPaper = Color(0xFFF7F3EA);
  static const _lightInk = Color(0xFF26241F);
  static const _darkPaper = Color(0xFF171612);
  static const _darkInk = Color(0xFFF4EEE4);

  static ThemeData get light => lightFrom();

  static ThemeData get dark => darkFrom();

  static ThemeData lightFrom({
    Color seedColor = const Color(defaultBookishSeedColorValue),
    ColorScheme? systemColorScheme,
  }) => _build(
    brightness: Brightness.light,
    seedColor: seedColor,
    systemColorScheme: systemColorScheme,
    fallbackPalette: const (
      background: _lightPaper,
      foreground: _lightInk,
      surface: Color(0xFFFFFCF6),
      border: Color(0xFFE8E0D2),
      field: Color(0xFFFFFCF6),
    ),
  );

  static ThemeData darkFrom({
    Color seedColor = const Color(defaultBookishSeedColorValue),
    ColorScheme? systemColorScheme,
  }) => _build(
    brightness: Brightness.dark,
    seedColor: seedColor,
    systemColorScheme: systemColorScheme,
    fallbackPalette: const (
      background: _darkPaper,
      foreground: _darkInk,
      surface: Color(0xFF211F1A),
      border: Color(0xFF3B382F),
      field: Color(0xFF292720),
    ),
  );

  static ThemeData _build({
    required Brightness brightness,
    required Color seedColor,
    required ColorScheme? systemColorScheme,
    required ({
      Color background,
      Color foreground,
      Color surface,
      Color border,
      Color field,
    })
    fallbackPalette,
  }) {
    final scheme =
        systemColorScheme ??
        ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: brightness,
          surface: fallbackPalette.surface,
          onSurface: fallbackPalette.foreground,
        );
    final palette = systemColorScheme == null
        ? fallbackPalette
        : (
            background: scheme.surface,
            foreground: scheme.onSurface,
            surface: scheme.surfaceContainerLow,
            border: scheme.outlineVariant,
            field: scheme.surfaceContainerHighest,
          );
    final (:background, :foreground, :surface, :border, :field) = palette;
    final base = ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
    );
    return base.copyWith(
      scaffoldBackgroundColor: background,
      textTheme: base.textTheme.apply(
        bodyColor: foreground,
        displayColor: foreground,
        fontFamily: _bodyFontFamily,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: foreground,
        surfaceTintColor: Colors.transparent,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: surface,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(22)),
          side: BorderSide(color: border),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: field,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide.none,
        ),
      ),
      dividerTheme: DividerThemeData(color: border),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        linearTrackColor: border,
      ),
      dialogTheme: DialogThemeData(backgroundColor: surface),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: surface,
        surfaceTintColor: Colors.transparent,
      ),
    );
  }
}
