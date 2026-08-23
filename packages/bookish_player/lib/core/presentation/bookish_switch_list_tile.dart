import 'package:flutter/material.dart';

import 'bookish_control_metrics.dart';

class BookishSwitchListTile extends StatelessWidget {
  const BookishSwitchListTile({
    required this.content,
    required this.value,
    required this.onChanged,
    this.contentPadding,
    super.key,
  });

  final ({IconData icon, Widget title, Widget subtitle}) content;
  final bool value;
  final ValueChanged<bool> onChanged;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {
    return MergeSemantics(
      child: ListTile(
        leading: Icon(content.icon),
        title: content.title,
        subtitle: content.subtitle,
        trailing: Transform.scale(
          scale: BookishControlMetrics.selectionControlScale,
          child: Switch(
            value: value,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onChanged: onChanged,
          ),
        ),
        contentPadding: contentPadding,
        onTap: () => onChanged(!value),
      ),
    );
  }
}
