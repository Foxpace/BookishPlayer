import 'package:freezed_annotation/freezed_annotation.dart';

import '../../library/models/library_models.dart';

part 'chapter_parse_report.freezed.dart';

@freezed
abstract class ChapterParseReport with _$ChapterParseReport {
  const factory ChapterParseReport({
    @Default(<AudioChapter>[]) List<AudioChapter> chapters,
    @Default(<String>[]) List<String> diagnostics,
    @Default(<String>[]) List<String> warnings,
  }) = _ChapterParseReport;
}
