part of '../settings_screen.dart';

class _LibrarySettingsSection extends StatelessWidget {
  const _LibrarySettingsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Library',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Text(
          'Review your listening and manage local audiobook storage.',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 18),
        Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.insights_rounded),
                title: const Text('Listening insights'),
                subtitle: const Text(
                  'Listening time, activity, and completed books',
                ),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () => context.pushNamed(AppRoutes.insights),
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.storage_rounded),
                title: const Text('Storage assistant'),
                subtitle: const Text(
                  'Find missing, duplicate, and unused files',
                ),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () => context.pushNamed(AppRoutes.storage),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
