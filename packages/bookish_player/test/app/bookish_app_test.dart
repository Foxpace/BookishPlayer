import 'package:bookish_player/app/bookish_app.dart';
import 'package:bookish_player/features/player/ui/widgets/now_playing_bar.dart';
import 'package:bookish_player/features/settings/cubits/settings_cubit.dart';
import 'package:go_router/go_router.dart';

import '../../test_support/features/player/player_test_support.dart';
import '../../test_support/features/settings/settings_test_application.dart';
import '../../test_support/support/fixtures.dart';

void main() {
  testWidgets(
    'Given an active audiobook, When the app shell shows the mini player, Then tooltip controls have an overlay',
    (tester) async {
      // GIVEN
      final player = await PlayerCubitTestHarness.opened(audiobookFixture());
      final settings = SettingsCubit(buildSettingsApplication(FakeSettings()));
      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (_, _) => const Scaffold(body: Text('Library')),
          ),
        ],
      );
      addTearDown(player.close);
      addTearDown(settings.close);
      addTearDown(router.dispose);

      // WHEN
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<SettingsCubit>.value(value: settings),
            BlocProvider<PlayerCubit>.value(value: player.sut),
          ],
          child: BookishApp(router: router),
        ),
      );
      await tester.pump();

      // THEN
      expect(tester.takeException(), isNull);
      expect(find.byTooltip('Play'), findsOneWidget);
    },
  );

  testWidgets(
    'Given an active audiobook, When the full player is pushed, Then the mini player is hidden',
    (tester) async {
      // GIVEN
      final player = await PlayerCubitTestHarness.opened(audiobookFixture());
      final settings = SettingsCubit(buildSettingsApplication(FakeSettings()));
      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (_, _) => const Scaffold(body: Text('Library')),
            routes: [
              GoRoute(
                path: 'player/:bookId',
                builder: (_, _) => const Scaffold(body: Text('Full player')),
              ),
            ],
          ),
        ],
      );
      addTearDown(player.close);
      addTearDown(settings.close);
      addTearDown(router.dispose);

      // WHEN
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
      expect(find.byType(NowPlayingBar), findsOneWidget);

      final navigation = router.push<void>('/player/book-1');
      await tester.pump();
      expect(find.byType(NowPlayingBar), findsNothing);
      await tester.pumpAndSettle();

      // THEN
      expect(find.text('Full player'), findsOneWidget);
      expect(find.byType(NowPlayingBar), findsNothing);

      router.pop();
      await navigation;
    },
  );
}
