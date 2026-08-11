import 'package:injectable/injectable.dart';

import '../../../library/repos/observable_audiobook_catalog_repository.dart';
import '../../use_cases/playback_command_service.dart';
import '../player_bootstrap.dart';
import 'pigeon_car_play_bridge.dart';

@Environment('prod')
@LazySingleton(as: CarPlayBootstrap)
class PigeonCarPlayBootstrap implements CarPlayBootstrap {
  PigeonCarPlayBootstrap(this._catalog, this._commands);

  final ObservableAudiobookCatalogRepository _catalog;
  final PlaybackCommandService _commands;

  @override
  Future<void> initialize() =>
      PigeonCarPlayBridge(_catalog, _commands).initialize();
}
