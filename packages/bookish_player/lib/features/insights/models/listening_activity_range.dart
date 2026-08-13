import 'package:freezed_annotation/freezed_annotation.dart';
import 'listening_activity.dart';
part 'listening_activity_range.freezed.dart';

@freezed
abstract class ListeningActivityRange with _$ListeningActivityRange {
  const factory ListeningActivityRange({
    required Duration totalListening,
    required List<ListeningActivityBucket> buckets,
  }) = _ListeningActivityRange;
}
