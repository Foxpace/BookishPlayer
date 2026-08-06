import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/presentation/diagnostic_failure.dart';
import '../../transcription/domain/transcription_repository.dart';
import '../domain/settings_repository.dart';
import 'speech_models_state.dart';

@injectable
class SpeechModelsCubit extends Cubit<SpeechModelsState> {
  SpeechModelsCubit(this._transcription, this._settings)
    : super(const SpeechModelsState());

  final TranscriptionRepository _transcription;
  final SettingsRepository _settings;

  Future<void> load() async {
    emit(state.copyWith(status: SpeechModelsStatus.loading, message: null));
    try {
      final selected = await _settings.getSpeechModel() ?? 'whisper-tiny';
      final cachedModels = await _transcription.getModels(refresh: false);
      final availableSelection = _availableSelection(cachedModels, selected);
      emit(
        state.copyWith(
          status: SpeechModelsStatus.ready,
          models: cachedModels,
          selectedModel: availableSelection,
        ),
      );

      final refreshedModels = await _transcription.getModels();
      if (isClosed || _sameModels(refreshedModels, cachedModels)) {
        return;
      }
      emit(
        state.copyWith(
          models: refreshedModels,
          selectedModel: _availableSelection(
            refreshedModels,
            state.selectedModel,
          ),
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: SpeechModelsStatus.failure,
          message: diagnosticFailureMessage(
            'Could not load speech models.',
            error,
          ),
        ),
      );
    }
  }

  String _availableSelection(List<SpeechModel> models, String selected) {
    if (models.any((model) => model.slug == selected)) {
      return selected;
    }
    return models.isEmpty ? 'whisper-tiny' : models.first.slug;
  }

  bool _sameModels(List<SpeechModel> left, List<SpeechModel> right) {
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

  Future<void> selectModel(String slug) async {
    await _settings.setSpeechModel(slug);
    emit(state.copyWith(selectedModel: slug, message: null));
  }

  Future<void> downloadSelectedModel() async {
    emit(
      state.copyWith(
        status: SpeechModelsStatus.downloading,
        downloadProgress: 0,
        statusMessage: 'Starting download…',
        message: null,
      ),
    );
    try {
      await _transcription.downloadModel(
        state.selectedModel,
        onProgress: (progress, status, isError) {
          if (isClosed) {
            return;
          }
          emit(
            state.copyWith(
              status: isError
                  ? SpeechModelsStatus.failure
                  : SpeechModelsStatus.downloading,
              downloadProgress: progress,
              statusMessage: status,
              message: isError ? status : null,
            ),
          );
        },
      );
      final models = state.models
          .map(
            (model) => model.slug == state.selectedModel
                ? model.copyWith(isDownloaded: true)
                : model,
          )
          .toList();
      emit(
        state.copyWith(
          status: SpeechModelsStatus.ready,
          models: models,
          downloadProgress: null,
          statusMessage: null,
          message: 'Speech model downloaded and ready.',
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          status: SpeechModelsStatus.failure,
          downloadProgress: null,
          statusMessage: null,
          message: diagnosticFailureMessage(
            'Could not download the speech model.',
            error,
          ),
        ),
      );
    }
  }
}
