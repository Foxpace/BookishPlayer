import 'package:bookish_player/core/diagnostics/app_error.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Structured application error', () {
    test(
      'Given structured failure context, When it is serialized and rendered, Then JSON and shareable diagnostics retain the same fields',
      () {
        // GIVEN
        const error = AppError(
          time: '2026-08-11T10:00:00.000Z',
          operation: 'import.analyzingChapters',
          errorType: 'FormatException',
          message: 'Invalid chapter table',
          stack: 'frame 1',
          platform: 'ios',
          platformVersion: '26.0',
          build: '0.1.0+1',
          context: {'Stage': 'analyzingChapters'},
          history: ['copyingFile: 20 ms'],
          diagnostics: ['No chpl atom found'],
        );

        // WHEN
        final restored = AppError.fromJson(error.toJson());
        final text = restored.toDiagnosticText(title: 'Bookish diagnostic');

        // THEN
        expect(restored, error);
        expect(text, contains('Stage: analyzingChapters'));
        expect(text, contains('No chpl atom found'));
        expect(text, contains('FormatException'));
      },
    );
  });
}
