import 'package:flutter/material.dart';

import '../../../../core/app_metadata.dart';
import '../../../../core/localization/generated/l10n.dart';

part 'bookish_about_dialog_action.dart';

class BookishAboutDialog extends StatelessWidget {
  const BookishAboutDialog({required this.onAction, super.key});

  final ValueChanged<BookishAboutDialogAction> onAction;

  @override
  Widget build(BuildContext context) {
    final material = MaterialLocalizations.of(context);
    return AlertDialog(
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
            Text(S.of(context).appVersion(appVersion)),
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
