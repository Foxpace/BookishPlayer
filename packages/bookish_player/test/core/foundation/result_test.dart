import 'package:bookish_player/core/foundation/result.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Application result', () {
    test(
      'Given a caught exception, When an operation failure is created, Then its category, detail, and error remain available',
      () {
        // GIVEN
        final error = Exception('disk unavailable');

        // WHEN
        final failure = AppFailure.operationFailed(
          'library.load',
          error: error,
        );

        // THEN
        expect(failure.code, AppFailureCode.operationFailed);
        expect(failure.detail, 'library.load');
        expect(failure.error, same(error));
      },
    );

    test(
      'Given work completed before cancellation, When a failed result is returned, Then partial success data remains available',
      () {
        // WHEN
        const result = Result<int>.failure(
          AppFailure.cancelled('import.cancelled'),
          partialValue: 2,
        );

        // THEN
        expect(
          result,
          const ResultFailure<int>(
            AppFailure.cancelled('import.cancelled'),
            partialValue: 2,
          ),
        );
      },
    );
  });
}
