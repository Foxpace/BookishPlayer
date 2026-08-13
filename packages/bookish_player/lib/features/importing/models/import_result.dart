import 'package:freezed_annotation/freezed_annotation.dart';
import '../repos/import_repositories.dart';
part 'import_result.freezed.dart';

@freezed
abstract class ImportResult with _$ImportResult {
  const factory ImportResult({
    required List<SelectedAudioFile> selectedFiles,
    required int importedCount,
  }) = _ImportResult;
}
