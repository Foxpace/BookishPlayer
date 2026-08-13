import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';

typedef MetadataTextControllers = ({
  TextEditingController title,
  TextEditingController author,
  TextEditingController series,
  TextEditingController seriesPosition,
  TextEditingController narrator,
  TextEditingController year,
  TextEditingController folder,
});

class MetadataDetailsFields extends StatelessWidget {
  const MetadataDetailsFields({
    required this.controllers,
    required this.onSave,
    super.key,
  });

  final MetadataTextControllers controllers;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controllers.title,
          decoration: InputDecoration(labelText: S.of(context).titleField),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: controllers.author,
          decoration: InputDecoration(labelText: S.of(context).authorField),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: controllers.series,
          decoration: InputDecoration(labelText: S.of(context).seriesField),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: controllers.seriesPosition,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            labelText: S.of(context).volumeNumberField,
            hintText: S.of(context).volumeNumberHint,
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: controllers.narrator,
          decoration: InputDecoration(labelText: S.of(context).narratorField),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: controllers.year,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: S.of(context).yearField),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: controllers.folder,
          decoration: InputDecoration(labelText: S.of(context).folderField),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: onSave,
            child: Text(S.of(context).saveDetails),
          ),
        ),
      ],
    );
  }
}
