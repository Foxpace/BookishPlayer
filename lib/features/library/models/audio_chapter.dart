import 'package:freezed_annotation/freezed_annotation.dart';
part 'audio_chapter.freezed.dart';
part 'audio_chapter.g.dart';

@freezed
abstract class AudioChapter with _$AudioChapter {
  const factory AudioChapter({required String title, required int startMs}) =
      _AudioChapter;

  factory AudioChapter.fromJson(Map<String, dynamic> json) =>
      _$AudioChapterFromJson(json);
}
