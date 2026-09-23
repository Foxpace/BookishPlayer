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

  Future<Result<SpeechModelCatalog>> load() async {
    try {
      return await _load();
    } catch (error) {
      return Result.failure(
        AppFailure.operationFailed('transcription.models.load', error: error),
      );
    }
  }

  Future<Result<SpeechModelCatalog>> _load() async {
    final (selected, models) = await (
      _preferences.getSelectedModel(),
      _repository.listModels(),
    ).wait;
    return Result.success((
      models: models,
      selected: _selectAvailable(models, selected ?? 'whisper-base'),
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
    return models.isEmpty ? 'whisper-base' : models.first.slug;
  }
}
