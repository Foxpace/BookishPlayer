import 'package:injectable/injectable.dart';

import '../audio_output_picker.dart';
import 'car_play_api.g.dart';

@LazySingleton(as: AudioOutputPicker)
class SystemAudioOutputPicker implements AudioOutputPicker {
  final _host = AudioOutputHostApi();

  @override
  Future<void> showAudioOutputPicker() => _host.showPicker();
}
