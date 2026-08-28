import 'dart:async';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';

import '../core/localization/generated/l10n.dart';
import '../core/navigation/app_router.dart';
import '../core/navigation/focus_navigation.dart';
import '../core/theme/bookish_theme.dart';
import '../features/player/cubits/player_cubit.dart';
import '../features/player/cubits/player_cubits.dart';
import '../features/player/ui/now_playing_shell.dart';
import '../features/player/ui/widgets/continue_listening_sheet.dart';
import '../features/settings/cubits/settings_cubit.dart';
import '../features/settings/cubits/settings_state.dart';
import '../features/settings/models/appearance_preferences.dart';
import '../features/settings/models/theme_preference.dart';

class BookishApp extends StatelessWidget {
  const BookishApp({required this.router, super.key});

  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    if (kIsWeb || defaultTargetPlatform != TargetPlatform.android) {
      return _BookishMaterialApp(router: router, onOpenPlayer: _openMiniPlayer);
    }

    return DynamicColorBuilder(
      builder: (light, dark) => _BookishMaterialApp(
        router: router,
        onOpenPlayer: _openMiniPlayer,
        lightSystemColorScheme: light,
        darkSystemColorScheme: dark,
      ),
    );
  }

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

class _BookishMaterialApp extends StatelessWidget {
  const _BookishMaterialApp({
    required this.router,
    required this.onOpenPlayer,
    this.lightSystemColorScheme,
    this.darkSystemColorScheme,
  });

  final GoRouter router;
  final ValueChanged<String?> onOpenPlayer;
  final ColorScheme? lightSystemColorScheme;
  final ColorScheme? darkSystemColorScheme;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      buildWhen: (previous, current) =>
          previous.appearance != current.appearance,
      builder: (context, state) {
        final appearance = state.appearance;

        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          onGenerateTitle: (context) => S.of(context).appTitle,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,

          theme: _theme(appearance, Brightness.light, lightSystemColorScheme),
          darkTheme: _theme(appearance, Brightness.dark, darkSystemColorScheme),
          themeMode: _themeMode(appearance.theme),

          routerConfig: router,
          builder: (context, child) => Overlay.wrap(
            child: _RouterAwareNowPlayingShell(
              router: router,
              onOpenPlayer: onOpenPlayer,
              child: child ?? const SizedBox.shrink(),
            ),
          ),
        );
      },
    );
  }

  ThemeData _theme(
    AppearancePreferences appearance,
    Brightness brightness,
    ColorScheme? systemColorScheme,
  ) {
    final selectedSystemScheme = appearance.useSystemColors
        ? systemColorScheme
        : null;
    final seedColor = Color(appearance.primaryColor);
    return brightness == Brightness.light
        ? BookishTheme.lightFrom(
            seedColor: seedColor,
            systemColorScheme: selectedSystemScheme,
          )
        : BookishTheme.darkFrom(
            seedColor: seedColor,
            systemColorScheme: selectedSystemScheme,
          );
  }

  ThemeMode _themeMode(ThemePreference preference) => switch (preference) {
    ThemePreference.system => ThemeMode.system,
    ThemePreference.light => ThemeMode.light,
    ThemePreference.dark => ThemeMode.dark,
  };
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<PlayerCubit>().offerContinueListening();
      }
    });
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
    return BlocListener<PlayerCubit, PlayerState>(
      listenWhen: (previous, current) =>
          previous.continueListeningBook?.id !=
              current.continueListeningBook?.id &&
          current.continueListeningBook != null,
      listener: _showContinueListening,
      child: BlocBuilder<PlayerCubit, PlayerState>(
        builder: (context, playerState) => NowPlayingShell(
          state: playerState,
          behavior: (
            showMiniPlayer: shouldShowMiniPlayer(
              _activeRouteUri(widget.router),
            ),
            onOpenPlayer: () => widget.onOpenPlayer(playerState.book?.id),
            onTogglePlayback: context.read<PlayerCubit>().togglePlayback,
          ),
          child: widget.child,
        ),
      ),
    );
  }

  void _showContinueListening(BuildContext context, PlayerState state) {
    final book = state.continueListeningBook;
    if (book == null) {
      return;
    }

    final navigatorContext =
        widget.router.routerDelegate.navigatorKey.currentContext;
    if (navigatorContext == null) {
      return;
    }
    final player = context.read<PlayerCubit>();
    unawaited(
      showContinueListeningSheet(
        navigatorContext,
        book: book,
        intents: (
          continueBook: player.continueListening,
          cancel: player.cancelContinueListening,
        ),
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
