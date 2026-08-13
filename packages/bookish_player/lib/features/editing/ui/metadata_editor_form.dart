import 'package:flutter/material.dart';

import '../../library/models/library_models.dart';
import '../models/editable_book_details.dart';
import 'widgets/chapter_list_editor.dart';
import 'widgets/metadata_book_cover_editor.dart';
import 'widgets/metadata_details_fields.dart';
import 'widgets/track_order_editor.dart';

typedef SaveMetadataDetails = ValueChanged<EditableBookDetails>;
typedef MetadataEditorFormIntents = ({
  VoidCallback changeCover,
  SaveMetadataDetails saveDetails,
  void Function(int oldIndex, int newIndex) reorderTrack,
  VoidCallback addChapter,
  ValueChanged<AudioChapter> deleteChapter,
});

class MetadataEditorForm extends StatefulWidget {
  const MetadataEditorForm({
    required this.book,
    required this.intents,
    super.key,
  });

  final Audiobook book;
  final MetadataEditorFormIntents intents;

  @override
  State<MetadataEditorForm> createState() => _MetadataEditorFormState();
}

class _MetadataEditorFormState extends State<MetadataEditorForm> {
  late final TextEditingController _title;
  late final TextEditingController _author;
  late final TextEditingController _series;
  late final TextEditingController _seriesPosition;
  late final TextEditingController _narrator;
  late final TextEditingController _year;
  late final TextEditingController _folder;

  @override
  void initState() {
    super.initState();
    final book = widget.book;
    _title = TextEditingController(text: book.title);
    _author = TextEditingController(text: book.author);
    _series = TextEditingController(text: book.series);
    _seriesPosition = TextEditingController(
      text: book.seriesPosition?.toString() ?? '',
    );
    _narrator = TextEditingController(text: book.narrator);
    _year = TextEditingController(text: book.year?.toString() ?? '');
    _folder = TextEditingController(text: book.folder);
  }

  @override
  void dispose() {
    _title.dispose();
    _author.dispose();
    _series.dispose();
    _seriesPosition.dispose();
    _narrator.dispose();
    _year.dispose();
    _folder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
      children: [
        MetadataBookCoverEditor(
          book: widget.book,
          onChangeCover: widget.intents.changeCover,
        ),
        const SizedBox(height: 12),
        MetadataDetailsFields(
          controllers: (
            title: _title,
            author: _author,
            series: _series,
            seriesPosition: _seriesPosition,
            narrator: _narrator,
            year: _year,
            folder: _folder,
          ),
          onSave: _saveDetails,
        ),
        TrackOrderEditor(
          book: widget.book,
          onReorder: widget.intents.reorderTrack,
        ),
        ChapterListEditor(
          chapters: widget.book.chapters,
          onAdd: widget.intents.addChapter,
          onDelete: widget.intents.deleteChapter,
        ),
      ],
    );
  }

  void _saveDetails() {
    widget.intents.saveDetails((
      title: _title.text,
      author: _author.text,
      series: _series.text,
      seriesPosition: _seriesPosition.text,
      narrator: _narrator.text,
      year: _year.text,
      folder: _folder.text,
    ));
  }
}
