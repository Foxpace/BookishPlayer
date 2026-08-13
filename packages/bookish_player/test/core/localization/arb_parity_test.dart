import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('English and Slovak localization catalogs', () {
    test(
      'Given the English and Slovak localization catalogs, When their message identifiers are compared, Then both locales expose the same messages',
      () {
        // GIVEN
        final english = _messages('lib/l10n/intl_en.arb');
        // WHEN
        final slovak = _messages('lib/l10n/intl_sk.arb');

        // THEN
        expect(slovak.difference(english), isEmpty);
        expect(english.difference(slovak), isEmpty);
      },
    );
  });
}

Set<String> _messages(String path) {
  final json =
      jsonDecode(File(path).readAsStringSync()) as Map<String, dynamic>;
  return json.keys.where((key) => !key.startsWith('@')).toSet();
}
