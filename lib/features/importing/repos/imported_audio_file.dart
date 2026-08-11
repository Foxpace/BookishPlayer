part of 'file_import_repository.dart';

@freezed
abstract class ImportedAudioFile with _$ImportedAudioFile {
  const factory ImportedAudioFile({
    required String path,
    required String displayName,
  }) = _ImportedAudioFile;
}
