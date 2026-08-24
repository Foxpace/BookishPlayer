part of 'bookish_theme.dart';

typedef _ThemePalette = ({
  Color background,
  Color foreground,
  Color surface,
  Color border,
  Color field,
});

ThemeData _buildBookishTheme({
  required Brightness brightness,
  required Color seedColor,
  required ColorScheme? systemColorScheme,
  required _ThemePalette fallbackPalette,
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
  final base = ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorScheme: scheme,
  );
  return _applyBookishComponentThemes(
    base: base,
    brightness: brightness,
    palette: palette,
  );
}
