part of 'library_use_cases.dart';

@injectable
class SaveLibraryLayoutUseCase {
  const SaveLibraryLayoutUseCase(this._settings);

  final SettingsRepository _settings;

  Future<void> call(String layout) => _settings.setLibraryLayout(layout);
}
