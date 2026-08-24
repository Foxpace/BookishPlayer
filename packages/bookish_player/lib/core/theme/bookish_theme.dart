import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'bookish_theme_seed.dart';

part 'bookish_text_styles.dart';
part 'bookish_theme_builder.dart';
part 'bookish_component_themes.dart';

abstract final class BookishTheme {
  static const _bodyFontFamily = 'serif';
  static const _controlFontFamily = 'Roboto';
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
  }) => _buildBookishTheme(
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
  }) => _buildBookishTheme(
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
}
