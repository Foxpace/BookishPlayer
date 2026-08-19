import '../../library/models/audiobook.dart';

typedef PlayerPlaybackContext = ({
  Audiobook? book,
  Duration position,
  Duration duration,
  Duration chapterStart,
  double speed,
});
