import 'package:freezed_annotation/freezed_annotation.dart';

import '../../library/domain/audiobook.dart';
import '../../settings/domain/playback_preferences.dart';

part 'playback_open_result.freezed.dart';

@freezed
abstract class PlaybackOpenResult with _$PlaybackOpenResult {
  const factory PlaybackOpenResult({
    required Audiobook book,
    required PlaybackPreferences preferences,
  }) = _PlaybackOpenResult;
}
