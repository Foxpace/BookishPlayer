import 'package:bookish_player/core/presentation/formatters.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  setUpAll(() => initializeDateFormatting());

  test('formats date and time without redundant precision', () {
    final dateTime = DateTime(2026, 8, 4, 14, 5, 6, 789);

    final formatted = formatDateTime(dateTime, 'en');

    expect(formatted, 'Aug 4, 2026 2:05\u202fPM');
    expect(formatted, isNot(contains(':06')));
    expect(formatted, isNot(contains('.789')));
  });

  test('uses the requested locale', () {
    final formatted = formatDateTime(DateTime(2026, 8, 4, 14, 5), 'sk');

    expect(formatted, '4. 8. 2026 14:05');
  });
}
