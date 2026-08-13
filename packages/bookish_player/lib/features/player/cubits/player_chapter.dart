import 'package:freezed_annotation/freezed_annotation.dart';
part 'player_chapter.freezed.dart';

@freezed
abstract class PlayerChapter with _$PlayerChapter {
  const factory PlayerChapter({
    required int index,
    required String title,
    required Duration start,
    required Duration duration,
  }) = _PlayerChapter;
}
