import 'package:bookish_player/features/player/cubits/player_cubits.dart';
import 'package:bookish_player/features/player/cubits/sleep_timer_duration_cubit.dart';
import 'package:bookish_player/features/player/ui/widgets/sleep_timer_sheet.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

import '../../../test_support/support/pump_bookish_app.dart';

void main() {
  testWidgets(
    'Given timer presets, When switching selection, Then their layout stays stable throughout the animation',
    (tester) async {
      await _pumpSheet(tester, (_) {});
      final presets = [15, 30, 45, 60]
          .map((minutes) => find.widgetWithText(ChoiceChip, '$minutes min'))
          .toList();
      final initialBounds = presets.map(tester.getRect).toList();
      final initialHeight = tester.getSize(find.byType(SleepTimerSheet)).height;

      for (final preset in presets) {
        await tester.tap(preset);
        await tester.pump();
        for (var frame = 0; frame < 20; frame++) {
          await tester.pump(const Duration(milliseconds: 16));

          expect(presets.map(tester.getRect).toList(), initialBounds);
          expect(
            tester.getSize(find.byType(SleepTimerSheet)).height,
            initialHeight,
          );
        }
      }
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'Given timer presets, When choosing one, Then it is highlighted and waits for acceptance',
    (tester) async {
      final choices = <Duration>[];
      await _pumpSheet(tester, choices.add);

      for (final minutes in [15, 30, 45, 60]) {
        await tester.tap(find.widgetWithText(ChoiceChip, '$minutes min'));
        await tester.pumpAndSettle();
        expect(tester.widget<Slider>(find.byType(Slider)).value, minutes);
        expect(
          tester
              .widgetList<ChoiceChip>(find.byType(ChoiceChip))
              .where((chip) => chip.selected)
              .length,
          1,
        );
        expect(
          tester
              .widget<ChoiceChip>(
                find.widgetWithText(ChoiceChip, '$minutes min'),
              )
              .selected,
          isTrue,
        );
      }

      expect(choices, isEmpty);
      await tester.tap(find.widgetWithText(FilledButton, 'Accept'));
      expect(choices, [const Duration(minutes: 60)]);
      expect(find.byType(Slider), findsOneWidget);
      expect(find.text('End of chapter'), findsOneWidget);
    },
  );

  testWidgets(
    'Given a slider, When dragging and accepting, Then only acceptance applies the custom time',
    (tester) async {
      final choices = <Duration>[];
      await _pumpSheet(tester, choices.add);
      final slider = find.byType(Slider);
      final center = tester.getCenter(slider);

      final gesture = await tester.startGesture(center);
      await gesture.moveBy(const Offset(15, 0));
      await tester.pump();
      final minutes = tester.widget<Slider>(slider).value.round();
      expect(choices, isEmpty);
      expect(find.text('$minutes min'), findsWidgets);
      await gesture.up();
      await tester.pumpAndSettle();

      expect(choices, isEmpty);
      expect(
        tester
            .widgetList<ChoiceChip>(find.byType(ChoiceChip))
            .every((chip) => !chip.selected),
        isTrue,
      );
      await tester.tap(find.widgetWithText(FilledButton, 'Accept'));
      expect(choices, [Duration(minutes: minutes)]);
      expect([15, 30, 45, 60], isNot(contains(minutes)));
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets(
    'Given an unconfirmed duration, When dismissing the sheet, Then no timer is applied',
    (tester) async {
      final choices = <Duration>[];
      await _pumpSheet(tester, choices.add);
      await tester.tap(find.widgetWithText(ChoiceChip, '45 min'));
      await tester.pumpAndSettle();

      await tester.pumpWidget(const SizedBox.shrink());

      expect(choices, isEmpty);
    },
  );
}

Future<void> _pumpSheet(
  WidgetTester tester,
  ValueChanged<Duration> onSelected,
) => tester.pumpBookishApp(
  child: BlocProvider(
    create: (_) => SleepTimerDurationCubit(),
    child: Scaffold(
      body: SleepTimerSheet(
        state: const PlayerState(),
        onSetDuration: onSelected,
        onEndOfChapter: () {},
        onCancel: () {},
      ),
    ),
  ),
);
