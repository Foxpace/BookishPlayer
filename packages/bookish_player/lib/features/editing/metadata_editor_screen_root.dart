import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/di/injection.dart';
import 'cubits/metadata_editor_cubit.dart';
import 'cubits/editing_cubits.dart';
import 'ui/metadata_editor_screen.dart';
import 'ui/widgets/chapter_editor_dialog.dart';

class MetadataEditorScreenRoot extends StatelessWidget {
  const MetadataEditorScreenRoot({required this.bookId, super.key});

  final String bookId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MetadataEditorCubit>(
      create: (_) => getIt<MetadataEditorCubit>()..load(bookId),
      child: BlocBuilder<MetadataEditorCubit, MetadataEditorState>(
        builder: (context, state) {
          final cubit = context.read<MetadataEditorCubit>();
          return MetadataEditorScreen(
            state: state,
            intents: (
              retry: cubit.retryLoad,
              changeCover: cubit.changeCover,
              saveDetails: cubit.saveDetails,
              reorderTrack: cubit.reorderTrack,
              addChapter: () => _addChapter(context, cubit),
              deleteChapter: cubit.deleteChapter,
            ),
          );
        },
      ),
    );
  }

  Future<void> _addChapter(
    BuildContext context,
    MetadataEditorCubit cubit,
  ) async {
    final chapter = await showChapterEditorDialog(context);
    if (chapter != null && context.mounted) {
      await cubit.addChapter(chapter.title, chapter.position);
    }
  }
}
