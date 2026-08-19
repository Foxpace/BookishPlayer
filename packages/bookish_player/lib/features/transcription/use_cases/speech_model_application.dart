import 'package:injectable/injectable.dart';

import '../models/speech_model.dart';
import '../models/transcription_download.dart';
import '../repos/transcription_preferences.dart';
import '../repos/transcription_repository.dart';

typedef SpeechModelCatalog = ({List<SpeechModel> models, String selected});

@Environment('internal')
@injectable
class SpeechModelApplication {
  const SpeechModelApplication(this._repository, this._preferences);

  final TranscriptionRepository _repository;
  final TranscriptionPreferences _preferences;

  Future<SpeechModelCatalog> loadCached() async {
    final (selected, models) = await (
      _preferences.getSelectedModel(),
      _repository.getModels(refresh: false),
    ).wait;
    return (
      models: models,
      selected: _selectAvailable(models, selected ?? 'whisper-tiny'),
    );
  }

  Future<SpeechModelCatalog?> refresh(SpeechModelCatalog current) async {
    final models = await _repository.getModels();
    if (_haveSameModels(models, current.models)) {
      return null;
    }
    return (
      models: models,
      selected: _selectAvailable(models, current.selected),
    );
  }

  Future<void> select(String slug) => _preferences.setSelectedModel(slug);

  Future<void> download(
    String slug, {
    TranscriptionDownloadProgress? onProgress,
  }) => _repository.downloadModel(slug, onProgress: onProgress);

  String _selectAvailable(List<SpeechModel> models, String selected) {
    if (models.any((model) => model.slug == selected)) {
      return selected;
    }
    return models.isEmpty ? 'whisper-tiny' : models.first.slug;
  }

  bool _haveSameModels(List<SpeechModel> left, List<SpeechModel> right) {
    if (left.length != right.length) {
      return false;
    }
    for (var index = 0; index < left.length; index++) {
      final leftModel = left[index];
      final rightModel = right[index];
      if (leftModel.slug != rightModel.slug ||
          leftModel.sizeMb != rightModel.sizeMb ||
          leftModel.isDownloaded != rightModel.isDownloaded) {
        return false;
      }
    }
    return true;
  }
}
