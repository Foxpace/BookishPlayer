import 'package:flutter/material.dart';

part 'bookish_text_styles.dart';

abstract final class BookishTheme {
  static const _bodyFontFamily = 'serif';
  static const _diagnosticFontFamily = 'monospace';
  static const _ochre = Color(0xFFBD6C3B);
  static const _lightPaper = Color(0xFFF7F3EA);
  static const _lightInk = Color(0xFF26241F);
  static const _darkPaper = Color(0xFF171612);
  static const _darkInk = Color(0xFFF4EEE4);

  static ThemeData get light => _build(
    brightness: Brightness.light,
    background: _lightPaper,
    foreground: _lightInk,
    palette: const (
      surface: Color(0xFFFFFCF6),
      border: Color(0xFFE8E0D2),
      field: Color(0xFFFFFCF6),
    ),
  );

  static ThemeData get dark => _build(
    brightness: Brightness.dark,
    background: _darkPaper,
    foreground: _darkInk,
    palette: const (
      surface: Color(0xFF211F1A),
      border: Color(0xFF3B382F),
      field: Color(0xFF292720),
    ),
  );

  static ThemeData _build({
    required Brightness brightness,
    required Color background,
    required Color foreground,
    required ({Color surface, Color border, Color field}) palette,
  }) {
    final (:surface, :border, :field) = palette;
    final scheme = ColorScheme.fromSeed(
      seedColor: _ochre,
      brightness: brightness,
      surface: surface,
      onSurface: foreground,
    );
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
