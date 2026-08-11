import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';

class ResetBookishSection extends StatelessWidget {
  const ResetBookishSection({required this.onReset, super.key});

  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).resetBookish,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: colors.error,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Card(
          child: ListTile(
            leading: Icon(Icons.delete_forever_rounded, color: colors.error),
            title: Text(S.of(context).eraseAllAppData),
            subtitle: Text(S.of(context).resetDataDescription),
            trailing: FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: colors.error,
                foregroundColor: colors.onError,
              ),
              onPressed: onReset,
              child: Text(S.of(context).erase),
            ),
          ),
        ),
      ],
    );
  }
}
