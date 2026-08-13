import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';
import '../../models/library_models.dart';

Future<void> showFullBookTitle(BuildContext context, Audiobook book) {
  return showDialog<void>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text(S.of(context).fullTitle),
      content: SelectableText(book.title),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext),
          child: Text(S.of(context).close),
        ),
      ],
    ),
  );
}
