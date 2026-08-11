import 'dart:ui';

import 'package:injectable/injectable.dart';
import 'package:share_plus/share_plus.dart';

import '../player_repositories.dart';

@LazySingleton(as: QuoteShareRepository)
class SharePlusQuoteShareRepository implements QuoteShareRepository {
  @override
  Future<void> share({
    required String text,
    required String subject,
    ShareOrigin? origin,
  }) {
    return SharePlus.instance.share(
      ShareParams(
        text: text,
        subject: subject,
        sharePositionOrigin: origin == null
            ? null
            : Rect.fromLTWH(origin.x, origin.y, origin.width, origin.height),
      ),
    );
  }
}
