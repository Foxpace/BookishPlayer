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
    if (!await _repository.isModelDownloaded(slug)) {
      return const Result.failure(
        AppFailure.notFound('transcription.model.downloaded'),
      );
    }
    await _preferences.setSelectedModel(slug);
    return const Result.success(true);
  }

  Future<Result<List<SpeechModel>>> download(
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

  Future<Result<List<SpeechModel>>> _download(
    String slug,
    TranscriptionDownloadProgress? onProgress,
  ) async {
    await _repository.downloadModel(slug, onProgress: onProgress);
    return Result.success(await _repository.listModels());
  }

  Future<Result<SpeechModelCatalog>> remove(String slug) async {
    try {
      await _repository.removeModel(slug);
      final catalog = await _load();
      if (catalog case ResultSuccess(:final value)) {
        final saved = await _preferences.getSelectedModel();
        if (saved != value.selected) {
          await _preferences.setSelectedModel(value.selected);
        }
      }
      return catalog;
    } catch (error) {
      return Result.failure(
        AppFailure.operationFailed('transcription.model.remove', error: error),
      );
    }
  }

  String _selectAvailable(List<SpeechModel> models, String selected) {
    if (models.any((model) => model.slug == selected && model.isDownloaded)) {
      return selected;
    }
    for (final model in models) {
      if (model.isDownloaded) {
        return model.slug;
      }
    }
    return models.isEmpty ? 'whisper-base' : models.first.slug;
  }
}
