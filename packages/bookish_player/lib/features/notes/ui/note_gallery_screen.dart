import 'package:flutter/material.dart';

import '../../../core/localization/generated/l10n.dart';
import '../../../core/presentation/bookish_scaffold.dart';
import '../../library/models/library_models.dart';
import '../cubits/notes_cubits.dart';
import 'widgets/note_gallery_content.dart';

class NoteGalleryScreen extends StatelessWidget {
  const NoteGalleryScreen({
    required this.state,
    required this.onRetry,
    required this.onOpenBookNotes,
    super.key,
  });

  final NoteGalleryState state;
  final VoidCallback onRetry;
  final ValueChanged<BookMetadata> onOpenBookNotes;

  @override
  Widget build(BuildContext context) {
    return BookishScaffold(
      appBar: AppBar(title: Text(S.of(context).yourNotes)),
      body: NoteGalleryContent(
        state: state,
        onRetry: onRetry,
        onOpenBookNotes: onOpenBookNotes,
      ),
    );
  }
}
