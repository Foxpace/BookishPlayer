import 'package:freezed_annotation/freezed_annotation.dart';

import '../../library/domain/audiobook.dart';
import '../domain/storage_report.dart';

part 'storage_assistant_state.freezed.dart';

@freezed
abstract class StorageAssistantState with _$StorageAssistantState {
  const factory StorageAssistantState({
    @Default(true) bool loading,
    @Default(<Audiobook>[]) List<Audiobook> books,
    @Default(StorageReport()) StorageReport report,
    String? message,
  }) = _StorageAssistantState;
}
