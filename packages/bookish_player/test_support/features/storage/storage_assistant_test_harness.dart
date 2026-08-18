import 'package:bookish_player/core/localization/generated/l10n.dart';
import 'package:bookish_player/core/navigation/app_router.dart';
import 'package:bookish_player/core/presentation/app_message.dart';
import 'package:bookish_player/features/storage/cubits/storage_assistant_cubit.dart';
import 'package:bookish_player/features/storage/cubits/storage_assistant_state.dart';
import 'package:bookish_player/features/storage/ui/storage_assistant_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class StorageAssistantTestHarness extends StatelessWidget {
  const StorageAssistantTestHarness({
    required this.cubit,
    this.navigateAfterReset = false,
    super.key,
  });

  final StorageAssistantCubit cubit;
  final bool navigateAfterReset;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StorageAssistantCubit, StorageAssistantState>(
      bloc: cubit,
      listenWhen: (previous, current) =>
          current.message != null &&
          current.effectRevision != previous.effectRevision,
      listener: (context, state) {
        final message = state.message;
        if (message != null) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(message.localize(context))));
        }
      },
      builder: (context, state) => StorageAssistantScreen(
        state: state,
        onClean: () => _confirmCleanup(context),
        onRemoveMissing: (id, title) => _confirmRemove(context, id, title),
        onReset: () => _confirmReset(context),
      ),
    );
  }

  Future<void> _confirmCleanup(BuildContext context) async {
    final approved = await _confirm(
      context,
      title: S.of(context).removeUnusedFilesQuestion,
      content: S.of(context).unusedFilesExplanation,
      action: S.of(context).removeUnusedFiles,
    );
    if (approved && context.mounted) {
      await cubit.cleanOrphans();
    }
  }

  Future<void> _confirmRemove(
    BuildContext context,
    String id,
    String title,
  ) async {
    final approved = await _confirm(
      context,
      title: S.of(context).removeMissingEntryQuestion,
      content: S.of(context).removeMissingBookDescription(title),
      action: S.of(context).removeEntry,
    );
    if (approved && context.mounted) {
      await cubit.removeMissingBook(id);
    }
  }

  Future<void> _confirmReset(BuildContext context) async {
    final approved = await _confirm(
      context,
      title: S.of(context).eraseAllDataQuestion,
      content: S.of(context).eraseAllDataDescription,
      action: S.of(context).eraseEverything,
    );
    if (!approved || !context.mounted) {
      return;
    }
    final cleared = await cubit.clearAll();
    if (cleared && context.mounted && navigateAfterReset) {
      context.goNamed(AppRoutes.library);
    }
  }

  Future<bool> _confirm(
    BuildContext context, {
    required String title,
    required String content,
    required String action,
  }) async {
    final approved = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(S.of(context).cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(action),
          ),
        ],
      ),
    );
    return approved == true;
  }
}
