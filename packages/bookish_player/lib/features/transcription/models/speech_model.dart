import 'package:freezed_annotation/freezed_annotation.dart';

part 'speech_model.freezed.dart';

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
