import 'package:bookish_player/features/player/cubits/sleep_timer_duration_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Given no timer, When choosing minutes, Then the draft changes', () {
    final cubit = SleepTimerDurationCubit();
    addTearDown(cubit.close);
    expect(cubit.state, 30);

    cubit.chooseMinutes(22);

    expect(cubit.state, 22);
  });

  test(
    'Given an active timer, When opening, Then its minutes are selected',
    () {
      final cubit = SleepTimerDurationCubit(remainingMinutes: 42);
      addTearDown(cubit.close);

      expect(cubit.state, 42);
    },
  );

  for (final example in [(0, 1), (180, 120)]) {
    test(
      'Given ${example.$1} minutes, When opening, Then selection is bounded',
      () {
        final cubit = SleepTimerDurationCubit(remainingMinutes: example.$1);
        addTearDown(cubit.close);

        expect(cubit.state, example.$2);
      },
    );
  }
}
