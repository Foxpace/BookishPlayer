import 'package:bookish_player/core/navigation/app_router.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('builds stable named locations for independent screens', () {
    final router = createAppRouter();
    addTearDown(router.dispose);

    expect(router.namedLocation(AppRoutes.library), '/');
    expect(router.namedLocation(AppRoutes.import), '/import');
    expect(router.namedLocation(AppRoutes.settings), '/settings');
    expect(
      router.namedLocation(
        AppRoutes.editBook,
        pathParameters: {'bookId': 'book-42'},
      ),
      '/book/book-42/edit',
    );
    expect(
      router.namedLocation(
        AppRoutes.player,
        pathParameters: {'bookId': 'book-42'},
      ),
      '/player/book-42',
    );
  });

  test('hides the mini player on the full player route', () {
    expect(shouldShowMiniPlayer(Uri.parse('/player/book-42')), isFalse);
    expect(shouldShowMiniPlayer(Uri.parse('/')), isTrue);
    expect(shouldShowMiniPlayer(Uri.parse('/settings')), isTrue);
  });
}
