import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';

import 'core/di/injection.dart';
import 'core/theme/bookish_theme.dart';
import 'features/player/data/bookish_audio_handler.dart';
import 'features/settings/domain/theme_preference.dart';
import 'features/settings/presentation/settings_cubit.dart';
import 'features/settings/presentation/settings_state.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  final audioHandler = await AudioService.init(
    builder: () => BookishAudioHandler(getIt<AudioPlayer>()),
    config: const AudioServiceConfig(
      androidNotificationChannelId: 'com.tomasrepcik.bookish.audio',
      androidNotificationChannelName: 'Bookish playback',
      androidNotificationIcon: 'drawable/ic_launcher_monochrome',
      // Keep the media service foregrounded across brief interruptions. On
      // Android 12+, a backgrounded app may otherwise be unable to promote the
      // service again when playback resumes.
      androidStopForegroundOnPause: false,
      fastForwardInterval: BookishAudioHandler.skipInterval,
      rewindInterval: BookishAudioHandler.skipInterval,
    ),
  );
  getIt.registerSingleton<AudioHandler>(audioHandler);
  runApp(const BookishAppRoot());
}

class BookishAppRoot extends StatefulWidget {
  const BookishAppRoot({super.key});

  @override
  State<BookishAppRoot> createState() => _BookishAppRootState();
}

class _BookishAppRootState extends State<BookishAppRoot> {
  late final SettingsCubit _settingsCubit;

  @override
  void initState() {
    super.initState();
    _settingsCubit = getIt<SettingsCubit>()..load();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: _settingsCubit, child: const BookishApp());
  }
}

class BookishApp extends StatelessWidget {
  const BookishApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      buildWhen: (previous, current) =>
          previous.themePreference != current.themePreference,
      builder: (context, state) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Bookish',
        theme: BookishTheme.light,
        darkTheme: BookishTheme.dark,
        themeMode: _themeMode(state.themePreference),
        routerConfig: getIt<GoRouter>(),
      ),
    );
  }

  ThemeMode _themeMode(ThemePreference preference) {
    return switch (preference) {
      ThemePreference.system => ThemeMode.system,
      ThemePreference.light => ThemeMode.light,
      ThemePreference.dark => ThemeMode.dark,
    };
  }
}
