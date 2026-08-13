import 'package:audio_service/audio_service.dart';
import 'package:injectable/injectable.dart';
import 'package:just_audio/just_audio.dart';

import '../../../library/repos/audiobook_catalog_repository.dart';
import '../../use_cases/playback_command_service.dart';
import '../player_bootstrap.dart';
import 'bookish_audio_handler.dart';
import 'just_audio_player_repository.dart';

@Environment('prod')
@LazySingleton(as: AudioServiceBootstrap)
class BookishAudioServiceBootstrap implements AudioServiceBootstrap {
  BookishAudioServiceBootstrap(
    this._player,
    this._repository,
    this._catalog,
    this._commands,
  );

  final AudioPlayer _player;
  final JustAudioPlayerRepository _repository;
  final AudiobookCatalogRepository _catalog;
  final PlaybackCommandService _commands;

  @override
  Future<void> initialize() async {
    final handler = await AudioService.init(
      builder: () => BookishAudioHandler(_player, _catalog, _commands),
      config: const AudioServiceConfig(
        androidNotificationChannelId: 'com.tomasrepcik.bookish.audio',
        androidNotificationChannelName: 'Bookish playback',
        androidNotificationIcon: 'drawable/ic_launcher_monochrome',
        androidStopForegroundOnPause: false,
        fastForwardInterval: BookishAudioHandler.skipInterval,
        rewindInterval: BookishAudioHandler.skipInterval,
      ),
    );
    _repository.attachAudioHandler(handler);
  }
}
