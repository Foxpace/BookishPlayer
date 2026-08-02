import 'package:bookish_player/features/player/presentation/quote_boundary_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('uses one dual-thumb slider and changes one boundary at a time', (
    tester,
  ) async {
    var start = const Duration(seconds: 30);
    var end = const Duration(seconds: 60);
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StatefulBuilder(
            builder: (context, setState) => QuoteRangeSlider(
              start: start,
              end: end,
              chapterDuration: const Duration(minutes: 10),
              enabled: true,
              onStartChanged: (next) => setState(() => start = next),
              onEndChanged: (next) => setState(() => end = next),
            ),
          ),
        ),
      ),
    );

    expect(find.byType(RangeSlider), findsOneWidget);
    var slider = tester.widget<RangeSlider>(find.byType(RangeSlider));
    slider.onChanged!(const RangeValues(30123, 60000));
    await tester.pump();

    expect(start, const Duration(milliseconds: 30123));
    expect(end, const Duration(seconds: 60));

    slider = tester.widget<RangeSlider>(find.byType(RangeSlider));
    slider.onChanged!(const RangeValues(30123, 61789));
    await tester.pump();

    expect(start, const Duration(milliseconds: 30123));
    expect(end, const Duration(milliseconds: 61789));
    expect(slider.divisions, isNull);
  });
}
