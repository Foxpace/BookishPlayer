import 'package:bookish_player/features/player/ui/widgets/player_tool_visual.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'Given a blue app palette, When a player tool badge renders, Then it uses the primary theme colors',
    (tester) async {
      // GIVEN
      final colorScheme = ColorScheme.fromSeed(
        seedColor: const Color(0xFF1565C0),
      );

      // WHEN
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData(useMaterial3: true, colorScheme: colorScheme),
          home: const Scaffold(
            body: PlayerToolVisual(
              icon: Icons.note_alt_outlined,
              label: 'Notes',
              badgeLabel: '3',
            ),
          ),
        ),
      );

      // THEN
      final badge = tester.widget<Badge>(find.byType(Badge));
      expect(badge.backgroundColor, colorScheme.primary);
      expect(badge.textColor, colorScheme.onPrimary);
    },
  );
}
