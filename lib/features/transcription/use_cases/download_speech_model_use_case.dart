import 'package:injectable/injectable.dart';
import '../repos/transcription_repositories.dart';

@injectable
class DownloadSpeechModelUseCase {
  const DownloadSpeechModelUseCase(this._repository);

  final TranscriptionRepository _repository;

  Future<void> call(String slug, {TranscriptionDownloadProgress? onProgress}) =>
      _repository.downloadModel(slug, onProgress: onProgress);
}
