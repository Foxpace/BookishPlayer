import 'package:flutter/material.dart';

import '../../../core/localization/generated/l10n.dart';
import '../../../core/presentation/bookish_scaffold.dart';
import '../../player/models/share_origin.dart';
import '../models/transcription_draft.dart';
import 'widgets/transcription_draft_context_card.dart';
import 'widgets/transcription_preview_actions.dart';

typedef SaveTranscribedQuote =
    Future<void> Function(String text, TranscriptionDraft draft);
typedef ShareTranscribedQuote =
    Future<void> Function(
      String text, {
      required String subject,
      ShareOrigin? origin,
    });

class TranscriptionPreviewScreen extends StatefulWidget {
  const TranscriptionPreviewScreen({
    required this.draft,
    required this.onSave,
    required this.onShare,
    super.key,
  });

  final TranscriptionDraft draft;
  final SaveTranscribedQuote onSave;
  final ShareTranscribedQuote onShare;

  @override
  State<TranscriptionPreviewScreen> createState() =>
      _TranscriptionPreviewScreenState();
}

class _TranscriptionPreviewScreenState
    extends State<TranscriptionPreviewScreen> {
  late final TextEditingController _controller;
  var _saving = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.draft.text);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final draft = widget.draft;
    final hasText = _controller.text.trim().isNotEmpty;
    return BookishScaffold(
      appBar: AppBar(title: Text(S.of(context).previewQuote)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 28),
        children: [
          Text(
            S.of(context).reviewAndEdit,
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 6),
          Text(
            S.of(context).reviewTranscriptionDescription,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 18),
          TranscriptionDraftContextCard(draft: draft),
          const SizedBox(height: 18),
          TextField(
            controller: _controller,
            minLines: 8,
            maxLines: null,
            textCapitalization: TextCapitalization.sentences,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              hintText: S.of(context).transcriptionPlaceholder,
              alignLabelWithHint: true,
            ),
          ),
          const SizedBox(height: 18),
          TranscriptionPreviewActions(
            enabled: hasText,
            saving: _saving,
            onSave: _saveToNotes,
            onShare: _share,
          ),
        ],
      ),
    );
  }

  Future<void> _saveToNotes() async {
    setState(() => _saving = true);
    final draft = widget.draft;
    await widget.onSave(_controller.text.trim(), draft);
    if (!mounted) {
      return;
    }
    final messenger = ScaffoldMessenger.of(context);
    Navigator.pop(context);
    messenger.showSnackBar(
      SnackBar(content: Text(S.of(context).quoteSavedToNotes)),
    );
  }

  Future<void> _share(BuildContext buttonContext) async {
    final box = buttonContext.findRenderObject() as RenderBox?;
    final rect = box == null ? null : box.localToGlobal(Offset.zero) & box.size;
    await widget.onShare(
      _controller.text,
      subject: S.of(context).quoteShareSubject(widget.draft.book.title),
      origin: rect == null
          ? null
          : ShareOrigin(
              x: rect.left,
              y: rect.top,
              width: rect.width,
              height: rect.height,
            ),
    );
  }
}
