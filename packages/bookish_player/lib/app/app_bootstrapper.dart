import 'package:injectable/injectable.dart';

import '../features/player/repos/player_bootstrap.dart';

@lazySingleton
class AppBootstrapper {
  AppBootstrapper(this._audioService, this._carPlay);

  final AudioServiceBootstrap _audioService;
  final CarPlayBootstrap _carPlay;
  Future<void>? _initialization;

  Future<void> initialize() => _initialization ??= _initialize();

  Future<void> _initialize() async {
    try {
      await Future.wait([_audioService.initialize(), _carPlay.initialize()]);
    } catch (error, stackTrace) {
      _throwInitializationFailure(error, stackTrace);
    }
  }

  Never _throwInitializationFailure(Object error, StackTrace stackTrace) {
    _initialization = null;
    Error.throwWithStackTrace(error, stackTrace);
  }
}
