import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

import '../../../../core/localization/generated/l10n.dart';
import '../../cubits/sleep_timer_duration_cubit.dart';

class SleepTimerDurationSlider extends StatelessWidget {
  const SleepTimerDurationSlider({required this.onSelected, super.key});

  final ValueChanged<Duration> onSelected;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SleepTimerDurationCubit, int>(
      builder: (context, minutes) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            S.of(context).minutesShort(minutes),
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          Slider(
            value: minutes.toDouble(),
            min: 1,
            max: 120,
            divisions: 119,
            label: S.of(context).minutesShort(minutes),
            semanticFormatterCallback: (value) =>
                S.of(context).minutesShort(value.round()),
            onChanged: context.read<SleepTimerDurationCubit>().chooseMinutes,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(S.of(context).minutesShort(1)),
              Text(S.of(context).minutesShort(120)),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: () => onSelected(Duration(minutes: minutes)),
              child: Text(S.of(context).acceptSleepTimer),
            ),
          ),
        ],
      ),
    );
  }
}
