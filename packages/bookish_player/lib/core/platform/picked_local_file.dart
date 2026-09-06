import 'package:freezed_annotation/freezed_annotation.dart';

part 'picked_local_file.freezed.dart';

@freezed
abstract class PickedLocalFile with _$PickedLocalFile {
  const factory PickedLocalFile({
    required String name,
    required String? path,
    required int? sizeBytes,
  }) = _PickedLocalFile;
}
