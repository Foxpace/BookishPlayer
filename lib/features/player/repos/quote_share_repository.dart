import '../models/share_origin.dart';

abstract interface class QuoteShareRepository {
  Future<void> share({
    required String text,
    required String subject,
    ShareOrigin? origin,
  });
}
