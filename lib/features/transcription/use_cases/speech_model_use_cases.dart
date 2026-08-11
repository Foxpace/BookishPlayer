import 'package:injectable/injectable.dart';

import '../repos/transcription_repositories.dart';
import 'refresh_speech_models_use_case.dart';
import 'read_selected_speech_model_use_case.dart';
import 'select_speech_model_use_case.dart';
import 'download_speech_model_use_case.dart';

part 'load_cached_speech_models_use_case.dart';

@injectable
class SpeechModelUseCases {
  const SpeechModelUseCases({
    required this.loadCachedModels,
    required this.refreshModels,
    required this.selectedModel,
    required this.selectModel,
    required this.downloadModel,
  });

  final LoadCachedSpeechModelsUseCase loadCachedModels;
  final RefreshSpeechModelsUseCase refreshModels;
  final ReadSelectedSpeechModelUseCase selectedModel;
  final SelectSpeechModelUseCase selectModel;
  final DownloadSpeechModelUseCase downloadModel;
}
