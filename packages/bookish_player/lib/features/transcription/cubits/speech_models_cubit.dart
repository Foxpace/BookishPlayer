import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/foundation/result.dart';
import '../../../core/presentation/app_message.dart';
import '../models/speech_model.dart';
import '../models/transcription_download.dart';
import '../use_cases/speech_model_application.dart';
import 'transcription_cubits.dart';

@Environment('internal')
@injectable
class SpeechModelsCubit extends Cubit<SpeechModelsState> {
  SpeechModelsCubit(this._application) : super(const SpeechModelsState());

  final SpeechModelApplication _application;

  Future<void> load() async {
    emit(state.copyWith(status: SpeechModelsStatus.loading, message: null));
    await _loadModelsAndEmit();
  }

  Future<void> _loadModelsAndEmit() async {
    switch (await _application.loadCached()) {
      case ResultSuccess(:final value):
        _emitCatalog(value);
        await _refreshModelsAndEmit(value);
      case ResultFailure():
        _emitModelsLoadFailure();
    }
  }

  void _emitCatalog(SpeechModelCatalog catalog) {
    emit(
      state.copyWith(
        status: SpeechModelsStatus.ready,
        models: catalog.models,
        selectedModel: catalog.selected,
      ),
    );
  }

  Future<void> _refreshModelsAndEmit(SpeechModelCatalog cached) async {
    switch (await _application.refresh(cached)) {
      case ResultSuccess(value: final refreshed?):
        if (!isClosed) {
          _emitCatalog(refreshed);
        }
      case ResultSuccess(value: null):
        return;
      case ResultFailure():
        _emitModelsLoadFailure();
    }
  }

  void _emitModelsLoadFailure() => emit(
    state.copyWith(
      status: SpeechModelsStatus.failure,
      message: AppMessage.speechModelsLoadFailed,
      effectRevision: state.effectRevision + 1,
    ),
  );

  Future<void> selectModel(String slug) async {
    switch (await _application.select(slug)) {
      case ResultSuccess():
        emit(state.copyWith(selectedModel: slug, message: null));
      case ResultFailure():
        _emitModelsLoadFailure();
    }
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
    await _downloadSelectedModelAndEmit();
  }

  Future<void> _downloadSelectedModelAndEmit() async {
    final result = await _application.download(
      state.selectedModel,
      onProgress: _emitDownloadProgress,
    );
    if (result case ResultFailure()) {
      _emitModelDownloadFailure();
      return;
    }

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
