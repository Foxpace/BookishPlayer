import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/di/injection.dart';
import '../../core/presentation/app_message.dart';
import 'cubits/speech_models_cubit.dart';
import 'cubits/transcription_cubits.dart';
import 'models/speech_model.dart';
import 'ui/speech_models_section.dart';
import 'ui/widgets/speech_model_picker_sheet.dart';

/// Composition boundary for speech-model settings and its single Cubit.
class SpeechModelsRoot extends StatelessWidget {
  const SpeechModelsRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SpeechModelsCubit>(
      create: (_) => getIt<SpeechModelsCubit>()..load(),
      child: BlocConsumer<SpeechModelsCubit, SpeechModelsState>(
        listenWhen: (previous, current) =>
            current.message != null &&
            previous.effectRevision != current.effectRevision,
        listener: _showMessage,
        builder: (context, state) {
          final cubit = context.read<SpeechModelsCubit>();
          return SpeechModelsSection(
            state: state,
            onOpenPicker: () => _showPicker(context, cubit),
          );
        },
      ),
    );
  }

  void _showMessage(BuildContext context, SpeechModelsState state) {
    final message = state.message;
    if (message != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message.localize(context))));
    }
  }

  Future<void> _showPicker(BuildContext context, SpeechModelsCubit cubit) {
    return showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (sheetContext) =>
          BlocBuilder<SpeechModelsCubit, SpeechModelsState>(
            bloc: cubit,
            builder: (_, state) => SpeechModelPickerSheet(
              state: state,
              onActivate: (model) => _activateModel(sheetContext, cubit, model),
            ),
          ),
    );
  }

  Future<void> _activateModel(
    BuildContext context,
    SpeechModelsCubit cubit,
    SpeechModel model,
  ) async {
    final activated = await cubit.activateModel(model);
    if (context.mounted && activated) {
      Navigator.pop(context);
    }
  }
}
