import 'package:bookish_player/features/settings/models/playback_preferences.dart';
import 'package:bookish_player/features/settings/repos/settings_repository.dart';
import 'package:bookish_player/features/settings/models/theme_preference.dart';

class FakeLibrarySettings implements SettingsRepository {
  String? layout;
  String? speechModel;
  var theme = ThemePreference.system;
  var playback = const PlaybackPreferences();
  Exception? readFailure;
  Exception? writeFailure;
  final savedPlayback = <PlaybackPreferences>[];
  final savedThemes = <ThemePreference>[];

  @override
  Future<String?> getLibraryLayout() async => layout;

  @override
  Future<void> setLibraryLayout(String layout) async {
    this.layout = layout;
  }

  @override
  Future<ThemePreference> getThemePreference() async {
    if (readFailure case final failure?) {
      throw failure;
    }
    return theme;
  }

  @override
  Future<void> setThemePreference(ThemePreference preference) async {
    if (writeFailure case final failure?) {
      throw failure;
    }
    theme = preference;
    savedThemes.add(preference);
  }

  @override
  Future<String?> getSpeechModel() async => speechModel;

  @override
  Future<void> setSpeechModel(String model) async {
    speechModel = model;
  }

  @override
  Future<PlaybackPreferences> getPlaybackPreferences() async {
    if (readFailure case final failure?) {
      throw failure;
    }
    return playback;
  }

  @override
  Future<void> setPlaybackPreferences(PlaybackPreferences preferences) async {
    if (writeFailure case final failure?) {
      throw failure;
    }
    playback = preferences;
    savedPlayback.add(preferences);
  }
}
