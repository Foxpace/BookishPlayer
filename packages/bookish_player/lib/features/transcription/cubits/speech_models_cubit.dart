import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/presentation/app_message.dart';
import '../models/speech_model.dart';
import '../models/transcription_download.dart';
import '../use_cases/transcription_use_case_bundle.dart';
import 'transcription_cubits.dart';

@Environment('internal')
@injectable
class SpeechModelsCubit extends Cubit<SpeechModelsState> {
  SpeechModelsCubit(this._useCases) : super(const SpeechModelsState());

  final SpeechModelUseCases _useCases;

  Future<void> load() async {
    emit(state.copyWith(status: SpeechModelsStatus.loading, message: null));
    try {
      await _loadModelsAndEmit();
    } catch (_) {
      _emitModelsLoadFailure();
    }
  }

  Future<void> _loadModelsAndEmit() async {
    final selected = await _useCases.selectedModel() ?? 'whisper-tiny';
    final cachedModels = await _useCases.loadCachedModels();
    _emitCachedModels(cachedModels, selected);
    await _refreshModelsAndEmit(cachedModels);
  }

  void _emitCachedModels(List<SpeechModel> models, String selected) {
    emit(
      state.copyWith(
        status: SpeechModelsStatus.ready,
        models: models,
        selectedModel: _selectAvailableModel(models, selected),
      ),
    );
  }

  Future<void> _refreshModelsAndEmit(List<SpeechModel> cachedModels) async {
    final refreshedModels = await _useCases.refreshModels();
    if (isClosed || _haveSameModels(refreshedModels, cachedModels)) {
      return;
    }
    emit(
      state.copyWith(
        models: refreshedModels,
        selectedModel: _selectAvailableModel(
          refreshedModels,
          state.selectedModel,
        ),
      ),
    );
  }

  void _emitModelsLoadFailure() => emit(
    state.copyWith(
      status: SpeechModelsStatus.failure,
      message: AppMessage.speechModelsLoadFailed,
      effectRevision: state.effectRevision + 1,
    ),
  );

  String _selectAvailableModel(List<SpeechModel> models, String selected) {
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

  Future<void> selectModel(String slug) async {
    await _useCases.selectModel(slug);
    emit(state.copyWith(selectedModel: slug, message: null));
  }

  Future<bool> activateModel(SpeechModel model) async {
    await selectModel(model.slug);
    if (!model.isDownloaded) {
      await downloadSelectedModel();
    }
    return state.status == SpeechModelsStatus.ready;
  }

  Future<void> downloadSelectedModel() async {
    emit(
      state.copyWith(
        status: SpeechModelsStatus.downloading,
        downloadProgress: 0,
        message: null,
      ),
    );
    try {
      await _downloadSelectedModelAndEmit();
    } catch (_) {
      _emitModelDownloadFailure();
    }
  }

  Future<void> _downloadSelectedModelAndEmit() async {
    await _useCases.downloadModel(
      state.selectedModel,
      onProgress: _emitDownloadProgress,
    );

    final models = _markSelectedModelDownloaded();
    emit(
      state.copyWith(
        status: SpeechModelsStatus.ready,
        models: models,
        downloadProgress: null,
        message: AppMessage.speechModelDownloaded,
        effectRevision: state.effectRevision + 1,
      ),
    );
  }

  List<SpeechModel> _markSelectedModelDownloaded() => state.models
      .map(
        (model) => model.slug == state.selectedModel
            ? model.copyWith(isDownloaded: true)
            : model,
      )
      .toList();

  void _emitDownloadProgress(
    double? progress,
    TranscriptionDownloadPhase phase,
  ) {
    if (isClosed) {
      return;
    }

    final failed = phase == TranscriptionDownloadPhase.failure;
    emit(
      state.copyWith(
        status: failed
            ? SpeechModelsStatus.failure
            : SpeechModelsStatus.downloading,
        downloadProgress: progress,
        message: failed ? AppMessage.speechModelDownloadFailed : null,
        effectRevision: failed
            ? state.effectRevision + 1
            : state.effectRevision,
      ),
    );
  }

  void _emitModelDownloadFailure() => emit(
    state.copyWith(
      status: SpeechModelsStatus.failure,
      downloadProgress: null,
      message: AppMessage.speechModelDownloadFailed,
      effectRevision: state.effectRevision + 1,
    ),
  );
}
