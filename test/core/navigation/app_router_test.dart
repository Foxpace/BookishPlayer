import 'package:bookish_player/core/navigation/app_navigation.dart';
import 'package:bookish_player/app/bookish_app.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App router', () {
    test(
      'Given the app router, When its behavior is exercised, Then builds stable named locations for independent screens',
      () {
        // GIVEN
        final sut = createAppRouter();
        // WHEN
        addTearDown(sut.dispose);

        // THEN
        expect(sut.namedLocation(AppRoutes.library), '/');
        expect(sut.namedLocation(AppRoutes.import), '/import');
        expect(sut.namedLocation(AppRoutes.settings), '/settings');
        expect(
          sut.namedLocation(
            AppRoutes.editBook,
            pathParameters: {'bookId': 'book-42'},
          ),
          '/book/book-42/edit',
        );
        expect(
          sut.namedLocation(
            AppRoutes.player,
            pathParameters: {'bookId': 'book-42'},
          ),
          '/player/book-42',
        );
      },
    );

    test(
      'Given the app router, When its behavior is exercised, Then hides the mini player on the full player route',
      () {
        // THEN
        expect(shouldShowMiniPlayer(Uri.parse('/player/book-42')), isFalse);
        expect(shouldShowMiniPlayer(Uri.parse('/')), isTrue);
        expect(shouldShowMiniPlayer(Uri.parse('/settings')), isTrue);
      },
    );
  });
}
