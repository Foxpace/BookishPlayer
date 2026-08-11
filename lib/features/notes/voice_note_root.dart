import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/di/injection.dart';
import 'cubits/voice_note_cubit.dart';
import 'cubits/notes_cubits.dart';
import 'ui/widgets/voice_note_sheet.dart';

class VoiceNoteRoot extends StatelessWidget {
  const VoiceNoteRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<VoiceNoteCubit>(
      create: (_) => getIt<VoiceNoteCubit>(),
      child: BlocBuilder<VoiceNoteCubit, VoiceNoteState>(
        builder: (context, state) => VoiceNoteSheet(
          state: state,
          onToggle: context.read<VoiceNoteCubit>().toggle,
          onSave: (text) => Navigator.pop(context, text),
        ),
      ),
    );
  }
}
