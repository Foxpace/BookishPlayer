import 'package:intl/intl.dart';

String formatDuration(Duration duration) {
  final totalSeconds = duration.isNegative ? 0 : duration.inSeconds;
  final hours = totalSeconds ~/ 3600;
  final minutes = (totalSeconds % 3600) ~/ 60;
  final seconds = totalSeconds % 60;
  if (hours > 0) {
    return '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
  return '$minutes:${seconds.toString().padLeft(2, '0')}';
}

String formatDateTime(DateTime dateTime, String locale) =>
    DateFormat.yMMMd(locale).add_jm().format(dateTime.toLocal());

String formatRemaining(Duration position, Duration duration) {
  final remaining = duration - position;
  return '−${formatDuration(remaining.isNegative ? Duration.zero : remaining)}';
}
