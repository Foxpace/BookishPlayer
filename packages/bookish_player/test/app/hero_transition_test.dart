import 'package:bookish_player/app/bookish_app.dart';
import 'package:bookish_player/core/navigation/app_router.dart';
import 'package:bookish_player/core/presentation/bottom_overlay_space.dart';
import 'package:bookish_player/core/presentation/bookish_scaffold.dart';
import 'package:bookish_player/features/player/ui/widgets/now_playing_bar.dart';
import 'package:bookish_player/features/player/ui/widgets/player_artwork.dart';
import 'package:bookish_player/features/settings/cubits/settings_cubit.dart';
import 'package:go_router/go_router.dart';

import '../../test_support/features/player/player_test_support.dart';
import '../../test_support/features/settings/settings_test_application.dart';
import '../../test_support/support/fixtures.dart';

void main() {
  for (final viewportSize in [const Size(390, 844), const Size(320, 640)]) {
    testWidgets(
      'Given the mini player at $viewportSize, When a library cover opens in the player, Then the cover grows smoothly and lands at the player size',
      (tester) async {
        // GIVEN
        tester.view
          ..physicalSize = viewportSize
          ..devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        final player = await PlayerCubitTestHarness.opened(audiobookFixture());
        final settings = SettingsCubit(
          buildSettingsApplication(FakeSettings()),
        );
        final book = player.sut.state.book!;
        final router = GoRouter(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, _) => BookishScaffold(
                floatingActionButton: FloatingActionButton(
                  onPressed: () {},
                  child: const Icon(Icons.add),
                ),
                body: Column(
                  children: [
                    BookCover(
                      title: book.title,
                      heroTag: book.id,
                      layout: const (
                        size: 64,
                        heightFactor: 1.22,
                        imageFit: BoxFit.contain,
                      ),
                    ),
                    TextButton(
                      onPressed: () => context.pushNamed(
                        AppRoutes.player,
                        pathParameters: {'bookId': book.id},
                      ),
                      child: const Text('Open'),
                    ),
                  ],
                ),
              ),
              routes: [
                GoRoute(
                  path: 'player/:bookId',
                  name: AppRoutes.player,
                  builder: (_, _) => PlayerTestScreenHarness(cubit: player.sut),
                ),
              ],
            ),
          ],
        );
        addTearDown(player.close);
        addTearDown(settings.close);
        addTearDown(router.dispose);
        await tester.pumpWidget(
          MultiBlocProvider(
            providers: [
              BlocProvider<SettingsCubit>.value(value: settings),
              BlocProvider<PlayerCubit>.value(value: player.sut),
            ],
            child: BookishApp(router: router),
          ),
        );
        await tester.pumpAndSettle();
      final miniPlayer = find.byType(NowPlayingBar);
      final reservedHeight = tester
          .widget<BottomOverlaySpace>(find.byType(BottomOverlaySpace))
          .height;
      expect(tester.getSize(miniPlayer).height, reservedHeight);
      expect(
          tester.getBottomLeft(find.byType(FloatingActionButton)).dy,
          lessThanOrEqualTo(tester.getTopLeft(miniPlayer).dy),
        );

        // WHEN
        await tester.tap(find.text('Open'));
        await tester.pump();
      final playerCover = find.descendant(
        of: find.byType(PlayerArtwork, skipOffstage: false),
        matching: find.byType(BookCover, skipOffstage: false),
        skipOffstage: false,
      );
        final playerCoverSize = tester.getSize(playerCover);
        await tester.pump(const Duration(milliseconds: 150));
        final flyingCover = find.byWidgetPredicate(
          (widget) =>
              widget is BookCover &&
              widget.heroTag == null &&
              widget.layout.size > 44,
        );
        final middleSize = tester.getSize(flyingCover);

        // THEN
        expect(middleSize.width, greaterThan(64));
        expect(middleSize.width, lessThan(playerCoverSize.width));
        expect(middleSize.height, greaterThan(64 * 1.22));
        expect(middleSize.height, lessThan(playerCoverSize.height));
        expect(middleSize.height / middleSize.width, inInclusiveRange(1, 1.22));

        await tester.pump(const Duration(milliseconds: 300));
        expect(tester.getSize(flyingCover), tester.getSize(playerCover));
        expect(tester.getTopLeft(flyingCover), tester.getTopLeft(playerCover));
        expect(miniPlayer, findsNothing);

        await tester.pumpAndSettle();
        expect(flyingCover, findsNothing);
        expect(tester.getSize(playerCover), playerCoverSize);
      },
    );
  }
}
