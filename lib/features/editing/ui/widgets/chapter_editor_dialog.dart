import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';

typedef ChapterDraft = ({String title, Duration position});

Future<ChapterDraft?> showChapterEditorDialog(BuildContext context) =>
    showDialog<ChapterDraft>(
      context: context,
      builder: (_) => const _ChapterEditorDialog(),
    );

class _ChapterEditorDialog extends StatefulWidget {
  const _ChapterEditorDialog();

  @override
  State<_ChapterEditorDialog> createState() => _ChapterEditorDialogState();
}

class _ChapterEditorDialogState extends State<_ChapterEditorDialog> {
  final _title = TextEditingController();
  final _seconds = TextEditingController();

  @override
  void dispose() {
    _title.dispose();
    _seconds.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.of(context).addChapter),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _title,
            decoration: InputDecoration(labelText: S.of(context).titleField),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _seconds,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: S.of(context).startTimeSeconds,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(S.of(context).cancel),
        ),
        FilledButton(onPressed: _submit, child: Text(S.of(context).add)),
      ],
    );
  }

  void _submit() {
    final seconds = int.tryParse(_seconds.text) ?? 0;
    Navigator.pop(context, (
      title: _title.text,
      position: Duration(seconds: seconds),
    ));
  }
}
