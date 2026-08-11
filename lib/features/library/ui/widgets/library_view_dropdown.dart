import 'package:flutter/material.dart';

class LibraryViewDropdown<T> extends StatelessWidget {
  const LibraryViewDropdown({
    required this.label,
    required this.value,
    required this.values,
    required this.behavior,
    super.key,
  });

  final String label;
  final T value;
  final List<T> values;
  final ({String Function(T value) text, ValueChanged<T> changed}) behavior;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      key: ValueKey(value),
      initialValue: value,
      decoration: InputDecoration(labelText: label),
      items: [
        for (final option in values)
          DropdownMenuItem(value: option, child: Text(behavior.text(option))),
      ],
      onChanged: (selection) {
        if (selection != null) {
          behavior.changed(selection);
        }
      },
    );
  }
}
