import 'package:injectable/injectable.dart';

import '../domain/audio_output_picker.dart';
import 'car_play_api.g.dart';

@LazySingleton(as: AudioOutputPicker)
class SystemAudioOutputPicker implements AudioOutputPicker {
  final _host = AudioOutputHostApi();

  @override
  Future<void> show() => _host.showPicker();
}
