import 'package:injectable/injectable.dart';


import '../models/transcription_download.dart';

import '../repos/transcription_repository.dart';

@Environment('internal')
@injectable
class DownloadSpeechModelUseCase {
  const DownloadSpeechModelUseCase(this._repository);

  final TranscriptionRepository _repository;

  Future<void> call(String slug, {TranscriptionDownloadProgress? onProgress}) =>
      _repository.downloadModel(slug, onProgress: onProgress);
}
