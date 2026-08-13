import 'audiobook.dart';
import 'audio_track.dart';
import 'listening_status.dart';

extension AudiobookProgress on Audiobook {
  ListeningStatus get listeningStatus {
    if (completedAt != null) {
      return ListeningStatus.finished;
    }
    if (statusOverride case final override?) {
      return override;
    }
    if (positionMs <= 0) {
      return ListeningStatus.notStarted;
    }
    if (durationMs > 0 && positionMs >= durationMs - 30000) {
      return ListeningStatus.finished;
    }
    return ListeningStatus.inProgress;
  }

  bool get isFinished => listeningStatus == ListeningStatus.finished;

  Duration get remainingDuration {
    final remainingMs = (durationMs - positionMs).clamp(0, durationMs);
    return Duration(milliseconds: remainingMs);
  }

  List<AudioTrack> get playableTracks =>
      tracks.isEmpty
            ? [
                AudioTrack(
                  id: id,
                  title: title,
                  filePath: filePath,
                  durationMs: durationMs,
                  order: 0,
                ),
              ]
            : [...tracks]
        ..sort((a, b) => a.order.compareTo(b.order));

  Audiobook markCompleted({required Duration position, required DateTime at}) =>
      copyWith(
        positionMs: position.inMilliseconds,
        lastPlayedAt: at,
        statusOverride: null,
        completedAt: at,
      );

  Audiobook withScannedArtwork(String? path) =>
      copyWith(artworkPath: path, artworkScanned: true);
}
