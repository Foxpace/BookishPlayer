import 'dart:async';
import 'package:bookish_player/features/player/repos/player_repositories.dart';
import 'player_test_support.dart';

class FakeSharing implements QuoteShareRepository {
  String? text;
  String? subject;

  @override
  Future<void> share({
    required String text,
    required String subject,
    ShareOrigin? origin,
  }) async {
    this.text = text;
    this.subject = subject;
  }
}
