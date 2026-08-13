import 'package:freezed_annotation/freezed_annotation.dart';

part 'listening_session.freezed.dart';
part 'listening_session.g.dart';

@freezed
abstract class ListeningSession with _$ListeningSession {
  const factory ListeningSession({
    required String id,
    required DateTime startedAt,
    required DateTime endedAt,
    required int listenedMs,
    required int startPositionMs,
    required int endPositionMs,
    required double speed,
    required String metadataId,
  }) = _ListeningSession;

  factory ListeningSession.fromJson(Map<String, dynamic> json) =>
      _$ListeningSessionFromJson(json);
}
