import 'package:freezed_annotation/freezed_annotation.dart';

part 'storage_report.freezed.dart';

@freezed
abstract class StorageReport with _$StorageReport {
  const factory StorageReport({
    @Default(0) int managedBytes,
    @Default(0) int reclaimableBytes,
    @Default(<String>[]) List<String> missingBookIds,
    @Default(<List<String>>[]) List<List<String>> duplicateBookIds,
    @Default(<String>[]) List<String> orphanPaths,
  }) = _StorageReport;
}
