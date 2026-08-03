import 'package:injectable/injectable.dart';
import 'package:just_audio/just_audio.dart';
import 'package:go_router/go_router.dart';

import '../../features/library/domain/audiobook_catalog_repository.dart';
import '../../features/library/domain/audiobook_repository.dart';
import '../../features/library/domain/book_note_repository.dart';
import '../../features/library/domain/listening_history_repository.dart';
import '../../features/library/domain/observable_audiobook_catalog_repository.dart';
import '../../features/library/data/sembast_audiobook_repository.dart';
import '../../features/player/data/just_audio_player_repository.dart';
import '../../features/player/domain/audio_player_repository.dart';
import '../database/bookish_database.dart';
import '../navigation/app_router.dart';

@module
abstract class AppModule {
  @preResolve
  Future<BookishDatabase> get database => BookishDatabase.open();

  @lazySingleton
  AudiobookCatalogRepository audiobookCatalog(AudiobookRepository repository) =>
      repository;

  @lazySingleton
  BookNoteRepository bookNotes(AudiobookRepository repository) => repository;

  @lazySingleton
  ListeningHistoryRepository listeningHistory(AudiobookRepository repository) =>
      repository;

  @lazySingleton
  ObservableAudiobookCatalogRepository observableAudiobookCatalog(
    AudiobookRepository repository,
  ) => repository as SembastAudiobookRepository;

  @lazySingleton
  AndroidLoudnessEnhancer get loudnessEnhancer => AndroidLoudnessEnhancer();

  @lazySingleton
  AndroidEqualizer get equalizer => AndroidEqualizer();

  @lazySingleton
  AudioPlayer audioPlayer(
    AndroidLoudnessEnhancer loudnessEnhancer,
    AndroidEqualizer equalizer,
  ) => AudioPlayer(
    maxSkipsOnError: 3,
    audioPipeline: AudioPipeline(
      androidAudioEffects: [loudnessEnhancer, equalizer],
    ),
  );

  @lazySingleton
  GoRouter get router => createAppRouter();

  @preResolve
  Future<AudioPlayerRepository> playerRepository(
    AudioPlayer player,
    AndroidLoudnessEnhancer loudnessEnhancer,
    AndroidEqualizer equalizer,
  ) async {
    final repository = JustAudioPlayerRepository(
      player,
      loudnessEnhancer,
      equalizer,
    );
    await repository.configure();
    return repository;
  }
}
