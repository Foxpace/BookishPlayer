import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../core/foundation/result.dart';
import '../../../core/presentation/app_message.dart';
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
    final result = await _application.load();
    if (isClosed) {
      return;
    }
    switch (result) {
      case ResultSuccess(:final value):
        _emitCatalog(value);
      case ResultFailure():
        _emitFailure(AppMessage.speechModelsLoadFailed);
    }
  }

  Future<bool> selectModel(String slug) async {
    if (_busy ||
        !state.models.any(
          (model) => model.slug == slug && model.isDownloaded,
        )) {
      return false;
    }
    final result = await _application.select(slug);
    if (isClosed) {
      return false;
    }
    switch (result) {
      case ResultSuccess():
        emit(state.copyWith(selectedModel: slug, message: null));
        return true;
      case ResultFailure():
        _emitFailure(AppMessage.speechModelsLoadFailed);
        return false;
    }
  }

  Future<void> downloadModel(String slug) async {
    if (_busy ||
        !state.models.any(
          (model) => model.slug == slug && !model.isDownloaded,
        )) {
      return;
    }
    emit(
      state.copyWith(
        status: SpeechModelsStatus.downloading,
        workingModelSlug: slug,
        downloadProgress: null,
        message: null,
      ),
    );
    final result = await _application.download(
      slug,
      onProgress: _emitDownloadProgress,
    );
    if (isClosed) {
      return;
    }
    switch (result) {
      case ResultSuccess(:final value):
        emit(
          state.copyWith(
            status: SpeechModelsStatus.ready,
            models: value,
            workingModelSlug: null,
            downloadProgress: null,
            message: AppMessage.speechModelDownloaded,
            effectRevision: state.effectRevision + 1,
          ),
        );
      case ResultFailure():
        _emitFailure(AppMessage.speechModelDownloadFailed);
    }
  }

  Future<void> removeModel(String slug) async {
    if (_busy ||
        !state.models.any(
          (model) => model.slug == slug && model.isDownloaded,
        )) {
      return;
    }
    emit(
      state.copyWith(
        status: SpeechModelsStatus.removing,
        workingModelSlug: slug,
        message: null,
      ),
    );
    final result = await _application.remove(slug);
    if (isClosed) {
      return;
    }
    switch (result) {
      case ResultSuccess(:final value):
        _emitCatalog(value);
        emit(
          state.copyWith(
            message: AppMessage.speechModelRemoved,
            effectRevision: state.effectRevision + 1,
          ),
        );
      case ResultFailure():
        _emitFailure(AppMessage.speechModelRemoveFailed);
    }
  }

  bool get _busy =>
      state.status == SpeechModelsStatus.downloading ||
      state.status == SpeechModelsStatus.removing;

  void _emitCatalog(SpeechModelCatalog catalog) => emit(
    state.copyWith(
      status: SpeechModelsStatus.ready,
      models: catalog.models,
      selectedModel: catalog.selected,
      workingModelSlug: null,
      downloadProgress: null,
      message: null,
    ),
  );

  void _emitDownloadProgress(
    double? progress,
    TranscriptionDownloadPhase phase,
  ) {
    if (isClosed || phase != TranscriptionDownloadPhase.downloading) {
      return;
    }
    emit(state.copyWith(downloadProgress: progress));
  }

  void _emitFailure(AppMessage message) => emit(
    state.copyWith(
      status: SpeechModelsStatus.failure,
      workingModelSlug: null,
      downloadProgress: null,
      message: message,
      effectRevision: state.effectRevision + 1,
    ),
  );
}
