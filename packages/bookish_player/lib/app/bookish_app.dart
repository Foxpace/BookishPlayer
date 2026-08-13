import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';

import '../core/localization/generated/l10n.dart';
import '../core/navigation/app_navigation.dart';
import '../core/navigation/focus_navigation.dart';
import '../core/theme/bookish_theme.dart';
import '../features/player/cubits/player_cubit.dart';
import '../features/player/cubits/player_cubits.dart';
import '../features/player/ui/now_playing_shell.dart';
import '../features/settings/cubits/settings_cubit.dart';
import '../features/settings/cubits/settings_cubits.dart';
import '../features/settings/models/theme_preference.dart';

class BookishApp extends StatelessWidget {
  const BookishApp({required this.router, super.key});

  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      buildWhen: (previous, current) =>
          previous.themePreference != current.themePreference,
      builder: (context, state) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        onGenerateTitle: (context) => S.of(context).appTitle,
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        theme: BookishTheme.light,
        darkTheme: BookishTheme.dark,
        themeMode: _themeMode(state.themePreference),
        routerConfig: router,
        builder: (context, child) => Overlay.wrap(
          child: _RouterAwareNowPlayingShell(
            router: router,
            onOpenPlayer: _openMiniPlayer,
            child: child ?? const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }

  ThemeMode _themeMode(ThemePreference preference) => switch (preference) {
    ThemePreference.system => ThemeMode.system,
    ThemePreference.light => ThemeMode.light,
    ThemePreference.dark => ThemeMode.dark,
  };

  Future<void> _openMiniPlayer(String? bookId) async {
    if (bookId == null) {
      return;
    }
    await router.pushNamed<void>(
      AppRoutes.player,
      pathParameters: {'bookId': bookId},
    );
    dismissRestoredRouteFocus();
  }
}

class _RouterAwareNowPlayingShell extends StatefulWidget {
  const _RouterAwareNowPlayingShell({
    required this.router,
    required this.onOpenPlayer,
    required this.child,
  });

  final GoRouter router;
  final ValueChanged<String?> onOpenPlayer;
  final Widget child;

  @override
  State<_RouterAwareNowPlayingShell> createState() =>
      _RouterAwareNowPlayingShellState();
}

class _RouterAwareNowPlayingShellState
    extends State<_RouterAwareNowPlayingShell> {
  var _routeRebuildScheduled = false;

  @override
  void initState() {
    super.initState();
    widget.router.routerDelegate.addListener(_handleRouteChanged);
  }

  @override
  void didUpdateWidget(_RouterAwareNowPlayingShell oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.router == widget.router) {
      return;
    }
    oldWidget.router.routerDelegate.removeListener(_handleRouteChanged);
    widget.router.routerDelegate.addListener(_handleRouteChanged);
  }

  void _handleRouteChanged() {
    if (WidgetsBinding.instance.schedulerPhase !=
        SchedulerPhase.persistentCallbacks) {
      setState(() {});
      return;
    }
    if (_routeRebuildScheduled) {
      return;
    }
    _routeRebuildScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _routeRebuildScheduled = false;
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    widget.router.routerDelegate.removeListener(_handleRouteChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerCubit, PlayerState>(
      builder: (context, playerState) => NowPlayingShell(
        state: playerState,
        behavior: (
          showMiniPlayer: shouldShowMiniPlayer(_activeRouteUri(widget.router)),
          onOpenPlayer: () => widget.onOpenPlayer(playerState.book?.id),
          onTogglePlayback: context.read<PlayerCubit>().togglePlayback,
        ),
        child: widget.child,
      ),
    );
  }
}

bool shouldShowMiniPlayer(Uri location) =>
    !location.path.startsWith('/player/');

Uri _activeRouteUri(GoRouter router) {
  final configuration = router.routerDelegate.currentConfiguration;
  return configuration.matches.isEmpty ? configuration.uri : router.state.uri;
}
