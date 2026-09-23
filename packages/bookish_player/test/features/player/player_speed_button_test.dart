import 'package:bookish_player/features/player/ui/widgets/player_speed_button.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_support/support/pump_bookish_app.dart';

void main() {
  testWidgets(
    'Given the current playback speed, When the speed button is tapped, Then the speed choices are shown',
    (tester) async {
      // GIVEN
      await tester.pumpBookishApp(
        child: Scaffold(body: PlayerSpeedButton(speed: 1, onChanged: (_) {})),
      );

      // WHEN
      await tester.tap(find.byTooltip('Playback speed'));
      await tester.pumpAndSettle();

      // THEN
      expect(find.text('Playback speed'), findsOneWidget);
      expect(find.text('Relaxed'), findsOneWidget);
      expect(find.text('Very fast'), findsOneWidget);
    },
  );

  testWidgets(
    'Given the playback speed choices, When a speed is selected, Then the speed changes and the choices close',
    (tester) async {
      // GIVEN
      double? selectedSpeed;
      await tester.pumpBookishApp(
        child: Scaffold(
          body: PlayerSpeedButton(
            speed: 1,
            onChanged: (value) => selectedSpeed = value,
          ),
        ),
      );
      await tester.tap(find.byTooltip('Playback speed'));
      await tester.pumpAndSettle();

      // WHEN
      await tester.tap(find.byKey(const ValueKey('playback-speed-1.5')));
      await tester.pumpAndSettle();

      // THEN
      expect(selectedSpeed, 1.5);
      expect(find.text('Playback speed'), findsNothing);
    },
  );
}
