import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/di/injection.dart';
import '../../core/localization/generated/l10n.dart';
import '../../core/navigation/app_router.dart';
import '../../core/presentation/app_message.dart';
import '../player/cubits/player_cubit.dart';
import '../settings/cubits/settings_cubit.dart';
import 'cubits/storage_assistant_cubit.dart';
import 'cubits/storage_assistant_state.dart';
import 'ui/storage_assistant_screen.dart';
import 'use_cases/storage_use_case_bundle.dart';

class StorageAssistantScreenRoot extends StatelessWidget {
  const StorageAssistantScreenRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StorageAssistantCubit>(
      create: (_) => StorageAssistantCubit(getIt<StorageUseCases>(), (
        resetPlayback: getIt<PlayerCubit>().resetForAppDataRemoval,
        reloadSettings: getIt<SettingsCubit>().reload,
      ))..load(),
      child: BlocConsumer<StorageAssistantCubit, StorageAssistantState>(
        listenWhen: (previous, current) =>
            current.message != null &&
            current.effectRevision != previous.effectRevision,
        listener: _showMessage,
        builder: (context, state) {
          final cubit = context.read<StorageAssistantCubit>();
          return StorageAssistantScreen(
            state: state,
            onClean: () => _confirmCleanup(context, cubit),
            onRemoveMissing: (id, title) =>
                _confirmRemoveMissing(context, cubit, id, title),
            onReset: () => _confirmReset(context, cubit),
          );
        },
      ),
    );
  }

  void _showMessage(BuildContext context, StorageAssistantState state) {
    final message = state.message;
    if (message != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message.localize(context))));
    }
  }

  Future<void> _confirmCleanup(
    BuildContext context,
    StorageAssistantCubit cubit,
  ) async {
    final approved = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(S.of(context).removeUnusedFilesQuestion),
        content: Text(S.of(context).unusedFilesExplanation),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(S.of(context).cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(S.of(context).removeUnusedFiles),
          ),
        ],
      ),
    );
    if (approved == true && context.mounted) {
      await cubit.cleanOrphans();
    }
  }

  Future<void> _confirmRemoveMissing(
    BuildContext context,
    StorageAssistantCubit cubit,
    String id,
    String title,
  ) async {
    final approved = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(S.of(context).removeMissingEntryQuestion),
        content: Text(S.of(context).removeMissingBookDescription(title)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(S.of(context).cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(S.of(context).removeEntry),
          ),
        ],
      ),
    );
    if (approved == true && context.mounted) {
      await cubit.removeMissingBook(id);
    }
  }

  Future<void> _confirmReset(
    BuildContext context,
    StorageAssistantCubit cubit,
  ) async {
    final approved = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        icon: Icon(
          Icons.warning_amber_rounded,
          color: Theme.of(dialogContext).colorScheme.error,
        ),
        title: Text(S.of(context).eraseAllDataQuestion),
        content: Text(S.of(context).eraseAllDataDescription),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(S.of(context).cancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(dialogContext).colorScheme.error,
              foregroundColor: Theme.of(dialogContext).colorScheme.onError,
            ),
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(S.of(context).eraseEverything),
          ),
        ],
      ),
    );
    if (approved != true || !context.mounted) {
      return;
    }
    final cleared = await cubit.clearAll();
    if (cleared && context.mounted) {
      context.goNamed(AppRoutes.library);
    }
  }
}
