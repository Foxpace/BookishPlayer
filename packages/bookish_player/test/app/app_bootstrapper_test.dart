import 'dart:async';

import 'package:bookish_player/app/app_bootstrapper.dart';
import 'package:bookish_player/features/player/repos/player_bootstrap.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppBootstrapper', () {
    late List<String> calls;
    late _FakeAudioServiceBootstrap audio;
    late AppBootstrapper sut;

    setUp(() {
      calls = [];
      audio = _FakeAudioServiceBootstrap(calls);
      sut = AppBootstrapper(audio, _FakeCarPlayBootstrap(calls));
    });

    test(
      'Given an uninitialized application, When startup is requested twice, Then audio and CarPlay initialize concurrently once',
      () async {
        // GIVEN
        final audioCompletion = Completer<void>();
        audio.completion = audioCompletion;

        // WHEN
        final first = sut.initialize();
        final second = sut.initialize();

        await Future<void>.delayed(Duration.zero);

        // THEN
        expect(calls, ['audio', 'carPlay']);

        audioCompletion.complete();
        await (first, second).wait;
        await sut.initialize();

        expect(calls, ['audio', 'carPlay']);
      },
    );
    test(
      'Given audio-service startup fails, When startup is retried after the failure is removed, Then all startup parts are retried',
      () async {
        // GIVEN
        audio.failure = StateError('audio');

        // WHEN
        await expectLater(sut.initialize(), throwsStateError);
        audio.failure = null;
        await sut.initialize();

        // THEN
        expect(calls, ['audio', 'carPlay', 'audio', 'carPlay']);
      },
    );
  });
}

class _FakeAudioServiceBootstrap implements AudioServiceBootstrap {
  _FakeAudioServiceBootstrap(this.calls);

  final List<String> calls;
  StateError? failure;
  Completer<void>? completion;

  @override
  Future<void> initialize() async {
    calls.add('audio');
    if (failure case final error?) {
      throw error;
    }
    await completion?.future;
  }
}

class _FakeCarPlayBootstrap implements CarPlayBootstrap {
  _FakeCarPlayBootstrap(this.calls);

  final List<String> calls;

  @override
  Future<void> initialize() async {
    calls.add('carPlay');
  }
}
