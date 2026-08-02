import 'package:freezed_annotation/freezed_annotation.dart';

import '../../library/domain/audiobook.dart';

part 'metadata_editor_state.freezed.dart';

enum MetadataEditorStatus { loading, ready, saving, saved, failure }

@freezed
abstract class MetadataEditorState with _$MetadataEditorState {
  const factory MetadataEditorState({
    @Default(MetadataEditorStatus.loading) MetadataEditorStatus status,
    Audiobook? book,
    String? message,
  }) = _MetadataEditorState;
}
