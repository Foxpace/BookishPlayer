import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../core/diagnostics/app_error_handler.dart';
import '../core/di/injection.dart';
import '../features/player/cubits/player_cubit.dart';
import '../features/settings/cubits/settings_cubit.dart';
import 'app_capabilities.dart';
import 'app_bootstrapper.dart';
import 'bookish_app.dart';
import 'dependency_registration.dart';

Future<void> runBookish({
  AppCapabilities capabilities = const AppCapabilities(),
  Future<void> Function()? registerOptionalDependencies,
}) async {
  WidgetsFlutterBinding.ensureInitialized();

  getIt.registerSingleton<AppCapabilities>(capabilities);
  if (capabilities.transcriptionEnabled &&
      registerOptionalDependencies == null) {
    throw StateError(
      'Transcription requires an optional dependency registrar.',
    );
  }

  await registerOptionalDependencies?.call();
  await configureDependencies(
    environments: {
      productionEnvironment,
      if (capabilities.transcriptionEnabled) internalEnvironment,
    },
  );

  final errorHandler = getIt<AppErrorHandler>()..install();
  await runZonedGuarded(() async {
    await getIt<AppBootstrapper>().initialize();
    runApp(_createAppRoot());
  }, errorHandler.recordUncaught);
}

BookishAppRoot _createAppRoot() => BookishAppRoot(
  settingsCubit: getIt<SettingsCubit>(),
  playerCubit: getIt<PlayerCubit>(),
  router: getIt<GoRouter>(),
);

class BookishAppRoot extends StatefulWidget {
  const BookishAppRoot({
    required this.settingsCubit,
    required this.playerCubit,
    required this.router,
    super.key,
  });

  final SettingsCubit settingsCubit;
  final PlayerCubit playerCubit;
  final GoRouter router;

  @override
  State<BookishAppRoot> createState() => _BookishAppRootState();
}

class _BookishAppRootState extends State<BookishAppRoot> {
  late final SettingsCubit _settingsCubit;
  late final PlayerCubit _playerCubit;

  @override
  void initState() {
    super.initState();
    _settingsCubit = widget.settingsCubit..load();
    _playerCubit = widget.playerCubit;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _settingsCubit),
        BlocProvider.value(value: _playerCubit),
      ],
      child: BookishApp(router: widget.router),
    );
  }
}
