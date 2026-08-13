import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/presentation/app_message.dart';
import '../../library/models/library_models.dart';

import 'metadata_editor_status.dart';
part 'metadata_editor_state.freezed.dart';

@freezed
abstract class MetadataEditorState with _$MetadataEditorState {
  const factory MetadataEditorState({
    @Default(MetadataEditorStatus.loading) MetadataEditorStatus status,
    String? bookId,
    Audiobook? book,
    AppMessage? message,
    @Default(0) int effectRevision,
  }) = _MetadataEditorState;
}
