import 'package:injectable/injectable.dart';

import '../models/speech_model.dart';


import '../repos/transcription_repository.dart';

@Environment('internal')
@injectable
class RefreshSpeechModelsUseCase {
  const RefreshSpeechModelsUseCase(this._repository);

  final TranscriptionRepository _repository;

  Future<List<SpeechModel>> call() => _repository.getModels();
}
