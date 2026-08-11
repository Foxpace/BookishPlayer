import 'package:bookish_player/core/presentation/app_message.dart';
import 'package:bookish_player/features/notes/repos/voice_note_transcription_repository.dart';
import 'package:bookish_player/features/notes/cubits/voice_note_cubit.dart';
import 'package:bookish_player/features/notes/cubits/notes_cubits.dart';
import 'package:flutter_test/flutter_test.dart';

import 'notes_test_builder.dart';

void main() {
  group('Voice-note transcription port', () {
    late _FakeSpeech speech;
    late VoiceNoteCubit sut;

    setUp(() {
      speech = _FakeSpeech();
      sut = createVoiceNoteCubit(speech);
    });

    tearDown(() => sut.close());

    test(
      'Given a voice-note transcription port, When listening starts, updates, and stops, Then immutable state follows the spoken text lifecycle',
      () async {
        // GIVEN
        await sut.toggle();
        speech.emitText('Remember this');
        // WHEN
        await sut.toggle();

        // THEN
        expect(sut.state.status, VoiceNoteStatus.idle);
        expect(sut.state.text, 'Remember this');
        expect(speech.stopCalls, 1);
      },
    );

    test(
      'Given a voice-note transcription port, When speech recognition is unavailable or fails, Then typed revisioned failures are emitted',
      () async {
        // GIVEN
        speech.available = false;
        // WHEN
        await sut.toggle();
        // THEN
        expect(sut.state.message, AppMessage.speechRecognitionUnavailable);
        expect(sut.state.effectRevision, 1);

        speech.available = true;
        await sut.toggle();
        speech.emitError('failed');
        expect(sut.state.message, AppMessage.speechRecognitionFailed);
        expect(sut.state.effectRevision, 2);
      },
    );
  });
}

class _FakeSpeech implements VoiceNoteTranscriptionRepository {
  var available = true;
  var stopCalls = 0;
  void Function(String)? _onError;
  void Function()? _onDone;
  void Function(String)? _onText;

  @override
  Future<bool> initialize({
    required void Function(String message) onError,
    required void Function() onDone,
  }) async {
    _onError = onError;
    _onDone = onDone;
    return available;
  }

  @override
  Future<void> listen(void Function(String text) onText) async {
    _onText = onText;
  }

  @override
  Future<void> stop() async {
    stopCalls++;
  }

  void emitText(String value) => _onText?.call(value);

  void emitError(String value) => _onError?.call(value);

  void emitDone() => _onDone?.call();
}
