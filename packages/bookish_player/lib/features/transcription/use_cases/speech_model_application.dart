import 'package:injectable/injectable.dart';

import '../../../core/foundation/result.dart';
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

  Future<Result<SpeechModelCatalog>> loadCached() async {
    try {
      return await _loadCached();
    } catch (error) {
      return Result.failure(
        AppFailure.operationFailed('transcription.models.load', error: error),
      );
    }
  }

  Future<Result<SpeechModelCatalog>> _loadCached() async {
    final (selected, models) = await (
      _preferences.getSelectedModel(),
      _repository.getModels(refresh: false),
    ).wait;
    return Result.success((
      models: models,
      selected: _selectAvailable(models, selected ?? 'whisper-tiny'),
    ));
  }

  Future<Result<SpeechModelCatalog?>> refresh(
    SpeechModelCatalog current,
  ) async {
    try {
      return await _refresh(current);
    } catch (error) {
      return Result.failure(
        AppFailure.operationFailed(
          'transcription.models.refresh',
          error: error,
        ),
      );
    }
  }

  Future<Result<SpeechModelCatalog?>> _refresh(
    SpeechModelCatalog current,
  ) async {
    final models = await _repository.getModels();

    if (_haveSameModels(models, current.models)) {
      return const Result.success(null);
    }

    return Result.success((
      models: models,
      selected: _selectAvailable(models, current.selected),
    ));
  }

  Future<Result<bool>> select(String slug) async {
    try {
      return await _select(slug);
    } catch (error) {
      return Result.failure(
        AppFailure.operationFailed('transcription.model.select', error: error),
      );
    }
  }

  Future<Result<bool>> _select(String slug) async {
    await _preferences.setSelectedModel(slug);
    return const Result.success(true);
  }

  Future<Result<bool>> download(
    String slug, {
    TranscriptionDownloadProgress? onProgress,
  }) async {
    try {
      return await _download(slug, onProgress);
    } catch (error) {
      return Result.failure(
        AppFailure.operationFailed(
          'transcription.model.download',
          error: error,
        ),
      );
    }
  }

  Future<Result<bool>> _download(
    String slug,
    TranscriptionDownloadProgress? onProgress,
  ) async {
    await _repository.downloadModel(slug, onProgress: onProgress);
    return const Result.success(true);
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
