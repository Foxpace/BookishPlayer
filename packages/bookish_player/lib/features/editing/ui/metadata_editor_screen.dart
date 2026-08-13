import 'package:flutter/material.dart';

import '../../../core/localization/generated/l10n.dart';
import '../../../core/presentation/app_message.dart';
import '../../../core/presentation/bookish_scaffold.dart';
import '../../../core/presentation/diagnostic_failure_view.dart';
import '../../library/models/library_models.dart';
import '../cubits/editing_cubits.dart';
import 'metadata_editor_form.dart';

typedef MetadataEditorIntents = ({
  VoidCallback retry,
  VoidCallback changeCover,
  SaveMetadataDetails saveDetails,
  void Function(int oldIndex, int newIndex) reorderTrack,
  VoidCallback addChapter,
  ValueChanged<AudioChapter> deleteChapter,
});

class MetadataEditorScreen extends StatelessWidget {
  const MetadataEditorScreen({
    required this.state,
    required this.intents,
    super.key,
  });

  final MetadataEditorState state;
  final MetadataEditorIntents intents;

  @override
  Widget build(BuildContext context) {
    final book = state.book;
    return BookishScaffold(
      appBar: AppBar(title: Text(S.of(context).editAudiobook)),
      body: switch (book) {
        final value? => MetadataEditorForm(
          book: value,
          intents: (
            changeCover: intents.changeCover,
            saveDetails: intents.saveDetails,
            reorderTrack: intents.reorderTrack,
            addChapter: intents.addChapter,
            deleteChapter: intents.deleteChapter,
          ),
        ),
        null when state.status == MetadataEditorStatus.failure =>
          DiagnosticFailureView.fromMessage(
            message:
                state.message?.localize(context) ??
                S.of(context).audiobookNotFound,
            onRetry: intents.retry,
          ),
        null => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}
