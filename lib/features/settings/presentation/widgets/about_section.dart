part of '../settings_screen.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.aboutTitle,
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 8),
        Text(
          l10n.aboutDescription,
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
                leading: const Icon(Icons.info_outline_rounded),
                title: Text(l10n.aboutBookish),
                subtitle: Text(l10n.appVersion(appVersion)),
                onTap: () => unawaited(_showBookishAboutDialog(context)),
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.description_outlined),
                title: Text(l10n.openSourceLicenses),
                subtitle: Text(l10n.openSourceLicensesDescription),
                onTap: () => _showBookishLicensePage(context),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Future<void> _showBookishAboutDialog(BuildContext context) async {
  final l10n = S.of(context);
  final material = MaterialLocalizations.of(context);
  final openLicenses = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Row(
        children: [
          Icon(Icons.auto_stories_rounded, size: 40),
          SizedBox(width: 16),
          Expanded(child: Text(appName)),
        ],
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Text(l10n.appVersion(appVersion)),
            const SizedBox(height: 12),
            Text(l10n.applicationLegalese),
            const SizedBox(height: 12),
            Text(l10n.appDescription),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext, true),
          child: Text(material.viewLicensesButtonLabel),
        ),
        TextButton(
          onPressed: () => Navigator.pop(dialogContext, false),
          child: Text(material.closeButtonLabel),
        ),
      ],
    ),
  );
  if (openLicenses == true && context.mounted) {
    _showBookishLicensePage(context);
  }
}

void _showBookishLicensePage(BuildContext context) {
  final l10n = S.of(context);
  showLicensePage(
    context: context,
    applicationName: appName,
    applicationVersion: appVersion,
    applicationLegalese: l10n.applicationLegalese,
  );
}
