import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/di/injection.dart';
import 'player_cubit.dart';
import 'player_screen.dart';
import 'quote_transcription_cubit.dart';

/// Composition boundary for one player route and its Cubit lifetime.
class PlayerScreenRoot extends StatefulWidget {
  const PlayerScreenRoot({required this.bookId, super.key});

  final String bookId;

  @override
  State<PlayerScreenRoot> createState() => _PlayerScreenRootState();
}

class _PlayerScreenRootState extends State<PlayerScreenRoot>
    with WidgetsBindingObserver {
  late final PlayerCubit _cubit;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _cubit = getIt<PlayerCubit>();
    if (_cubit.state.book?.id != widget.bookId) {
      _cubit.openById(widget.bookId);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed) {
      unawaited(_cubit.saveProgress());
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _cubit),
        BlocProvider(create: (_) => getIt<QuoteTranscriptionCubit>()),
      ],
      child: const PlayerScreen(),
    );
  }
}
