part of 'bookish_theme.dart';

extension BookishTextStyles on TextTheme {
  TextStyle? get diagnostics =>
      bodySmall?.copyWith(fontFamily: BookishTheme._diagnosticFontFamily);
}
