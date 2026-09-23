import 'package:material_ui/material_ui.dart';

import '../../../../core/app_metadata.dart';
import '../../../../core/localization/generated/l10n.dart';

part 'bookish_about_dialog_action.dart';

class BookishAboutDialog extends StatelessWidget {
  const BookishAboutDialog({
    required this.versionName,
    required this.buildNumber,
    required this.onAction,
    super.key,
  });

  final String versionName;
  final String buildNumber;
  final ValueChanged<BookishAboutDialogAction> onAction;

  @override
  Widget build(BuildContext context) {
    final material = MaterialLocalizations.of(context);
    return AlertDialog(
      title: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              appIconAsset,
              package: 'bookish_player',
              width: 56,
              height: 56,
              semanticLabel: appName,
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(child: Text(appName)),
        ],
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            Text(S.of(context).appVersion(versionName)),
            const SizedBox(height: 4),
            Text(S.of(context).appBuildNumber(buildNumber)),
            const SizedBox(height: 12),
            Text(S.of(context).applicationLegalese),
            const SizedBox(height: 12),
            Text(S.of(context).appDescription),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => onAction(BookishAboutDialogAction.openLicenses),
          child: Text(material.viewLicensesButtonLabel),
        ),
        TextButton(
          onPressed: () => onAction(BookishAboutDialogAction.close),
          child: Text(material.closeButtonLabel),
        ),
      ],
    );
  }
}
