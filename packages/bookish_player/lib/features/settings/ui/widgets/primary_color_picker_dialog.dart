import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';
import '../../../../core/theme/bookish_theme_seed.dart';
import 'visual_color_picker.dart';

class PrimaryColorPickerDialog extends StatefulWidget {
  const PrimaryColorPickerDialog({required this.initialColor, super.key});

  final int initialColor;

  @override
  State<PrimaryColorPickerDialog> createState() =>
      _PrimaryColorPickerDialogState();
}

class _PrimaryColorPickerDialogState extends State<PrimaryColorPickerDialog> {
  late Color _color;

  @override
  void initState() {
    super.initState();
    _color = Color(widget.initialColor);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context);
    return AlertDialog(
      title: Text(l10n.chooseAppColorTitle),
      content: SizedBox(
        width: 280,
        child: VisualColorPicker(
          color: _color,
          fieldSemanticLabel: l10n.chooseAppColorTitle,
          hueSemanticLabel: l10n.colorHue,
          onChanged: (color) => setState(() => _color = color),
        ),
      ),
      actions: [
        _DialogActions(
          callbacks: (
            useDefault: () =>
                Navigator.pop(context, defaultBookishSeedColorValue),
            cancel: () => Navigator.pop(context),
            save: () => Navigator.pop(context, _color.toARGB32()),
          ),
          labels: (
            defaultColor: l10n.defaultColor,
            cancel: l10n.cancel,
            save: l10n.save,
          ),
        ),
      ],
    );
  }
}

class _DialogActions extends StatelessWidget {
  const _DialogActions({required this.callbacks, required this.labels});

  final ({VoidCallback useDefault, VoidCallback cancel, VoidCallback save})
  callbacks;
  final ({String defaultColor, String cancel, String save}) labels;

  @override
  Widget build(BuildContext context) {
    final textStyle = TextButton.styleFrom(
      minimumSize: const Size(0, 48),
      padding: const EdgeInsets.symmetric(horizontal: 8),
    );
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: TextButton(
              onPressed: callbacks.useDefault,
              style: textStyle,
              child: Align(
                alignment: Alignment.centerLeft,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(labels.defaultColor),
                ),
              ),
            ),
          ),
          Expanded(
            child: TextButton(
              onPressed: callbacks.cancel,
              style: textStyle,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(labels.cancel),
              ),
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: FilledButton(
              onPressed: callbacks.save,
              style: FilledButton.styleFrom(
                minimumSize: const Size(0, 48),
                padding: const EdgeInsets.symmetric(horizontal: 10),
              ),
              child: FittedBox(fit: BoxFit.scaleDown, child: Text(labels.save)),
            ),
          ),
        ],
      ),
    );
  }
}
