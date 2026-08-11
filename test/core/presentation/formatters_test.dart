import 'package:bookish_player/core/presentation/formatters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Formatters', () {
    test(
      'Given the formatters, When its behavior is exercised, Then all-time durations are not capped at 100 hours',
      () {
        // THEN
        expect(
          formatDuration(const Duration(hours: 125, minutes: 7)),
          '125:07:00',
        );
      },
    );
  });
}
