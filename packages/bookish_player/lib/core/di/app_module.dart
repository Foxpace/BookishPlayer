import 'package:injectable/injectable.dart';
import 'package:just_audio/just_audio.dart';
import 'package:go_router/go_router.dart';

import '../../features/library/repos/audiobook_catalog_repository.dart';
import '../../features/library/repos/audiobook_repository.dart';
import '../../features/notes/repos/book_note_repository.dart';
import '../../features/library/repos/book_metadata_repository.dart';
import '../../features/library/repos/observable_audiobook_catalog_repository.dart';
import '../../features/library/repos/implementations/sembast_audiobook_repository.dart';
import '../../features/player/repos/implementations/player_audio_repository.dart';
import '../../features/player/repos/audio_player_repository.dart';
import '../database/bookish_database.dart';
import '../navigation/app_navigation.dart';

@module
abstract class AppModule {
  @Environment('prod')
  @preResolve
  Future<BookishDatabase> provideDatabase() => BookishDatabase.open();

  @lazySingleton
  AudiobookRepository provideAudiobookRepository(
    SembastAudiobookRepository repository,
  ) => repository;

  @lazySingleton
  AudiobookCatalogRepository provideAudiobookCatalog(
    SembastAudiobookRepository repository,
  ) => repository;

  @lazySingleton
  BookNoteRepository provideBookNotes(SembastAudiobookRepository repository) =>
      repository;

  @lazySingleton
  BookMetadataRepository provideBookMetadata(
    SembastAudiobookRepository repository,
  ) => repository;

  @lazySingleton
  ObservableAudiobookCatalogRepository provideObservableAudiobookCatalog(
    SembastAudiobookRepository repository,
  ) => repository;

  @Environment('prod')
  @lazySingleton
  AndroidLoudnessEnhancer provideLoudnessEnhancer() =>
      AndroidLoudnessEnhancer();

  @Environment('prod')
  @lazySingleton
  AndroidEqualizer provideEqualizer() => AndroidEqualizer();

  @Environment('prod')
  @lazySingleton
  AudioPlayer provideAudioPlayer(
    AndroidLoudnessEnhancer loudnessEnhancer,
    AndroidEqualizer equalizer,
  ) => AudioPlayer(
    maxSkipsOnError: 3,
    audioPipeline: AudioPipeline(
      androidAudioEffects: [loudnessEnhancer, equalizer],
    ),
  );

  @lazySingleton
  GoRouter provideRouter() => createAppRouter();

  @Environment('prod')
  @preResolve
  Future<JustAudioPlayerRepository> provideJustAudioPlayerRepository(
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

  @Environment('prod')
  @lazySingleton
  AudioPlayerRepository provideAudioPlayerRepository(
    JustAudioPlayerRepository repository,
  ) => repository;
}
