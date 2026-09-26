import 'package:flutter_bloc/flutter_bloc.dart';

class SleepTimerDurationCubit extends Cubit<int> {
  SleepTimerDurationCubit({int? remainingMinutes})
    : super((remainingMinutes ?? 30).clamp(1, 120));

  void chooseMinutes(double minutes) => emit(minutes.round().clamp(1, 120));
}
