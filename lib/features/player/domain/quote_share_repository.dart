import 'package:freezed_annotation/freezed_annotation.dart';

part 'quote_share_repository.freezed.dart';

@freezed
abstract class ShareOrigin with _$ShareOrigin {
  const factory ShareOrigin({
    required double x,
    required double y,
    required double width,
    required double height,
  }) = _ShareOrigin;
}

abstract interface class QuoteShareRepository {
  Future<void> share({
    required String text,
    required String subject,
    ShareOrigin? origin,
  });
}
