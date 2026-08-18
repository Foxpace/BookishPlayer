import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/presentation/app_message.dart';
import '../models/book_note.dart';
import '../../library/models/library_models.dart';

import 'note_gallery_status.dart';
part 'note_gallery_state.freezed.dart';

@freezed
abstract class NoteGalleryState with _$NoteGalleryState {
  const factory NoteGalleryState({
    @Default(NoteGalleryStatus.loading) NoteGalleryStatus status,
    @Default(<BookMetadata>[]) List<BookMetadata> metadata,
    @Default(<BookNote>[]) List<BookNote> notes,
    AppMessage? message,
    @Default(0) int effectRevision,
  }) = _NoteGalleryState;
}
