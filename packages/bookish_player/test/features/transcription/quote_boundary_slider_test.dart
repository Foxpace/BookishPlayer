import 'package:bookish_player/features/transcription/ui/widgets/quote_range_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_support/support/pump_bookish_app.dart';

void main() {
  group('Quote boundary slider', () {
    testWidgets(
      'Given the quote boundary slider, When its behavior is exercised, Then uses one dual-thumb slider and changes one boundary at a time',
      (tester) async {
        // GIVEN
        var start = const Duration(seconds: 30);
        var end = const Duration(seconds: 60);
        // WHEN
        await tester.pumpBookishApp(
          child: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) => QuoteRangeSlider(
                range: (
                  start: start,
                  end: end,
                  chapterDuration: const Duration(minutes: 10),
                ),
                behavior: (
                  enabled: true,
                  onStartChanged: (next) => setState(() => start = next),
                  onEndChanged: (next) => setState(() => end = next),
                ),
              ),
            ),
          ),
        );

        // THEN
        expect(find.byType(RangeSlider), findsOneWidget);
        var slider = tester.widget<RangeSlider>(find.byType(RangeSlider));
        final changeStart = slider.onChanged;
        if (changeStart == null) {
          fail('The enabled range slider must accept changes.');
        }
        changeStart(const RangeValues(30123, 60000));
        await tester.pump();

        expect(start, const Duration(milliseconds: 30123));
        expect(end, const Duration(seconds: 60));

        slider = tester.widget<RangeSlider>(find.byType(RangeSlider));
        final changeEnd = slider.onChanged;
        if (changeEnd == null) {
          fail('The enabled range slider must accept changes.');
        }
        changeEnd(const RangeValues(30123, 61789));
        await tester.pump();

        expect(start, const Duration(milliseconds: 30123));
        expect(end, const Duration(milliseconds: 61789));
        expect(slider.divisions, isNull);
      },
    );
  });
}
