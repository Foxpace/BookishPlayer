import 'package:freezed_annotation/freezed_annotation.dart';

import 'import_failure_kind.dart';
import 'import_stage.dart';

part 'import_failed_item.freezed.dart';

@freezed
abstract class ImportFailedItem with _$ImportFailedItem {
  const factory ImportFailedItem({
    required String displayName,
    required ImportStage stage,
    required ImportFailureKind kind,
  }) = _ImportFailedItem;
}
