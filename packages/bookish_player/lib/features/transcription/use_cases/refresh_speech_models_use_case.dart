import 'package:injectable/injectable.dart';

import '../repos/transcription_repositories.dart';

@Environment('internal')
@injectable
class RefreshSpeechModelsUseCase {
  const RefreshSpeechModelsUseCase(this._repository);

  final TranscriptionRepository _repository;

  Future<List<SpeechModel>> call() => _repository.getModels();
}
