import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_note.freezed.dart';
part 'book_note.g.dart';

enum BookNoteKind { note, bookmark, voice }

@freezed
abstract class BookNote with _$BookNote {
  const factory BookNote({
    required String id,
    required int positionMs,
    required String text,
    required DateTime createdAt,
    required String metadataId,
    @Default(BookNoteKind.note) BookNoteKind kind,
    String? title,
    String? chapterTitle,
    int? endPositionMs,
  }) = _BookNote;

  factory BookNote.fromJson(Map<String, dynamic> json) =>
      _$BookNoteFromJson(json);
}
