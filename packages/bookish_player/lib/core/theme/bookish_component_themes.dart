part of 'bookish_theme.dart';

ThemeData _applyBookishComponentThemes({
  required ThemeData base,
  required Brightness brightness,
  required _ThemePalette palette,
}) {
  final (:background, :foreground, :surface, :border, :field) = palette;
  final controlTextTheme = base.textTheme.apply(
    bodyColor: foreground,
    displayColor: foreground,
    fontFamily: BookishTheme._controlFontFamily,
  );
  return base.copyWith(
    scaffoldBackgroundColor: background,
    textTheme: base.textTheme.apply(
      bodyColor: foreground,
      displayColor: foreground,
      fontFamily: BookishTheme._bodyFontFamily,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      foregroundColor: foreground,
      surfaceTintColor: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: brightness,
        statusBarIconBrightness: brightness == Brightness.light
            ? Brightness.dark
            : Brightness.light,
      ),
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
      labelStyle: controlTextTheme.bodyLarge,
      floatingLabelStyle: controlTextTheme.bodyLarge,
      hintStyle: controlTextTheme.bodyLarge,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        borderSide: BorderSide.none,
      ),
    ),
    dividerTheme: DividerThemeData(color: border),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      linearTrackColor: border,
    ),
    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: controlTextTheme.bodyLarge,
    ),
    menuButtonTheme: MenuButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStatePropertyAll(controlTextTheme.labelLarge),
      ),
    ),
    popupMenuTheme: PopupMenuThemeData(
      textStyle: controlTextTheme.labelLarge,
      labelTextStyle: WidgetStatePropertyAll(controlTextTheme.labelLarge),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: surface,
      titleTextStyle: controlTextTheme.headlineSmall,
      contentTextStyle: controlTextTheme.bodyMedium,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: surface,
      surfaceTintColor: Colors.transparent,
    ),
  );
}
