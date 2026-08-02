import 'package:injectable/injectable.dart';
import 'package:just_audio/just_audio.dart';
import 'package:go_router/go_router.dart';

import '../../features/player/data/just_audio_player_repository.dart';
import '../../features/player/domain/audio_player_repository.dart';
import '../database/bookish_database.dart';
import '../navigation/app_router.dart';

@module
abstract class AppModule {
  @preResolve
  Future<BookishDatabase> get database => BookishDatabase.open();

  @lazySingleton
  AudioPlayer get audioPlayer => AudioPlayer(maxSkipsOnError: 3);

  @lazySingleton
  GoRouter get router => createAppRouter();

  @preResolve
  Future<AudioPlayerRepository> playerRepository(AudioPlayer player) async {
    final repository = JustAudioPlayerRepository(player);
    await repository.configure();
    return repository;
  }
}
