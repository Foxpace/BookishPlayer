import 'package:bookish_player/features/importing/repos/media_probe.dart';

class FakeImportMediaProbe implements MediaProbe {
  @override
  Future<Duration> probeDuration(String path) async =>
      const Duration(minutes: 1);
}
