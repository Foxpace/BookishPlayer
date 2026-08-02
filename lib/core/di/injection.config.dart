// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:bookish_player/core/database/bookish_database.dart' as _i987;
import 'package:bookish_player/core/di/app_module.dart' as _i249;
import 'package:bookish_player/features/editing/presentation/metadata_editor_cubit.dart'
    as _i778;
import 'package:bookish_player/features/importing/data/device_file_import_repository.dart'
    as _i979;
import 'package:bookish_player/features/importing/data/embedded_audiobook_metadata_extractor.dart'
    as _i674;
import 'package:bookish_player/features/importing/data/iso_bmff_m4b_chapter_parser.dart'
    as _i138;
import 'package:bookish_player/features/importing/data/metadata_audiobook_artwork_extractor.dart'
    as _i913;
import 'package:bookish_player/features/importing/data/system_import_diagnostics_repository.dart'
    as _i814;
import 'package:bookish_player/features/importing/domain/audiobook_artwork_extractor.dart'
    as _i556;
import 'package:bookish_player/features/importing/domain/audiobook_metadata_extractor.dart'
    as _i25;
import 'package:bookish_player/features/importing/domain/file_import_repository.dart'
    as _i550;
import 'package:bookish_player/features/importing/domain/import_diagnostics_repository.dart'
    as _i955;
import 'package:bookish_player/features/importing/domain/m4b_chapter_parser.dart'
    as _i545;
import 'package:bookish_player/features/importing/presentation/import_cubit.dart'
    as _i785;
import 'package:bookish_player/features/library/data/audiobook_dao.dart'
    as _i619;
import 'package:bookish_player/features/library/data/sembast_audiobook_repository.dart'
    as _i685;
import 'package:bookish_player/features/library/domain/audiobook_repository.dart'
    as _i972;
import 'package:bookish_player/features/library/presentation/library_cubit.dart'
    as _i1055;
import 'package:bookish_player/features/player/domain/audio_player_repository.dart'
    as _i712;
import 'package:bookish_player/features/player/presentation/player_cubit.dart'
    as _i781;
import 'package:bookish_player/features/portability/data/file_picker_local_export_repository.dart'
    as _i40;
import 'package:bookish_player/features/portability/domain/local_export_repository.dart'
    as _i23;
import 'package:bookish_player/features/portability/presentation/portability_cubit.dart'
    as _i1009;
import 'package:bookish_player/features/settings/data/sembast_settings_repository.dart'
    as _i681;
import 'package:bookish_player/features/settings/data/settings_dao.dart'
    as _i443;
import 'package:bookish_player/features/settings/domain/settings_repository.dart'
    as _i856;
import 'package:bookish_player/features/settings/presentation/settings_cubit.dart'
    as _i700;
import 'package:bookish_player/features/settings/presentation/speech_models_cubit.dart'
    as _i807;
import 'package:bookish_player/features/transcription/data/cactus_transcription_repository.dart'
    as _i687;
import 'package:bookish_player/features/transcription/domain/transcription_repository.dart'
    as _i1058;
import 'package:get_it/get_it.dart' as _i174;
import 'package:go_router/go_router.dart' as _i583;
import 'package:injectable/injectable.dart' as _i526;
import 'package:just_audio/just_audio.dart' as _i501;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    await gh.factoryAsync<_i987.BookishDatabase>(
      () => appModule.database,
      preResolve: true,
    );
    gh.lazySingleton<_i501.AudioPlayer>(() => appModule.audioPlayer);
    gh.lazySingleton<_i583.GoRouter>(() => appModule.router);
    gh.lazySingleton<_i1058.TranscriptionRepository>(
      () => _i687.CactusTranscriptionRepository(),
    );
    gh.lazySingleton<_i619.AudiobookDao>(
      () => _i619.AudiobookDao(gh<_i987.BookishDatabase>()),
    );
    gh.lazySingleton<_i443.SettingsDao>(
      () => _i443.SettingsDao(gh<_i987.BookishDatabase>()),
    );
    gh.lazySingleton<_i25.AudiobookMetadataExtractor>(
      () => _i674.EmbeddedAudiobookMetadataExtractor(),
    );
    gh.lazySingleton<_i23.LocalExportRepository>(
      () => _i40.FilePickerLocalExportRepository(),
    );
    gh.lazySingleton<_i556.AudiobookArtworkExtractor>(
      () => _i913.MetadataAudiobookArtworkExtractor(),
    );
    gh.lazySingleton<_i550.FileImportRepository>(
      () => _i979.DeviceFileImportRepository(),
    );
    gh.lazySingleton<_i972.AudiobookRepository>(
      () => _i685.SembastAudiobookRepository(gh<_i619.AudiobookDao>()),
    );
    gh.lazySingleton<_i545.M4bChapterParser>(
      () => _i138.IsoBmffM4bChapterParser(),
    );
    gh.factory<_i778.MetadataEditorCubit>(
      () => _i778.MetadataEditorCubit(
        gh<_i972.AudiobookRepository>(),
        gh<_i550.FileImportRepository>(),
      ),
    );
    gh.lazySingleton<_i955.ImportDiagnosticsRepository>(
      () => _i814.SystemImportDiagnosticsRepository(),
    );
    gh.lazySingleton<_i856.SettingsRepository>(
      () => _i681.SembastSettingsRepository(gh<_i443.SettingsDao>()),
    );
    gh.factory<_i1009.PortabilityCubit>(
      () => _i1009.PortabilityCubit(
        gh<_i972.AudiobookRepository>(),
        gh<_i856.SettingsRepository>(),
        gh<_i23.LocalExportRepository>(),
      ),
    );
    gh.factory<_i807.SpeechModelsCubit>(
      () => _i807.SpeechModelsCubit(
        gh<_i1058.TranscriptionRepository>(),
        gh<_i443.SettingsDao>(),
      ),
    );
    await gh.factoryAsync<_i712.AudioPlayerRepository>(
      () => appModule.playerRepository(gh<_i501.AudioPlayer>()),
      preResolve: true,
    );
    gh.factory<_i1055.LibraryCubit>(
      () => _i1055.LibraryCubit(
        gh<_i972.AudiobookRepository>(),
        gh<_i550.FileImportRepository>(),
        gh<_i556.AudiobookArtworkExtractor>(),
      ),
    );
    gh.lazySingleton<_i781.PlayerCubit>(
      () => _i781.PlayerCubit(
        gh<_i712.AudioPlayerRepository>(),
        gh<_i972.AudiobookRepository>(),
        gh<_i23.LocalExportRepository>(),
      ),
    );
    gh.factory<_i785.ImportCubit>(
      () => _i785.ImportCubit(
        gh<_i550.FileImportRepository>(),
        gh<_i712.AudioPlayerRepository>(),
        gh<_i972.AudiobookRepository>(),
        gh<_i545.M4bChapterParser>(),
        gh<_i556.AudiobookArtworkExtractor>(),
        gh<_i25.AudiobookMetadataExtractor>(),
        gh<_i955.ImportDiagnosticsRepository>(),
      ),
    );
    gh.lazySingleton<_i700.SettingsCubit>(
      () => _i700.SettingsCubit(gh<_i856.SettingsRepository>()),
    );
    return this;
  }
}

class _$AppModule extends _i249.AppModule {}
