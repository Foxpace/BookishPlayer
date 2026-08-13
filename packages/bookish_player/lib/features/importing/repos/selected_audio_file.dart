import 'package:freezed_annotation/freezed_annotation.dart';
part 'selected_audio_file.freezed.dart';

@freezed
abstract class SelectedAudioFile with _$SelectedAudioFile {
  const factory SelectedAudioFile({
    required String sourcePath,
    required String displayName,
    int? sizeBytes,
  }) = _SelectedAudioFile;
}
