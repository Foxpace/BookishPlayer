import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/presentation/app_message.dart';
import '../../library/models/library_models.dart';
import '../models/storage_report.dart';

part 'storage_assistant_state.freezed.dart';

@freezed
abstract class StorageAssistantState with _$StorageAssistantState {
  const factory StorageAssistantState({
    @Default(true) bool loading,
    @Default(<Audiobook>[]) List<Audiobook> books,
    @Default(StorageReport()) StorageReport report,
    AppMessage? message,
    @Default(0) int effectRevision,
  }) = _StorageAssistantState;
}
