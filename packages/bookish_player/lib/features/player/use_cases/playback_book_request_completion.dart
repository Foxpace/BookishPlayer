part of 'playback_command_service.dart';

extension PlaybackBookRequestCompletion on PlaybackBookRequest {
  void completeWith(Future<void> operation) => completion.complete(operation);
}
