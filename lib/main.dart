import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'core/diagnostics/app_error_handler.dart';
import 'app/app_bootstrapper.dart';
import 'app/bookish_app.dart';
import 'core/di/injection.dart';
import 'features/player/cubits/player_cubit.dart';
import 'features/settings/cubits/settings_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  final errorHandler = getIt<AppErrorHandler>()..install();
  await runZonedGuarded(() async {
    await getIt<AppBootstrapper>().initialize();
    runApp(
      BookishAppRoot(
        settingsCubit: getIt<SettingsCubit>(),
        playerCubit: getIt<PlayerCubit>(),
        router: getIt<GoRouter>(),
      ),
    );
  }, errorHandler.recordUncaught);
}

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
