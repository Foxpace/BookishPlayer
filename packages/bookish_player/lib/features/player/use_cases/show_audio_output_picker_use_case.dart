import 'package:injectable/injectable.dart';

import '../repos/audio_output_picker.dart';

@lazySingleton
class ShowAudioOutputPickerUseCase {
  const ShowAudioOutputPickerUseCase(this._picker);

  final AudioOutputPicker _picker;

  Future<void> call() => _picker.showAudioOutputPicker();
}
