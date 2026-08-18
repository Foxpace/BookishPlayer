import 'package:injectable/injectable.dart';

import '../../player/models/share_origin.dart';

import '../../player/repos/quote_share_repository.dart';
import '../models/transcription_draft.dart';

@Environment('internal')
@injectable
class ShareTranscriptionDraftUseCase {
  const ShareTranscriptionDraftUseCase(this._sharing);

  final QuoteShareRepository _sharing;

  Future<void> call(
    TranscriptionDraft draft,
    String text, {
    required String subject,
    ShareOrigin? origin,
  }) async {
    if (text.trim().isEmpty) {
      return;
    }

    final author = draft.book.author.trim();
    final attribution = author.isEmpty
        ? draft.book.title
        : '${draft.book.title} — $author';

    final location = [
      ?draft.chapterTitle,
      '${_formatDuration(draft.chapterStart)}–${_formatDuration(draft.chapterEnd)}',
    ].join(' · ');

    await _sharing.share(
      text: '${text.trim()}\n\n$location\n— $attribution',
      subject: subject,
      origin: origin,
    );
  }

  String _formatDuration(Duration value) {
    final hours = value.inHours;
    final minutes = value.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = value.inSeconds.remainder(60).toString().padLeft(2, '0');
    return hours > 0 ? '$hours:$minutes:$seconds' : '$minutes:$seconds';
  }
}
