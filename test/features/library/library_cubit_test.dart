import 'package:bookish_player/features/importing/domain/audiobook_artwork_extractor.dart';
import 'package:bookish_player/features/importing/domain/file_import_repository.dart';
import 'package:bookish_player/features/library/domain/audiobook_repository.dart';
import 'package:bookish_player/features/library/presentation/library_cubit.dart';
import 'package:bookish_player/features/library/presentation/library_state.dart';
import 'package:bookish_player/features/settings/domain/settings_repository.dart';
import 'package:bookish_player/features/settings/domain/theme_preference.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('library layout is an intent-backed persisted state value', () async {
    final settings = _Settings();
    final cubit = LibraryCubit(_Books(), _Files(), _Artwork(), settings);
    addTearDown(cubit.close);

    await cubit.setLayout(LibraryLayout.grid);

    expect(cubit.state.layout, LibraryLayout.grid);
    expect(settings.layout, 'grid');
  });
}

class _Settings implements SettingsRepository {
  String? layout;

  @override
  Future<String?> getLibraryLayout() async => layout;

  @override
  Future<void> setLibraryLayout(String layout) async {
    this.layout = layout;
  }

  @override
  Future<ThemePreference> getThemePreference() async => ThemePreference.system;

  @override
  Future<void> setThemePreference(ThemePreference preference) async {}

  @override
  Future<String?> getSpeechModel() async => null;

  @override
  Future<void> setSpeechModel(String model) async {}
}

class _Books implements AudiobookRepository {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Files implements FileImportRepository {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Artwork implements AudiobookArtworkExtractor {
  @override
  Future<String?> extract(String audioFilePath) async => null;
}
