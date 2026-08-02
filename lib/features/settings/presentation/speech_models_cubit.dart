import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../transcription/domain/transcription_repository.dart';
import '../data/settings_dao.dart';

enum SpeechModelsStatus { initial, loading, ready, downloading, failure }

class SpeechModelsState {
  const SpeechModelsState({
    this.status = SpeechModelsStatus.initial,
    this.models = const [],
    this.selectedModel = 'whisper-tiny',
    this.downloadProgress,
    this.statusMessage,
    this.message,
  });

  final SpeechModelsStatus status;
  final List<SpeechModel> models;
  final String selectedModel;
  final double? downloadProgress;
  final String? statusMessage;
  final String? message;

  bool get selectedModelIsDownloaded =>
      models.any((model) => model.slug == selectedModel && model.isDownloaded);

  SpeechModelsState copyWith({
    SpeechModelsStatus? status,
    List<SpeechModel>? models,
    String? selectedModel,
    double? downloadProgress,
    bool clearDownloadProgress = false,
    String? statusMessage,
    bool clearStatusMessage = false,
    String? message,
    bool clearMessage = false,
  }) => SpeechModelsState(
    status: status ?? this.status,
    models: models ?? this.models,
    selectedModel: selectedModel ?? this.selectedModel,
    downloadProgress: clearDownloadProgress
        ? null
        : downloadProgress ?? this.downloadProgress,
    statusMessage: clearStatusMessage
        ? null
        : statusMessage ?? this.statusMessage,
    message: clearMessage ? null : message ?? this.message,
  );
}

@injectable
class SpeechModelsCubit extends Cubit<SpeechModelsState> {
  SpeechModelsCubit(this._transcription, this._settings)
    : super(const SpeechModelsState());

  final TranscriptionRepository _transcription;
  final SettingsDao _settings;

  Future<void> load() async {
    emit(
      state.copyWith(status: SpeechModelsStatus.loading, clearMessage: true),
    );
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
    } catch (_) {
      emit(
        state.copyWith(
          status: SpeechModelsStatus.failure,
          message: 'Could not load speech models.',
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
    emit(state.copyWith(selectedModel: slug, clearMessage: true));
  }

  Future<void> downloadSelectedModel() async {
    emit(
      state.copyWith(
        status: SpeechModelsStatus.downloading,
        downloadProgress: 0,
        statusMessage: 'Starting download…',
        clearMessage: true,
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
          clearDownloadProgress: true,
          clearStatusMessage: true,
          message: 'Speech model downloaded and ready.',
        ),
      );
    } catch (_) {
      emit(
        state.copyWith(
          status: SpeechModelsStatus.failure,
          clearDownloadProgress: true,
          clearStatusMessage: true,
          message: 'Could not download the speech model.',
        ),
      );
    }
  }
}
