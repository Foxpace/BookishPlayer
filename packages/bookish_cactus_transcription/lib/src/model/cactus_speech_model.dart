import 'package:freezed_annotation/freezed_annotation.dart';

part 'cactus_speech_model.freezed.dart';

@freezed
abstract class CactusSpeechModel with _$CactusSpeechModel {
  const factory CactusSpeechModel({
    required String slug,
    required bool isDownloaded,
    int? sizeMb,
  }) = _CactusSpeechModel;
}
