import 'package:injectable/injectable.dart';

import 'player_lifecycle_use_cases.dart';
import 'player_note_use_cases.dart';
import 'player_sleep_use_cases.dart';
import 'player_transport_use_cases.dart';
import 'show_audio_output_picker_use_case.dart';

@lazySingleton
class PlayerUseCases {
  const PlayerUseCases({
    required this.lifecycle,
    required this.notes,
    required this.sleep,
    required this.transport,
    required this.showAudioOutputPicker,
  });

  final PlayerLifecycleUseCases lifecycle;
  final PlayerNoteUseCases notes;
  final PlayerSleepUseCases sleep;
  final PlayerTransportUseCases transport;
  final ShowAudioOutputPickerUseCase showAudioOutputPicker;
}
