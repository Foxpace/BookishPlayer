import 'package:bookish_player/app/bookish_app.dart';
import 'package:bookish_player/core/navigation/modal_visibility.dart';
import 'package:bookish_player/core/presentation/bookish_scaffold.dart';
import 'package:bookish_player/features/player/ui/widgets/now_playing_bar.dart';
import 'package:bookish_player/features/settings/cubits/settings_cubit.dart';
import 'package:go_router/go_router.dart';

import '../../test_support/features/player/player_test_support.dart';
import '../../test_support/features/settings/settings_test_application.dart';
import '../../test_support/support/fixtures.dart';

void main() {
  testWidgets(
    'Given settings and an active player, When a sheet opens with a nested dialog, Then modal controls stay accessible until dismissal',
    (tester) async {
      // GIVEN
      final player = await PlayerCubitTestHarness.opened(audiobookFixture());
      final settings = SettingsCubit(buildSettingsApplication(FakeSettings()));
      final visibility = ModalVisibility();
      final router = GoRouter(
        initialLocation: '/settings',
        observers: [visibility],
        routes: [
          GoRoute(path: '/settings', builder: (_, _) => const _Settings()),
        ],
      );
      addTearDown(player.close);
      addTearDown(settings.close);
      addTearDown(router.dispose);
      addTearDown(visibility.dispose);
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
      final settingsBounds = tester.getRect(find.text('Open model picker'));

      // WHEN
      await tester.tap(find.text('Open model picker'));
      await tester.pumpAndSettle();
      expect(find.byType(NowPlayingBar), findsNothing);
      expect(tester.getRect(find.text('Open model picker')), settingsBounds);
      await tester.tap(find.text('Remove model'));
      await tester.pumpAndSettle();
      expect(find.text('Confirm removal'), findsOneWidget);
      expect(find.byType(NowPlayingBar), findsNothing);
      await tester.tap(find.text('Cancel removal'));
      await tester.pumpAndSettle();
      expect(find.text('Confirm removal'), findsNothing);
      expect(find.byType(NowPlayingBar), findsNothing);
      await tester.tap(find.text('Apply selection'));
      await tester.pumpAndSettle();

      // THEN
      expect(find.text('Apply selection'), findsNothing);
      expect(find.byType(NowPlayingBar), findsOneWidget);
      expect(tester.getRect(find.text('Open model picker')), settingsBounds);
      expect(tester.takeException(), isNull);
    },
  );
}

class _Settings extends StatelessWidget {
  const _Settings();

  @override
  Widget build(BuildContext context) => BookishScaffold(
    body: Center(
      child: FilledButton(
        onPressed: () => showModalBottomSheet<void>(
          context: context,
          builder: (_) => const _ModelPicker(),
        ),
        child: const Text('Open model picker'),
      ),
    ),
  );
}

class _ModelPicker extends StatelessWidget {
  const _ModelPicker();

  @override
  Widget build(BuildContext context) => SafeArea(
    top: false,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
          onPressed: () => showDialog<void>(
            context: context,
            builder: (dialogContext) => AlertDialog(
              title: const Text('Confirm removal'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Cancel removal'),
                ),
              ],
            ),
          ),
          child: const Text('Remove model'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Apply selection'),
        ),
      ],
    ),
  );
}
