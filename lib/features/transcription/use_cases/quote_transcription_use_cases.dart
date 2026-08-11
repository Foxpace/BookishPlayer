import 'package:injectable/injectable.dart';

import '../../library/models/library_models.dart';
import '../repos/transcription_preferences.dart';
import '../repos/transcription_repositories.dart';
import 'share_transcription_draft_use_case.dart';

part 'transcribe_quote_use_case.dart';

@injectable
class QuoteTranscriptionUseCases {
  const QuoteTranscriptionUseCases(this.transcribe, this.shareDraft);

  final TranscribeQuoteUseCase transcribe;
  final ShareTranscriptionDraftUseCase shareDraft;
}
