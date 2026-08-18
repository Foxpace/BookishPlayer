import 'package:flutter/material.dart';

import '../../../core/localization/generated/l10n.dart';
import '../../../core/presentation/bookish_scaffold.dart';
import '../../../core/presentation/formatters.dart';
import '../../player/models/share_origin.dart';
import '../models/book_note.dart';

typedef SaveNoteCallback =
    Future<void> Function({required String? title, required String text});
typedef ShareNoteCallback =
    Future<void> Function(BookNote note, {ShareOrigin? origin});

class NoteDetailScreen extends StatefulWidget {
  const NoteDetailScreen({
    required this.note,
    required this.onSave,
    this.onShare,
    super.key,
  });

  final BookNote note;
  final SaveNoteCallback onSave;
  final ShareNoteCallback? onShare;

  @override
  State<NoteDetailScreen> createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  late final TextEditingController _titleController;
  late final TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _textController = TextEditingController(text: widget.note.text);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _textController.dispose();
    super.dispose();
  }

  BookNote get _editedNote => widget.note.copyWith(
    title: _titleController.text.trim().isEmpty
        ? null
        : _titleController.text.trim(),
    text: _textController.text.trim(),
  );

  Future<void> _saveNote() async {
    final note = _editedNote;
    if (note.text.isEmpty) {
      return;
    }
    await widget.onSave(title: note.title, text: note.text);
    if (mounted) {
      Navigator.pop(context);
    }
  }

  Future<void> _share(BuildContext buttonContext) async {
    final share = widget.onShare;
    if (share == null) {
      return;
    }
    final box = buttonContext.findRenderObject() as RenderBox?;
    final rect = box == null ? null : box.localToGlobal(Offset.zero) & box.size;
    await share(
      _editedNote,
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

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    return BookishScaffold(
      appBar: AppBar(
        title: Text(S.of(context).noteTitle),
        actions: [
          if (widget.onShare != null)
            Builder(
              builder: (buttonContext) => IconButton(
                tooltip: S.of(context).shareNote,
                onPressed: () => _share(buttonContext),
                icon: const Icon(Icons.share_rounded),
              ),
            ),
          TextButton(onPressed: _saveNote, child: Text(S.of(context).save)),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
        children: [
          TextField(
            controller: _titleController,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(labelText: S.of(context).optionalTitle),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _textController,
            minLines: 8,
            maxLines: null,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              labelText: S.of(context).noteTitle,
              alignLabelWithHint: true,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            [
              ?widget.note.chapterTitle,
              formatDuration(Duration(milliseconds: widget.note.positionMs)),
              formatDateTime(widget.note.createdAt, locale),
            ].join(' · '),
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
