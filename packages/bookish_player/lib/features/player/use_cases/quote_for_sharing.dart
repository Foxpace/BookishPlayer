import '../../library/models/library_models.dart';

String quoteForSharing({
  required Audiobook book,
  required String text,
  required String? chapterTitle,
  required Duration start,
  Duration? end,
  String? title,
}) {
  final author = book.author.trim();
  final attribution = author.isEmpty ? book.title : '${book.title} — $author';
  final time = end == null
      ? _formatDuration(start)
      : '${_formatDuration(start)}–${_formatDuration(end)}';
  final location = [?chapterTitle, time].join(' · ');
  final body = [
    if (title != null && title.trim().isNotEmpty) title.trim(),
    text.trim(),
  ].join('\n\n');
  return '$body\n\n$location\n— $attribution';
}

String _formatDuration(Duration value) {
  final hours = value.inHours;
  final minutes = value.inMinutes.remainder(60).toString().padLeft(2, '0');
  final seconds = value.inSeconds.remainder(60).toString().padLeft(2, '0');
  return hours > 0 ? '$hours:$minutes:$seconds' : '$minutes:$seconds';
}
