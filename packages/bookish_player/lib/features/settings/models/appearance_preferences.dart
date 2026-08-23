import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/theme/bookish_theme_seed.dart';
import 'theme_preference.dart';

part 'appearance_preferences.freezed.dart';

@freezed
abstract class AppearancePreferences with _$AppearancePreferences {
  const factory AppearancePreferences({
    @Default(ThemePreference.system) ThemePreference theme,
    @Default(true) bool useSystemColors,
    @Default(defaultBookishSeedColorValue) int primaryColor,
  }) = _AppearancePreferences;
}
