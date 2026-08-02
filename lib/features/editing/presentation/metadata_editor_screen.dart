import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/presentation/book_cover.dart';
import '../../../core/presentation/formatters.dart';
import '../../library/domain/audiobook.dart';
import 'metadata_editor_cubit.dart';
import 'metadata_editor_state.dart';

class MetadataEditorScreen extends StatelessWidget {
  const MetadataEditorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit audiobook')),
      body: BlocBuilder<MetadataEditorCubit, MetadataEditorState>(
        builder: (context, state) {
          final book = state.book;
          if (book == null) {
            return Center(
              child: state.status == MetadataEditorStatus.failure
                  ? Text(state.message ?? 'Audiobook not found')
                  : const CircularProgressIndicator(),
            );
          }
          return _EditorForm(book: book);
        },
      ),
    );
  }
}

class _EditorForm extends StatefulWidget {
  const _EditorForm({required this.book});

  final Audiobook book;

  @override
  State<_EditorForm> createState() => _EditorFormState();
}

class _EditorFormState extends State<_EditorForm> {
  late final TextEditingController _title;
  late final TextEditingController _author;
  late final TextEditingController _series;
  late final TextEditingController _narrator;
  late final TextEditingController _year;
  late final TextEditingController _folder;

  @override
  void initState() {
    super.initState();
    _title = TextEditingController(text: widget.book.title);
    _author = TextEditingController(text: widget.book.author);
    _series = TextEditingController(text: widget.book.series);
    _narrator = TextEditingController(text: widget.book.narrator);
    _year = TextEditingController(text: widget.book.year?.toString() ?? '');
    _folder = TextEditingController(text: widget.book.folder);
  }

  @override
  void dispose() {
    _title.dispose();
    _author.dispose();
    _series.dispose();
    _narrator.dispose();
    _year.dispose();
    _folder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final book = widget.book;
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
      children: [
        Center(
          child: Column(
            children: [
              BookCover(
                title: book.title,
                artworkPath: book.artworkPath,
                size: 110,
              ),
              TextButton.icon(
                onPressed: context.read<MetadataEditorCubit>().changeCover,
                icon: const Icon(Icons.image_outlined),
                label: const Text('Change cover'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _title,
          decoration: const InputDecoration(labelText: 'Title'),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _author,
          decoration: const InputDecoration(labelText: 'Author'),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _series,
          decoration: const InputDecoration(labelText: 'Series'),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _narrator,
          decoration: const InputDecoration(labelText: 'Narrator'),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _year,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Year'),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _folder,
          decoration: const InputDecoration(labelText: 'Folder'),
        ),
        const SizedBox(height: 16),
        FilledButton(
          onPressed: () => context.read<MetadataEditorCubit>().saveDetails(
            title: _title.text,
            author: _author.text,
            series: _series.text,
            narrator: _narrator.text,
            year: _year.text,
            folder: _folder.text,
          ),
          child: const Text('Save details'),
        ),
        if (book.tracks.length > 1) ...[
          const SizedBox(height: 28),
          Text('Track order', style: Theme.of(context).textTheme.titleLarge),
          ReorderableListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: book.playableTracks.length,
            onReorderItem: context.read<MetadataEditorCubit>().reorderTrack,
            itemBuilder: (context, index) {
              final track = book.playableTracks[index];
              return ListTile(
                key: ValueKey(track.id),
                leading: Text('${index + 1}'),
                title: Text(track.title),
                trailing: const Icon(Icons.drag_handle_rounded),
              );
            },
          ),
        ],
        const SizedBox(height: 28),
        Row(
          children: [
            Expanded(
              child: Text(
                'Chapters',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            IconButton(
              tooltip: 'Add chapter',
              onPressed: () => _addChapter(context),
              icon: const Icon(Icons.add_rounded),
            ),
          ],
        ),
        for (final chapter in book.chapters)
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(chapter.title),
            subtitle: Text(
              formatDuration(Duration(milliseconds: chapter.startMs)),
            ),
            trailing: IconButton(
              onPressed: () =>
                  context.read<MetadataEditorCubit>().deleteChapter(chapter),
              icon: const Icon(Icons.delete_outline_rounded),
            ),
          ),
      ],
    );
  }

  Future<void> _addChapter(BuildContext context) async {
    final title = TextEditingController();
    final seconds = TextEditingController();
    final add = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Add chapter'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: title,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: seconds,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Start time in seconds',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Add'),
          ),
        ],
      ),
    );
    if (add == true && context.mounted) {
      final position = Duration(seconds: int.tryParse(seconds.text) ?? 0);
      await context.read<MetadataEditorCubit>().addChapter(
        title.text,
        position,
      );
    }
    title.dispose();
    seconds.dispose();
  }
}
