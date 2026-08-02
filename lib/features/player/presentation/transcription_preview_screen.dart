import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/presentation/formatters.dart';
import '../../library/domain/audiobook.dart';

class TranscriptionDraft {
  const TranscriptionDraft({
    required this.book,
    required this.text,
    required this.start,
    required this.end,
    required this.chapterStart,
    required this.chapterEnd,
    required this.chapterTitle,
  });

  final Audiobook book;
  final String text;
  final Duration start;
  final Duration end;
  final Duration chapterStart;
  final Duration chapterEnd;
  final String? chapterTitle;
}

class TranscriptionPreviewScreen extends StatefulWidget {
  const TranscriptionPreviewScreen({
    required this.draft,
    required this.onSave,
    super.key,
  });

  final TranscriptionDraft draft;
  final Future<void> Function(String text) onSave;

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
    return Scaffold(
      appBar: AppBar(title: const Text('Preview quote')),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 28),
          children: [
            Text(
              'Review and edit',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 6),
            Text(
              'Correct the local transcription before saving or sharing it.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  const Icon(Icons.menu_book_rounded),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          draft.chapterTitle ?? draft.book.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          '${formatDuration(draft.chapterStart)} – ${formatDuration(draft.chapterEnd)} in chapter',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            TextField(
              controller: _controller,
              minLines: 8,
              maxLines: null,
              textCapitalization: TextCapitalization.sentences,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                hintText: 'The transcription will appear here.',
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: hasText && !_saving ? _saveToNotes : null,
                    icon: _saving
                        ? const SizedBox.square(
                            dimension: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.bookmark_add_outlined),
                    label: const Text('Save to notes'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Builder(
                    builder: (buttonContext) => FilledButton.icon(
                      onPressed: hasText && !_saving
                          ? () => _share(buttonContext)
                          : null,
                      icon: const Icon(Icons.share_outlined),
                      label: const Text('Share'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveToNotes() async {
    setState(() => _saving = true);
    await widget.onSave(_controller.text.trim());
    if (!mounted) {
      return;
    }
    final messenger = ScaffoldMessenger.of(context);
    Navigator.pop(context);
    messenger.showSnackBar(
      const SnackBar(content: Text('Quote saved to notes.')),
    );
  }

  Future<void> _share(BuildContext buttonContext) async {
    final box = buttonContext.findRenderObject() as RenderBox?;
    final draft = widget.draft;
    final author = draft.book.author.trim();
    final attribution = author.isEmpty
        ? draft.book.title
        : '${draft.book.title} — $author';
    final location = [
      ?draft.chapterTitle,
      '${formatDuration(draft.chapterStart)}–${formatDuration(draft.chapterEnd)}',
    ].join(' · ');
    await SharePlus.instance.share(
      ShareParams(
        text: '${_controller.text.trim()}\n\n$location\n— $attribution',
        subject: 'Quote from ${draft.book.title}',
        sharePositionOrigin: box == null
            ? null
            : box.localToGlobal(Offset.zero) & box.size,
      ),
    );
  }
}
