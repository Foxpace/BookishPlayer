import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/injection.dart';
import '../../settings/data/settings_dao.dart';
import '../../transcription/domain/transcription_repository.dart';
import 'player_cubit.dart';
import 'player_screen.dart';

/// Composition boundary for one player route and its Cubit lifetime.
class PlayerScreenRoot extends StatefulWidget {
  const PlayerScreenRoot({required this.bookId, super.key});

  final String bookId;

  @override
  State<PlayerScreenRoot> createState() => _PlayerScreenRootState();
}

class _PlayerScreenRootState extends State<PlayerScreenRoot> {
  late final PlayerCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<PlayerCubit>()..openById(widget.bookId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: PlayerScreen(
        transcription: getIt<TranscriptionRepository>(),
        settings: getIt<SettingsDao>(),
      ),
    );
  }
}
