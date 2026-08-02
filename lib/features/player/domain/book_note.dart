import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_note.freezed.dart';
part 'book_note.g.dart';

@freezed
abstract class BookNote with _$BookNote {
  const factory BookNote({
    required String id,
    required String bookId,
    required int positionMs,
    required String text,
    required DateTime createdAt,
  }) = _BookNote;

  factory BookNote.fromJson(Map<String, dynamic> json) =>
      _$BookNoteFromJson(json);
}
