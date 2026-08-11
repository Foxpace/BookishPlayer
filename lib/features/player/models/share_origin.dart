import 'package:freezed_annotation/freezed_annotation.dart';

part 'share_origin.freezed.dart';

@freezed
abstract class ShareOrigin with _$ShareOrigin {
  const factory ShareOrigin({
    required double x,
    required double y,
    required double width,
    required double height,
  }) = _ShareOrigin;
}
