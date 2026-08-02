import '../../library/domain/audiobook.dart';
import 'chapter_parse_report.dart';

abstract interface class M4bChapterParser {
  Future<List<AudioChapter>> parse(String filePath);
  Future<ChapterParseReport> analyze(String filePath);
}
