import 'package:flutter/material.dart';

import '../../../core/localization/generated/l10n.dart';
import '../../../core/presentation/bookish_scaffold.dart';
import '../cubits/transcription_preview_state.dart';
import '../cubits/transcription_preview_status.dart';
import 'widgets/transcription_draft_context_card.dart';
import 'widgets/transcription_preview_actions.dart';

class TranscriptionPreviewScreen extends StatefulWidget {
  const TranscriptionPreviewScreen({
    required this.state,
    required this.onEdit,
    required this.onSave,
    required this.onSaveAndShare,
    super.key,
  });

  final TranscriptionPreviewState state;
  final ValueChanged<String> onEdit;
  final VoidCallback onSave;
  final ValueChanged<BuildContext> onSaveAndShare;

  @override
  State<TranscriptionPreviewScreen> createState() =>
      _TranscriptionPreviewScreenState();
}

class _TranscriptionPreviewScreenState
    extends State<TranscriptionPreviewScreen> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.state.text);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final busy = widget.state.status != TranscriptionPreviewStatus.ready;
    return BookishScaffold(
      appBar: AppBar(title: Text(S.of(context).previewQuote)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 28),
        children: [
          Text(
            S.of(context).reviewTranscriptionDescription,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 18),
          TranscriptionDraftContextCard(draft: widget.state.draft),
          const SizedBox(height: 18),
          TextField(
            controller: _controller,
            minLines: 8,
            maxLines: null,
            enabled: !busy,
            textCapitalization: TextCapitalization.sentences,
            onChanged: widget.onEdit,
            decoration: InputDecoration(
              hintText: S.of(context).transcriptionPlaceholder,
              alignLabelWithHint: true,
            ),
          ),
          const SizedBox(height: 18),
          TranscriptionPreviewActions(
            enabled: widget.state.text.trim().isNotEmpty,
            saving: busy,
            onSave: widget.onSave,
            onShare: widget.onSaveAndShare,
          ),
        ],
      ),
    );
  }
}
