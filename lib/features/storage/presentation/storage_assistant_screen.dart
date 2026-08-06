import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/presentation/diagnostic_failure.dart';
import 'package:go_router/go_router.dart';

import '../../../core/navigation/app_router.dart';
import '../../player/presentation/player_cubit.dart';
import '../../settings/presentation/settings_cubit.dart';
import 'storage_assistant_cubit.dart';
import 'storage_assistant_state.dart';

class StorageAssistantScreen extends StatelessWidget {
  const StorageAssistantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Storage assistant')),
      body: BlocConsumer<StorageAssistantCubit, StorageAssistantState>(
        listenWhen: (previous, current) =>
            current.message != null && current.message != previous.message,
        listener: (context, state) => ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(state.message!))),
        builder: (context, state) {
          if (state.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          final books = {for (final book in state.books) book.id: book};
          return ListView(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
            children: [
              Card(
                child: ListTile(
                  leading: const Icon(Icons.storage_rounded),
                  title: Text(
                    '${_formatBytes(state.report.managedBytes)} managed',
                  ),
                  subtitle: Text(
                    '${_formatBytes(state.report.reclaimableBytes)} can be reclaimed safely',
                  ),
                  trailing: FilledButton(
                    onPressed: state.report.orphanPaths.isEmpty
                        ? null
                        : () => _confirmCleanup(context),
                    child: const Text('Clean'),
                  ),
                ),
              ),
              const SizedBox(height: 22),
              _SectionTitle(
                title: 'Missing files',
                count: state.report.missingBookIds.length,
              ),
              if (state.report.missingBookIds.isEmpty)
                const ListTile(title: Text('Every library file is available.'))
              else
                for (final id in state.report.missingBookIds)
                  Card(
                    child: ListTile(
                      title: Text(books[id]?.title ?? 'Unknown book'),
                      subtitle: const Text(
                        'Its audio file is no longer available.',
                      ),
                      trailing: IconButton(
                        tooltip: 'Remove missing library entry',
                        icon: const Icon(Icons.delete_outline_rounded),
                        onPressed: () => _confirmRemoveMissing(
                          context,
                          id,
                          books[id]?.title ?? 'this book',
                        ),
                      ),
                    ),
                  ),
              const SizedBox(height: 22),
              _SectionTitle(
                title: 'Possible duplicates',
                count: state.report.duplicateBookIds.length,
              ),
              if (state.report.duplicateBookIds.isEmpty)
                const ListTile(title: Text('No duplicate books detected.'))
              else
                for (final group in state.report.duplicateBookIds)
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.copy_all_rounded),
                      title: Text(
                        books[group.first]?.title ?? 'Duplicate books',
                      ),
                      subtitle: Text(
                        group
                            .map((id) => books[id]?.folder ?? 'Unknown')
                            .join(' · '),
                      ),
                    ),
                  ),
              const SizedBox(height: 32),
              Text(
                'Reset Bookish',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Card(
                child: ListTile(
                  leading: Icon(
                    Icons.delete_forever_rounded,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  title: const Text('Erase all app data'),
                  subtitle: const Text(
                    'Remove every book, note, setting, listening record, speech model, and app-managed file.',
                  ),
                  trailing: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.error,
                      foregroundColor: Theme.of(context).colorScheme.onError,
                    ),
                    onPressed: () => _confirmReset(context),
                    child: const Text('Erase'),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _confirmCleanup(BuildContext context) async {
    final approved = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Remove unused files?'),
        content: const Text(
          'Bookish will delete copied audio and cover files that are not referenced by any library entry.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Remove unused files'),
          ),
        ],
      ),
    );
    if (approved == true && context.mounted) {
      await context.read<StorageAssistantCubit>().cleanOrphans();
    }
  }

  Future<void> _confirmRemoveMissing(
    BuildContext context,
    String id,
    String title,
  ) async {
    final approved = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Remove missing entry?'),
        content: Text(
          '“$title” will be removed from the library because its audio is no longer available.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Remove entry'),
          ),
        ],
      ),
    );
    if (approved == true && context.mounted) {
      await context.read<StorageAssistantCubit>().removeMissingBook(id);
    }
  }

  Future<void> _confirmReset(BuildContext context) async {
    final approved = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        icon: Icon(
          Icons.warning_amber_rounded,
          color: Theme.of(dialogContext).colorScheme.error,
        ),
        title: const Text('Erase all Bookish data?'),
        content: const Text(
          'This permanently removes all audiobooks, covers, notes, listening history, settings, downloaded speech models, and app-managed files. This cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(dialogContext).colorScheme.error,
              foregroundColor: Theme.of(dialogContext).colorScheme.onError,
            ),
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Erase everything'),
          ),
        ],
      ),
    );
    if (approved != true || !context.mounted) {
      return;
    }
    try {
      await context.read<PlayerCubit>().resetForAppDataRemoval();
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              diagnosticFailureMessage(
                'Playback could not be reset safely.',
                error,
              ),
            ),
          ),
        );
      }
      return;
    }
    if (!context.mounted) {
      return;
    }
    final cleared = await context.read<StorageAssistantCubit>().clearAll();
    if (!cleared || !context.mounted) {
      return;
    }
    await context.read<SettingsCubit>().reload();
    if (context.mounted) {
      context.goNamed(AppRoutes.library);
    }
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title, required this.count});

  final String title;
  final int count;

  @override
  Widget build(BuildContext context) => Text(
    '$title · $count',
    style: Theme.of(
      context,
    ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
  );
}

String _formatBytes(int bytes) {
  if (bytes >= 1024 * 1024 * 1024) {
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }
  if (bytes >= 1024 * 1024) {
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
  return '${(bytes / 1024).toStringAsFixed(1)} KB';
}
