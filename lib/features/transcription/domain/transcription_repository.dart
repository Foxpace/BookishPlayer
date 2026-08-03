// Provider progress callbacks conventionally expose the error flag positionally.
// ignore_for_file: avoid_positional_boolean_parameters

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../library/domain/audiobook.dart';

part 'transcription_repository.freezed.dart';

typedef TranscriptionDownloadProgress =
    void Function(double? progress, String status, bool isError);

@freezed
abstract class SpeechModel with _$SpeechModel {
  const SpeechModel._();

  const factory SpeechModel({
    required String slug,
    required bool isDownloaded,
    int? sizeMb,
  }) = _SpeechModel;

  String get displayName => slug
      .split('-')
      .map(
        (part) => part.isEmpty
            ? part
            : '${part[0].toUpperCase()}${part.substring(1)}',
      )
      .join(' ');
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
