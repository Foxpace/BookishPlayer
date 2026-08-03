import 'package:bookish_player/features/settings/domain/settings_repository.dart';
import 'package:bookish_player/features/settings/domain/theme_preference.dart';
import 'package:bookish_player/features/settings/presentation/settings_cubit.dart';
import 'package:bookish_player/features/settings/presentation/settings_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('loads and persists an independent theme preference', () async {
    final repository = _FakeSettingsRepository(ThemePreference.dark);
    final cubit = SettingsCubit(repository);
    addTearDown(cubit.close);

    await cubit.load();

    expect(cubit.state.status, SettingsStatus.ready);
    expect(cubit.state.themePreference, ThemePreference.dark);

    await cubit.setThemePreference(ThemePreference.light);

    expect(cubit.state.themePreference, ThemePreference.light);
    expect(repository.savedPreference, ThemePreference.light);
  });
}

class _FakeSettingsRepository implements SettingsRepository {
  _FakeSettingsRepository(this.preference);

  ThemePreference preference;
  ThemePreference? savedPreference;

  @override
  Future<ThemePreference> getThemePreference() async => preference;

  @override
  Future<void> setThemePreference(ThemePreference preference) async {
    this.preference = preference;
    savedPreference = preference;
  }

  @override
  Future<String?> getLibraryLayout() async => null;

  @override
  Future<void> setLibraryLayout(String layout) async {}

  @override
  Future<String?> getSpeechModel() async => null;

  @override
  Future<void> setSpeechModel(String model) async {}
}
