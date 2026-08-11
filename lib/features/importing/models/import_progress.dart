import 'package:freezed_annotation/freezed_annotation.dart';

import '../repos/import_repositories.dart';

import 'import_stage.dart';
part 'import_progress.freezed.dart';

typedef ImportProgressCallback = void Function(ImportProgress progress);

@freezed
abstract class ImportProgress with _$ImportProgress {
  const factory ImportProgress({
    required ImportStage stage,
    SelectedAudioFile? selected,
    @Default(0) int index,
    @Default(0) int total,
    String? title,
    int? copiedBytes,
    int? totalBytes,
  }) = _ImportProgress;
}
