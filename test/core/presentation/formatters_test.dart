import 'package:bookish_player/core/presentation/formatters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('all-time durations are not capped at 100 hours', () {
    expect(formatDuration(const Duration(hours: 125, minutes: 7)), '125:07:00');
  });
}
