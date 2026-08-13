import 'package:flutter/material.dart';

import '../../../../../core/localization/generated/l10n.dart';

Future<String?> showNoteComposerSheet(
  BuildContext context, {
  required String heading,
}) => showModalBottomSheet<String>(
  context: context,
  isScrollControlled: true,
  showDragHandle: true,
  builder: (_) => _NoteComposerSheet(heading: heading),
);

class _NoteComposerSheet extends StatefulWidget {
  const _NoteComposerSheet({required this.heading});

  final String heading;

  @override
  State<_NoteComposerSheet> createState() => _NoteComposerSheetState();
}

class _NoteComposerSheetState extends State<_NoteComposerSheet> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.fromLTRB(
      24,
      8,
      24,
      24 + MediaQuery.viewInsetsOf(context).bottom,
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.heading,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _controller,
          autofocus: true,
          minLines: 3,
          maxLines: 6,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(hintText: S.of(context).noteThoughtHint),
        ),
        const SizedBox(height: 14),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: () => Navigator.pop(context, _controller.text),
            child: Text(S.of(context).saveNote),
          ),
        ),
      ],
    ),
  );
}
