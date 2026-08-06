import 'package:freezed_annotation/freezed_annotation.dart';

import '../../player/domain/book_note.dart';
import '../../library/domain/book_metadata.dart';

part 'note_gallery_state.freezed.dart';

enum NoteGalleryStatus { loading, ready, failure }

@freezed
abstract class NoteGalleryState with _$NoteGalleryState {
  const factory NoteGalleryState({
    @Default(NoteGalleryStatus.loading) NoteGalleryStatus status,
    @Default(<BookMetadata>[]) List<BookMetadata> metadata,
    @Default(<BookNote>[]) List<BookNote> notes,
    String? message,
  }) = _NoteGalleryState;
}
