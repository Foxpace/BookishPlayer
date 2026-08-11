import 'package:bookish_player/app/app_bootstrapper.dart';
import 'package:bookish_player/core/di/injection.dart';
import 'package:bookish_player/features/player/repos/player_bootstrap.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

void main() {
  group('Fresh isolated GetIt container', () {
    late GetIt container;

    setUp(() {
      container = GetIt.asNewInstance();
    });

    tearDown(() => container.reset(dispose: true));

    test(
      'Given a fresh isolated GetIt container, When test dependencies and fake platform ports are configured, Then bootstrap resolves without opening production platform services',
      () async {
        // GIVEN
        await configureDependencies(container: container, environment: 'test');
        final calls = <String>[];
        container
          ..registerLazySingleton<AudioServiceBootstrap>(
            () => _FakeAudioBootstrap(calls),
          )
          ..registerLazySingleton<CarPlayBootstrap>(
            () => _FakeCarPlayBootstrap(calls),
          );

        final bootstrapper = container<AppBootstrapper>();
        // WHEN
        await bootstrapper.initialize();

        // THEN
        expect(calls, ['audio', 'carPlay']);
        expect(container.currentScopeName, 'baseScope');
      },
    );
  });
}

class _FakeAudioBootstrap implements AudioServiceBootstrap {
  _FakeAudioBootstrap(this.calls);

  final List<String> calls;

  @override
  Future<void> initialize() async {
    calls.add('audio');
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
