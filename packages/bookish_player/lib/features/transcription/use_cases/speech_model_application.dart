import 'package:injectable/injectable.dart';

import '../../../core/foundation/result.dart';
import '../models/speech_model.dart';
import '../models/transcription_failure.dart';
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

  Future<Result<SpeechModelCatalog, TranscriptionFailure>> loadCached() async {
    try {
      final (selected, models) = await (
        _preferences.getSelectedModel(),
        _repository.getModels(refresh: false),
      ).wait;
      return Result.success((
        models: models,
        selected: _selectAvailable(models, selected ?? 'whisper-tiny'),
      ));
    } catch (_) {
      return const Result.failure(TranscriptionFailure.loadModels);
    }
  }

  Future<Result<SpeechModelCatalog?, TranscriptionFailure>> refresh(
    SpeechModelCatalog current,
  ) async {
    try {
      final models = await _repository.getModels();
      if (_haveSameModels(models, current.models)) {
        return const Result.success(null);
      }
      return Result.success((
        models: models,
        selected: _selectAvailable(models, current.selected),
      ));
    } catch (_) {
      return const Result.failure(TranscriptionFailure.refreshModels);
    }
  }

  Future<Result<bool, TranscriptionFailure>> select(String slug) async {
    try {
      await _preferences.setSelectedModel(slug);
      return const Result.success(true);
    } catch (_) {
      return const Result.failure(TranscriptionFailure.selectModel);
    }
  }

  Future<Result<bool, TranscriptionFailure>> download(
    String slug, {
    TranscriptionDownloadProgress? onProgress,
  }) async {
    try {
      await _repository.downloadModel(slug, onProgress: onProgress);
      return const Result.success(true);
    } catch (_) {
      return const Result.failure(TranscriptionFailure.downloadModel);
    }
  }

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
