import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';
import '../../../../core/presentation/formatters.dart';
import '../../models/library_models.dart';

class BookProgressSummary extends StatelessWidget {
  const BookProgressSummary({
    required this.book,
    this.singleLine = false,
    super.key,
  });

  final Audiobook book;
  final bool singleLine;

  @override
  Widget build(BuildContext context) {
    final progress = book.durationMs == 0
        ? 0.0
        : (book.positionMs / book.durationMs).clamp(0.0, 1.0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 5,
            backgroundColor: Theme.of(
              context,
            ).progressIndicatorTheme.linearTrackColor,
          ),
        ),
        const SizedBox(height: 7),
        Text(
          _progressLabel(context, progress),
          maxLines: singleLine ? 1 : null,
          overflow: singleLine ? TextOverflow.ellipsis : null,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  String _progressLabel(BuildContext context, double progress) {
    if (book.isFinished) {
      return S.of(context).finishedBook;
    }
    if (book.positionMs > 0) {
      return '${(progress * 100).round()}% · '
          '${formatDuration(book.remainingDuration)} left';
    }
    return formatDuration(Duration(milliseconds: book.durationMs));
  }
}
