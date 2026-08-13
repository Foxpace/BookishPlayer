import 'package:freezed_annotation/freezed_annotation.dart';

import 'book_note_kind.dart';
part 'book_note.freezed.dart';
part 'book_note.g.dart';

@freezed
abstract class BookNote with _$BookNote {
  const BookNote._();
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

  String? get displayTitle {
    final value = title?.trim();
    return value == null || value.isEmpty ? null : value;
  }

  bool get hasDisplayTitle => displayTitle != null;

  String get displayText => displayTitle ?? text;

  Duration get position => Duration(milliseconds: positionMs);

  Duration? get endPosition => switch (endPositionMs) {
    final value? => Duration(milliseconds: value),
    null => null,
  };
}
