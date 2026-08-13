part of 'speech_model_use_cases.dart';

@Environment('internal')
@injectable
class LoadCachedSpeechModelsUseCase {
  const LoadCachedSpeechModelsUseCase(this._repository);

  final TranscriptionRepository _repository;

  Future<List<SpeechModel>> call() => _repository.getModels(refresh: false);
}
