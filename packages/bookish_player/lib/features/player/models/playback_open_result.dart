import 'package:freezed_annotation/freezed_annotation.dart';

import '../../library/models/library_models.dart';
import '../../settings/models/playback_preferences.dart';

part 'playback_open_result.freezed.dart';

@freezed
abstract class PlaybackOpenResult with _$PlaybackOpenResult {
  const factory PlaybackOpenResult({
    required Audiobook book,
    required PlaybackPreferences preferences,
  }) = _PlaybackOpenResult;
}
