import 'package:flutter/widgets.dart';

import '../../notes/models/book_note.dart';

typedef ComposePlayerCapability = Future<void> Function(BuildContext context);
typedef OpenPlayerNote =
    Future<void> Function(BuildContext context, BookNote note);

typedef PlayerPlaybackIntents = ({
  Future<void> Function() pausePlayback,
  Future<void> Function() togglePlayback,
  Future<void> Function() previousChapter,
  Future<void> Function() nextChapter,
  Future<void> Function(Duration delta) skipBy,
  Future<void> Function(double speed) changeSpeed,
  Future<void> Function(Duration position) seek,
  Future<void> Function(Duration position) seekWithinChapter,
});
