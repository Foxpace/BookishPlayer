import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

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
    try {
      await _loadModelsAndEmit();
    } catch (_) {
      _emitModelsLoadFailure();
    }
  }

  Future<void> _loadModelsAndEmit() async {
    final cached = await _application.loadCached();
    _emitCatalog(cached);
    await _refreshModelsAndEmit(cached);
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
    final refreshed = await _application.refresh(cached);
    if (isClosed || refreshed == null) {
      return;
    }
    _emitCatalog(refreshed);
  }

  void _emitModelsLoadFailure() => emit(
    state.copyWith(
      status: SpeechModelsStatus.failure,
      message: AppMessage.speechModelsLoadFailed,
      effectRevision: state.effectRevision + 1,
    ),
  );

  Future<void> selectModel(String slug) async {
    await _application.select(slug);
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
    await _application.download(
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
