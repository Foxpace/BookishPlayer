import 'package:bookish_player/core/foundation/clock.dart';

class FakeClock implements Clock {
  FakeClock([DateTime? value]) : value = value ?? DateTime.utc(2026, 1, 1);

  DateTime value;

  @override
  DateTime now() => value;

  void advance(Duration duration) {
    value = value.add(duration);
  }
}
