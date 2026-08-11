export 'transcription_exception.dart';

typedef TranscriptionDownloadProgress =
    void Function(double? progress, TranscriptionDownloadPhase phase);

enum TranscriptionDownloadPhase { downloading, failure }
