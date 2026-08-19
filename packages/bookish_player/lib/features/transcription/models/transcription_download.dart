typedef TranscriptionDownloadProgress =
    void Function(double? progress, TranscriptionDownloadPhase phase);

enum TranscriptionDownloadPhase { downloading, failure }
