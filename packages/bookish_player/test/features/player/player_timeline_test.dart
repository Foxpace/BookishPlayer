import 'package:bookish_player/features/player/cubits/player_cubits.dart';
import 'package:bookish_player/features/player/ui/widgets/player_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Player timeline', () {
    testWidgets(
      'Given active playback, When a rewind drag starts, Then playback pauses and the dragged time is shown',
      (tester) async {
        // GIVEN
        var pauseCount = 0;
        Duration? sought;
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: PlayerTimeline(
                state: _state,
                onRewindStart: () => pauseCount++,
                onSeek: (value) => sought = value,
              ),
            ),
          ),
        );
        var slider = tester.widget<Slider>(find.byType(Slider));

        // WHEN
        slider.onChangeStart?.call(40000);
        slider = tester.widget<Slider>(find.byType(Slider));
        slider.onChanged?.call(20000);
        await tester.pump();
        final firstDraggedLabelWasShown = find
            .text('0:20')
            .evaluate()
            .isNotEmpty;

        slider = tester.widget<Slider>(find.byType(Slider));
        slider.onChanged?.call(15000);
        await tester.pump();
        final secondDraggedLabelWasShown = find
            .text('0:15')
            .evaluate()
            .isNotEmpty;

        slider = tester.widget<Slider>(find.byType(Slider));
        slider.onChangeEnd?.call(15000);

        // THEN
        expect(pauseCount, 1);
        expect(firstDraggedLabelWasShown, isTrue);
        expect(secondDraggedLabelWasShown, isTrue);
        expect(sought, const Duration(seconds: 15));
      },
    );

    testWidgets(
      'Given active playback, When a forward drag starts, Then playback is not paused',
      (tester) async {
        // GIVEN
        var pauseCount = 0;
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: PlayerTimeline(
                state: _state,
                onRewindStart: () => pauseCount++,
                onSeek: (_) {},
              ),
            ),
          ),
        );

        // WHEN
        final slider = tester.widget<Slider>(find.byType(Slider));
        slider.onChangeStart?.call(50000);

        // THEN
        expect(pauseCount, 0);
      },
    );
  });
}

const _state = PlayerState(
  status: PlayerStatus.ready,
  isPlaying: true,
  chapterPosition: Duration(seconds: 40),
  chapterDuration: Duration(minutes: 2),
  speed: 1,
);
