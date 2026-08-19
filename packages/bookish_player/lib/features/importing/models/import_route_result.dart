import 'package:freezed_annotation/freezed_annotation.dart';

import 'import_failed_item.dart';
import 'import_route_status.dart';
export 'import_route_status.dart';

part 'import_route_result.freezed.dart';

@freezed
abstract class ImportRouteResult with _$ImportRouteResult {
  const factory ImportRouteResult({
    required ImportRouteStatus status,
    required int importedCount,
    ImportFailedItem? failedItem,
  }) = _ImportRouteResult;
}
