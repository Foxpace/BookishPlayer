enum ThemePreference {
  system,
  light,
  dark;

  static ThemePreference fromStorage(String? value) {
    return values.where((preference) => preference.name == value).firstOrNull ??
        ThemePreference.system;
  }
}
