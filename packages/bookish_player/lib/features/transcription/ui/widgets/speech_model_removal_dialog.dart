import 'package:material_ui/material_ui.dart';

import '../../../../core/localization/generated/l10n.dart';
import '../../models/speech_model.dart';

Future<bool> confirmSpeechModelRemoval(
  BuildContext context,
  SpeechModel model,
) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text(
        S.of(dialogContext).removeSpeechModelQuestion(model.displayName),
      ),
      content: Text(S.of(dialogContext).removeSpeechModelDescription),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext, false),
          child: Text(S.of(dialogContext).cancel),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(dialogContext, true),
          child: Text(S.of(dialogContext).removeFromDevice),
        ),
      ],
    ),
  );
  return confirmed == true && context.mounted;
}
