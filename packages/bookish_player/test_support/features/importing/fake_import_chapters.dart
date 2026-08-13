import 'package:bookish_player/features/importing/models/chapter_parse_report.dart';
import 'package:bookish_player/features/importing/repos/m4b_chapter_parser.dart';
import 'package:bookish_player/features/library/models/library_models.dart';

class FakeImportChapters implements M4bChapterParser {
  @override
  Future<ChapterParseReport> analyze(String filePath) async =>
      const ChapterParseReport();
  @override
  Future<List<AudioChapter>> parse(String filePath) async => const [];
}
