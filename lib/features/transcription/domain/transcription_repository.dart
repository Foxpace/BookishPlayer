// Provider progress callbacks conventionally expose the error flag positionally.
// ignore_for_file: avoid_positional_boolean_parameters

import '../../library/domain/audiobook.dart';

typedef TranscriptionDownloadProgress =
    void Function(double? progress, String status, bool isError);

class SpeechModel {
  const SpeechModel({
    required this.slug,
    required this.isDownloaded,
    this.sizeMb,
  });

  final String slug;
  final int? sizeMb;
  final bool isDownloaded;

  String get displayName => slug
      .split('-')
      .map(
        (part) => part.isEmpty
            ? part
            : '${part[0].toUpperCase()}${part.substring(1)}',
      )
      .join(' ');

  SpeechModel copyWith({bool? isDownloaded}) => SpeechModel(
    slug: slug,
    sizeMb: sizeMb,
    isDownloaded: isDownloaded ?? this.isDownloaded,
  );
}

class TranscriptionException implements Exception {
  const TranscriptionException(this.message);

  final String message;

  @override
  String toString() => message;
}

abstract interface class TranscriptionRepository {
  Future<List<SpeechModel>> getModels({bool refresh = true});

  Future<bool> isModelDownloaded(String slug);

  Future<void> downloadModel(
    String slug, {
    TranscriptionDownloadProgress? onProgress,
  });

  Future<String> transcribeRange({
    required Audiobook book,
    required Duration start,
    required Duration end,
    required String model,
  });
}
