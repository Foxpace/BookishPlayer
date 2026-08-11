// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:bookish_player/app/app_bootstrapper.dart' as _i945;
import 'package:bookish_player/core/database/bookish_database.dart' as _i987;
import 'package:bookish_player/core/di/app_module.dart' as _i249;
import 'package:bookish_player/core/diagnostics/app_diagnostics.dart' as _i29;
import 'package:bookish_player/core/diagnostics/app_error_handler.dart'
    as _i941;
import 'package:bookish_player/core/diagnostics/app_support_diagnostics_file_provider.dart'
    as _i276;
import 'package:bookish_player/core/diagnostics/diagnostics_file_provider.dart'
    as _i0;
import 'package:bookish_player/core/diagnostics/local_app_diagnostics.dart'
    as _i270;
import 'package:bookish_player/core/foundation/clock.dart' as _i1031;
import 'package:bookish_player/core/foundation/id_generator.dart' as _i315;
import 'package:bookish_player/core/foundation/system_clock.dart' as _i1025;
import 'package:bookish_player/core/foundation/uuid_generator.dart' as _i639;
import 'package:bookish_player/core/platform/file_picker_gateway.dart' as _i417;
import 'package:bookish_player/core/platform/platform_file_picker_gateway.dart'
    as _i298;
import 'package:bookish_player/features/editing/cubits/metadata_editor_cubit.dart'
    as _i1000;
import 'package:bookish_player/features/editing/repos/book_editing_repository.dart'
    as _i193;
import 'package:bookish_player/features/editing/repos/implementations/library_book_editing_repository.dart'
    as _i937;
import 'package:bookish_player/features/editing/use_cases/add_book_chapter_use_case.dart'
    as _i278;
import 'package:bookish_player/features/editing/use_cases/change_book_cover_use_case.dart'
    as _i798;
import 'package:bookish_player/features/editing/use_cases/delete_book_chapter_use_case.dart'
    as _i997;
import 'package:bookish_player/features/editing/use_cases/edit_book_details_use_case.dart'
    as _i249;
import 'package:bookish_player/features/editing/use_cases/editing_use_cases.dart'
    as _i121;
import 'package:bookish_player/features/editing/use_cases/editing_use_cases_barrel.dart'
    as _i498;
import 'package:bookish_player/features/editing/use_cases/reorder_book_tracks_use_case.dart'
    as _i428;
import 'package:bookish_player/features/importing/cubits/import_cubit.dart'
    as _i218;
import 'package:bookish_player/features/importing/repos/audiobook_artwork_extractor.dart'
    as _i1002;
import 'package:bookish_player/features/importing/repos/audiobook_metadata_extractor.dart'
    as _i361;
import 'package:bookish_player/features/importing/repos/implementations/audio_player_media_probe.dart'
    as _i773;
import 'package:bookish_player/features/importing/repos/implementations/device_file_import_repository.dart'
    as _i158;
import 'package:bookish_player/features/importing/repos/implementations/embedded_audiobook_metadata_extractor.dart'
    as _i263;
import 'package:bookish_player/features/importing/repos/implementations/iso_bmff_m4b_chapter_parser.dart'
    as _i791;
import 'package:bookish_player/features/importing/repos/implementations/metadata_audiobook_artwork_extractor.dart'
    as _i815;
import 'package:bookish_player/features/importing/repos/implementations/system_import_diagnostics_repository.dart'
    as _i391;
import 'package:bookish_player/features/importing/repos/import_diagnostics_repository.dart'
    as _i993;
import 'package:bookish_player/features/importing/repos/import_repositories.dart'
    as _i938;
import 'package:bookish_player/features/importing/repos/m4b_chapter_parser.dart'
    as _i454;
import 'package:bookish_player/features/importing/repos/media_probe.dart'
    as _i259;
import 'package:bookish_player/features/importing/use_cases/audiobook_import_workflow.dart'
    as _i160;
import 'package:bookish_player/features/importing/use_cases/copy_import_diagnostics_use_case.dart'
    as _i106;
import 'package:bookish_player/features/importing/use_cases/import_cleanup.dart'
    as _i158;
import 'package:bookish_player/features/importing/use_cases/import_source_gateway.dart'
    as _i1063;
import 'package:bookish_player/features/importing/use_cases/import_use_cases.dart'
    as _i309;
import 'package:bookish_player/features/importing/use_cases/imported_book_saver.dart'
    as _i703;
import 'package:bookish_player/features/importing/use_cases/importing_use_cases.dart'
    as _i717;
import 'package:bookish_player/features/importing/use_cases/remove_transferred_sources_use_case.dart'
    as _i233;
import 'package:bookish_player/features/insights/cubits/listening_insights_cubit.dart'
    as _i411;
import 'package:bookish_player/features/insights/repos/implementations/library_listening_insights_repository.dart'
    as _i848;
import 'package:bookish_player/features/insights/repos/listening_insights_repository.dart'
    as _i316;
import 'package:bookish_player/features/insights/use_cases/insights_use_cases.dart'
    as _i811;
import 'package:bookish_player/features/insights/use_cases/load_listening_insights_use_case.dart'
    as _i517;
import 'package:bookish_player/features/library/repos/audiobook_catalog_repository.dart'
    as _i564;
import 'package:bookish_player/features/library/repos/audiobook_repository.dart'
    as _i55;
import 'package:bookish_player/features/library/repos/book_metadata_repository.dart'
    as _i167;
import 'package:bookish_player/features/library/repos/implementations/audiobook_dao.dart'
    as _i698;
import 'package:bookish_player/features/library/repos/implementations/listening_history_dao.dart'
    as _i712;
import 'package:bookish_player/features/library/repos/implementations/sembast_audiobook_repository.dart'
    as _i465;
import 'package:bookish_player/features/library/repos/listening_history_repository.dart'
    as _i276;
import 'package:bookish_player/features/library/repos/observable_audiobook_catalog_repository.dart'
    as _i958;
import 'package:bookish_player/features/library/use_cases/library_use_cases.dart'
    as _i751;
import 'package:bookish_player/features/library/use_cases/load_library_use_case.dart'
    as _i877;
import 'package:bookish_player/features/library/use_cases/remove_audiobook_use_case.dart'
    as _i983;
import 'package:bookish_player/features/library/use_cases/save_library_book_use_case.dart'
    as _i938;
import 'package:bookish_player/features/notes/cubits/note_gallery_cubit.dart'
    as _i977;
import 'package:bookish_player/features/notes/cubits/voice_note_cubit.dart'
    as _i661;
import 'package:bookish_player/features/notes/repos/book_note_repository.dart'
    as _i355;
import 'package:bookish_player/features/notes/repos/implementations/speech_to_text_voice_note_repository.dart'
    as _i291;
import 'package:bookish_player/features/notes/repos/voice_note_transcription_repository.dart'
    as _i60;
import 'package:bookish_player/features/notes/use_cases/note_gallery_use_cases.dart'
    as _i134;
import 'package:bookish_player/features/notes/use_cases/note_use_case_bundle.dart'
    as _i152;
import 'package:bookish_player/features/notes/use_cases/player_notes_service.dart'
    as _i177;
import 'package:bookish_player/features/notes/use_cases/stop_voice_note_use_case.dart'
    as _i510;
import 'package:bookish_player/features/notes/use_cases/update_gallery_note_use_case.dart'
    as _i595;
import 'package:bookish_player/features/notes/use_cases/voice_note_use_cases.dart'
    as _i363;
import 'package:bookish_player/features/player/cubits/player_cubit.dart'
    as _i948;
import 'package:bookish_player/features/player/cubits/player_playback_streams.dart'
    as _i163;
import 'package:bookish_player/features/player/cubits/player_state_factory.dart'
    as _i570;
import 'package:bookish_player/features/player/repos/audio_output_picker.dart'
    as _i759;
import 'package:bookish_player/features/player/repos/audio_player_repository.dart'
    as _i1014;
import 'package:bookish_player/features/player/repos/implementations/bookish_audio_service_bootstrap.dart'
    as _i129;
import 'package:bookish_player/features/player/repos/implementations/just_audio_player_repository.dart'
    as _i434;
import 'package:bookish_player/features/player/repos/implementations/pigeon_car_play_bootstrap.dart'
    as _i271;
import 'package:bookish_player/features/player/repos/implementations/player_audio_repository.dart'
    as _i437;
import 'package:bookish_player/features/player/repos/implementations/share_plus_quote_share_repository.dart'
    as _i540;
import 'package:bookish_player/features/player/repos/implementations/system_audio_output_picker.dart'
    as _i769;
import 'package:bookish_player/features/player/repos/player_bootstrap.dart'
    as _i58;
import 'package:bookish_player/features/player/repos/player_repositories.dart'
    as _i122;
import 'package:bookish_player/features/player/use_cases/chapter_navigation_policy.dart'
    as _i479;
import 'package:bookish_player/features/player/use_cases/listening_session_tracker.dart'
    as _i342;
import 'package:bookish_player/features/player/use_cases/playback_command_service.dart'
    as _i11;
import 'package:bookish_player/features/player/use_cases/playback_resume_policy.dart'
    as _i199;
import 'package:bookish_player/features/player/use_cases/player_lifecycle_policies.dart'
    as _i1024;
import 'package:bookish_player/features/player/use_cases/player_lifecycle_use_cases.dart'
    as _i1068;
import 'package:bookish_player/features/player/use_cases/player_note_use_cases.dart'
    as _i276;
import 'package:bookish_player/features/player/use_cases/player_progress_saver.dart'
    as _i924;
import 'package:bookish_player/features/player/use_cases/player_sleep_use_cases.dart'
    as _i246;
import 'package:bookish_player/features/player/use_cases/player_transport_use_cases.dart'
    as _i369;
import 'package:bookish_player/features/player/use_cases/player_use_cases.dart'
    as _i671;
import 'package:bookish_player/features/player/use_cases/series_continuation_policy.dart'
    as _i626;
import 'package:bookish_player/features/player/use_cases/show_audio_output_picker_use_case.dart'
    as _i579;
import 'package:bookish_player/features/player/use_cases/sleep_timer_use_case.dart'
    as _i903;
import 'package:bookish_player/features/portability/cubits/portability_cubit.dart'
    as _i232;
import 'package:bookish_player/features/portability/repos/backup_store_repository.dart'
    as _i9;
import 'package:bookish_player/features/portability/repos/implementations/file_picker_local_export_repository.dart'
    as _i141;
import 'package:bookish_player/features/portability/repos/implementations/sembast_backup_store_repository.dart'
    as _i462;
import 'package:bookish_player/features/portability/repos/local_export_repository.dart'
    as _i623;
import 'package:bookish_player/features/portability/use_cases/backup_workflow.dart'
    as _i981;
import 'package:bookish_player/features/portability/use_cases/bookish_backup_validator.dart'
    as _i985;
import 'package:bookish_player/features/portability/use_cases/portability_use_case_bundle.dart'
    as _i186;
import 'package:bookish_player/features/portability/use_cases/portability_use_cases.dart'
    as _i1001;
import 'package:bookish_player/features/portability/use_cases/restore_backup_use_case.dart'
    as _i695;
import 'package:bookish_player/features/settings/cubits/settings_cubit.dart'
    as _i621;
import 'package:bookish_player/features/settings/diagnostics/cubits/diagnostics_cubit.dart'
    as _i209;
import 'package:bookish_player/features/settings/diagnostics/repos/diagnostics_export_repository.dart'
    as _i1071;
import 'package:bookish_player/features/settings/diagnostics/repos/implementations/file_picker_diagnostics_export_repository.dart'
    as _i1030;
import 'package:bookish_player/features/settings/diagnostics/use_cases/delete_diagnostics_use_case.dart'
    as _i850;
import 'package:bookish_player/features/settings/diagnostics/use_cases/diagnostics_use_case_bundle.dart'
    as _i124;
import 'package:bookish_player/features/settings/diagnostics/use_cases/diagnostics_use_cases.dart'
    as _i1027;
import 'package:bookish_player/features/settings/diagnostics/use_cases/diagnostics_workflow.dart'
    as _i381;
import 'package:bookish_player/features/settings/repos/implementations/sembast_settings_repository.dart'
    as _i466;
import 'package:bookish_player/features/settings/repos/implementations/settings_dao.dart'
    as _i754;
import 'package:bookish_player/features/settings/repos/settings_repository.dart'
    as _i852;
import 'package:bookish_player/features/settings/use_cases/save_playback_preferences_use_case.dart'
    as _i946;
import 'package:bookish_player/features/settings/use_cases/save_theme_preference_use_case.dart'
    as _i230;
import 'package:bookish_player/features/settings/use_cases/settings_use_case_bundle.dart'
    as _i14;
import 'package:bookish_player/features/settings/use_cases/settings_use_cases.dart'
    as _i981;
import 'package:bookish_player/features/storage/repos/app_data_reset_repository.dart'
    as _i101;
import 'package:bookish_player/features/storage/repos/implementations/device_app_data_reset_repository.dart'
    as _i707;
import 'package:bookish_player/features/storage/repos/implementations/device_library_storage_repository.dart'
    as _i700;
import 'package:bookish_player/features/storage/repos/library_storage_repository.dart'
    as _i681;
import 'package:bookish_player/features/storage/use_cases/clean_orphan_files_use_case.dart'
    as _i781;
import 'package:bookish_player/features/storage/use_cases/clear_bookish_data_use_case.dart'
    as _i652;
import 'package:bookish_player/features/storage/use_cases/remove_missing_book_use_case.dart'
    as _i12;
import 'package:bookish_player/features/storage/use_cases/storage_assistant_workflow.dart'
    as _i1032;
import 'package:bookish_player/features/storage/use_cases/storage_use_cases.dart'
    as _i40;
import 'package:bookish_player/features/transcription/cubits/quote_transcription_cubit.dart'
    as _i1063;
import 'package:bookish_player/features/transcription/cubits/speech_models_cubit.dart'
    as _i627;
import 'package:bookish_player/features/transcription/repos/implementations/cactus_audio_clip_factory.dart'
    as _i766;
import 'package:bookish_player/features/transcription/repos/implementations/cactus_transcription_repository.dart'
    as _i1057;
import 'package:bookish_player/features/transcription/repos/implementations/settings_transcription_preferences.dart'
    as _i345;
import 'package:bookish_player/features/transcription/repos/transcription_preferences.dart'
    as _i304;
import 'package:bookish_player/features/transcription/repos/transcription_repositories.dart'
    as _i190;
import 'package:bookish_player/features/transcription/use_cases/download_speech_model_use_case.dart'
    as _i652;
import 'package:bookish_player/features/transcription/use_cases/quote_transcription_use_cases.dart'
    as _i723;
import 'package:bookish_player/features/transcription/use_cases/read_selected_speech_model_use_case.dart'
    as _i283;
import 'package:bookish_player/features/transcription/use_cases/refresh_speech_models_use_case.dart'
    as _i766;
import 'package:bookish_player/features/transcription/use_cases/select_speech_model_use_case.dart'
    as _i27;
import 'package:bookish_player/features/transcription/use_cases/share_transcription_draft_use_case.dart'
    as _i484;
import 'package:bookish_player/features/transcription/use_cases/speech_model_use_cases.dart'
    as _i237;
import 'package:bookish_player/features/transcription/use_cases/transcription_use_case_bundle.dart'
    as _i877;
import 'package:get_it/get_it.dart' as _i174;
import 'package:go_router/go_router.dart' as _i583;
import 'package:injectable/injectable.dart' as _i526;
import 'package:just_audio/just_audio.dart' as _i501;

const String _prod = 'prod';

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    gh.factory<_i985.BookishBackupValidator>(
      () => const _i985.BookishBackupValidator(),
    );
    gh.lazySingleton<_i583.GoRouter>(() => appModule.provideRouter());
    gh.lazySingleton<_i570.PlayerStateFactory>(
      () => const _i570.PlayerStateFactory(),
    );
    gh.lazySingleton<_i479.ChapterNavigationPolicy>(
      () => const _i479.ChapterNavigationPolicy(),
    );
    gh.lazySingleton<_i626.SeriesContinuationPolicy>(
      () => const _i626.SeriesContinuationPolicy(),
    );
    gh.lazySingleton<_i766.CactusAudioClipFactory>(
      () => const _i766.CactusAudioClipFactory(),
    );
    gh.lazySingleton<_i1002.AudiobookArtworkExtractor>(
      () => _i815.MetadataAudiobookArtworkExtractor(),
    );
    gh.lazySingleton<_i1071.DiagnosticsExportRepository>(
      () => _i1030.FilePickerDiagnosticsExportRepository(),
    );
    gh.lazySingleton<_i315.IdGenerator>(() => const _i639.UuidGenerator());
    gh.lazySingleton<_i454.M4bChapterParser>(
      () => _i791.IsoBmffM4bChapterParser(),
    );
    gh.lazySingleton<_i1031.Clock>(() => const _i1025.SystemClock());
    gh.lazySingleton<_i681.LibraryStorageRepository>(
      () => _i700.DeviceLibraryStorageRepository(),
    );
    gh.lazySingleton<_i0.DiagnosticsFileProvider>(
      () => _i276.AppSupportDiagnosticsFileProvider(),
    );
    gh.lazySingleton<_i759.AudioOutputPicker>(
      () => _i769.SystemAudioOutputPicker(),
    );
    gh.lazySingleton<_i993.ImportDiagnosticsRepository>(
      () => _i391.SystemImportDiagnosticsRepository(),
    );
    gh.lazySingleton<_i361.AudiobookMetadataExtractor>(
      () => _i263.EmbeddedAudiobookMetadataExtractor(),
    );
    gh.lazySingleton<_i199.PlaybackResumePolicy>(
      () => _i199.PlaybackResumePolicy(gh<_i1031.Clock>()),
    );
    gh.lazySingleton<_i122.QuoteShareRepository>(
      () => _i540.SharePlusQuoteShareRepository(),
    );
    gh.lazySingleton<_i29.AppDiagnostics>(
      () => _i270.LocalAppDiagnostics(
        gh<_i1031.Clock>(),
        gh<_i0.DiagnosticsFileProvider>(),
      ),
    );
    gh.lazySingleton<_i941.AppErrorHandler>(
      () => _i941.AppErrorHandler(gh<_i29.AppDiagnostics>()),
    );
    gh.lazySingleton<_i190.TranscriptionRepository>(
      () => _i1057.CactusTranscriptionRepository(
        gh<_i766.CactusAudioClipFactory>(),
      ),
    );
    gh.lazySingleton<_i417.FilePickerGateway>(
      () => _i298.PlatformFilePickerGateway(),
    );
    gh.factory<_i652.DownloadSpeechModelUseCase>(
      () =>
          _i652.DownloadSpeechModelUseCase(gh<_i190.TranscriptionRepository>()),
    );
    gh.factory<_i766.RefreshSpeechModelsUseCase>(
      () =>
          _i766.RefreshSpeechModelsUseCase(gh<_i190.TranscriptionRepository>()),
    );
    gh.factory<_i237.LoadCachedSpeechModelsUseCase>(
      () => _i237.LoadCachedSpeechModelsUseCase(
        gh<_i190.TranscriptionRepository>(),
      ),
    );
    gh.factory<_i484.ShareTranscriptionDraftUseCase>(
      () => _i484.ShareTranscriptionDraftUseCase(
        gh<_i122.QuoteShareRepository>(),
      ),
    );
    gh.factory<_i381.DiagnosticsWorkflow>(
      () => _i381.DiagnosticsWorkflow(
        gh<_i29.AppDiagnostics>(),
        gh<_i1071.DiagnosticsExportRepository>(),
      ),
    );
    gh.lazySingleton<_i938.FileImportRepository>(
      () => _i158.DeviceFileImportRepository(
        gh<_i315.IdGenerator>(),
        gh<_i417.FilePickerGateway>(),
      ),
    );
    await gh.factoryAsync<_i987.BookishDatabase>(
      () => appModule.provideDatabase(),
      registerFor: {_prod},
      preResolve: true,
    );
    gh.lazySingleton<_i501.AndroidLoudnessEnhancer>(
      () => appModule.provideLoudnessEnhancer(),
      registerFor: {_prod},
    );
    gh.lazySingleton<_i501.AndroidEqualizer>(
      () => appModule.provideEqualizer(),
      registerFor: {_prod},
    );
    gh.lazySingleton<_i60.VoiceNoteTranscriptionRepository>(
      () => _i291.SpeechToTextVoiceNoteRepository(),
      registerFor: {_prod},
    );
    gh.factory<_i158.ImportCleanup>(
      () => _i158.ImportCleanup(
        gh<_i938.FileImportRepository>(),
        gh<_i29.AppDiagnostics>(),
      ),
    );
    gh.lazySingleton<_i101.AppDataResetRepository>(
      () => _i707.DeviceAppDataResetRepository(gh<_i987.BookishDatabase>()),
    );
    gh.factory<_i850.DeleteDiagnosticsUseCase>(
      () => _i850.DeleteDiagnosticsUseCase(gh<_i381.DiagnosticsWorkflow>()),
    );
    gh.factory<_i1027.ExportDiagnosticsUseCase>(
      () => _i1027.ExportDiagnosticsUseCase(gh<_i381.DiagnosticsWorkflow>()),
    );
    gh.lazySingleton<_i698.AudiobookDao>(
      () => _i698.AudiobookDao(gh<_i987.BookishDatabase>()),
    );
    gh.lazySingleton<_i754.SettingsDao>(
      () => _i754.SettingsDao(gh<_i987.BookishDatabase>()),
    );
    gh.lazySingleton<_i579.ShowAudioOutputPickerUseCase>(
      () => _i579.ShowAudioOutputPickerUseCase(gh<_i759.AudioOutputPicker>()),
    );
    gh.lazySingleton<_i276.ListeningHistoryRepository>(
      () => _i712.ListeningHistoryDao(gh<_i987.BookishDatabase>()),
    );
    gh.factory<_i106.CopyImportDiagnosticsUseCase>(
      () => _i106.CopyImportDiagnosticsUseCase(
        gh<_i993.ImportDiagnosticsRepository>(),
      ),
    );
    gh.lazySingleton<_i623.LocalExportRepository>(
      () =>
          _i141.FilePickerLocalExportRepository(gh<_i417.FilePickerGateway>()),
    );
    gh.lazySingleton<_i9.BackupStoreRepository>(
      () => _i462.SembastBackupStoreRepository(gh<_i987.BookishDatabase>()),
    );
    gh.lazySingleton<_i501.AudioPlayer>(
      () => appModule.provideAudioPlayer(
        gh<_i501.AndroidLoudnessEnhancer>(),
        gh<_i501.AndroidEqualizer>(),
      ),
      registerFor: {_prod},
    );
    gh.lazySingleton<_i465.SembastAudiobookRepository>(
      () => _i465.SembastAudiobookRepository(gh<_i698.AudiobookDao>()),
    );
    gh.factory<_i510.StopVoiceNoteUseCase>(
      () => _i510.StopVoiceNoteUseCase(
        gh<_i60.VoiceNoteTranscriptionRepository>(),
      ),
    );
    gh.factory<_i363.StartVoiceNoteUseCase>(
      () => _i363.StartVoiceNoteUseCase(
        gh<_i60.VoiceNoteTranscriptionRepository>(),
      ),
    );
    gh.factory<_i981.BackupWorkflow>(
      () => _i981.BackupWorkflow(
        gh<_i9.BackupStoreRepository>(),
        gh<_i623.LocalExportRepository>(),
        gh<_i985.BookishBackupValidator>(),
      ),
    );
    gh.factory<_i363.VoiceNoteUseCases>(
      () => _i363.VoiceNoteUseCases(
        start: gh<_i363.StartVoiceNoteUseCase>(),
        stop: gh<_i510.StopVoiceNoteUseCase>(),
      ),
    );
    gh.factory<_i1027.DiagnosticsUseCases>(
      () => _i1027.DiagnosticsUseCases(
        gh<_i1027.ExportDiagnosticsUseCase>(),
        gh<_i850.DeleteDiagnosticsUseCase>(),
      ),
    );
    gh.lazySingleton<_i852.SettingsRepository>(
      () => _i466.SembastSettingsRepository(gh<_i754.SettingsDao>()),
    );
    gh.factory<_i946.SavePlaybackPreferencesUseCase>(
      () =>
          _i946.SavePlaybackPreferencesUseCase(gh<_i852.SettingsRepository>()),
    );
    gh.factory<_i230.SaveThemePreferenceUseCase>(
      () => _i230.SaveThemePreferenceUseCase(gh<_i852.SettingsRepository>()),
    );
    gh.factory<_i981.LoadSettingsUseCase>(
      () => _i981.LoadSettingsUseCase(gh<_i852.SettingsRepository>()),
    );
    gh.factory<_i661.VoiceNoteCubit>(
      () => _i661.VoiceNoteCubit(gh<_i152.VoiceNoteUseCases>()),
    );
    gh.factory<_i1001.ExportBackupUseCase>(
      () => _i1001.ExportBackupUseCase(gh<_i981.BackupWorkflow>()),
    );
    gh.factory<_i695.RestoreBackupUseCase>(
      () => _i695.RestoreBackupUseCase(gh<_i981.BackupWorkflow>()),
    );
    gh.factory<_i342.ListeningSessionTracker>(
      () => _i342.ListeningSessionTracker(
        gh<_i276.ListeningHistoryRepository>(),
        gh<_i1031.Clock>(),
        gh<_i315.IdGenerator>(),
      ),
    );
    gh.factory<_i1001.PortabilityUseCases>(
      () => _i1001.PortabilityUseCases(
        gh<_i1001.ExportBackupUseCase>(),
        gh<_i695.RestoreBackupUseCase>(),
      ),
    );
    gh.factory<_i751.SaveLibraryLayoutUseCase>(
      () => _i751.SaveLibraryLayoutUseCase(gh<_i852.SettingsRepository>()),
    );
    gh.lazySingleton<_i55.AudiobookRepository>(
      () => appModule.provideAudiobookRepository(
        gh<_i465.SembastAudiobookRepository>(),
      ),
    );
    gh.lazySingleton<_i564.AudiobookCatalogRepository>(
      () => appModule.provideAudiobookCatalog(
        gh<_i465.SembastAudiobookRepository>(),
      ),
    );
    gh.lazySingleton<_i355.BookNoteRepository>(
      () => appModule.provideBookNotes(gh<_i465.SembastAudiobookRepository>()),
    );
    gh.lazySingleton<_i167.BookMetadataRepository>(
      () =>
          appModule.provideBookMetadata(gh<_i465.SembastAudiobookRepository>()),
    );
    gh.lazySingleton<_i958.ObservableAudiobookCatalogRepository>(
      () => appModule.provideObservableAudiobookCatalog(
        gh<_i465.SembastAudiobookRepository>(),
      ),
    );
    await gh.factoryAsync<_i437.JustAudioPlayerRepository>(
      () => appModule.provideJustAudioPlayerRepository(
        gh<_i501.AudioPlayer>(),
        gh<_i501.AndroidLoudnessEnhancer>(),
        gh<_i501.AndroidEqualizer>(),
      ),
      registerFor: {_prod},
      preResolve: true,
    );
    gh.factory<_i924.PlayerProgressSaver>(
      () => _i924.PlayerProgressSaver(
        gh<_i564.AudiobookCatalogRepository>(),
        gh<_i1031.Clock>(),
      ),
    );
    gh.factory<_i1032.StorageAssistantWorkflow>(
      () => _i1032.StorageAssistantWorkflow(
        gh<_i564.AudiobookCatalogRepository>(),
        gh<_i681.LibraryStorageRepository>(),
        gh<_i101.AppDataResetRepository>(),
        gh<_i190.TranscriptionRepository>(),
      ),
    );
    gh.factory<_i703.ImportedBookSaver>(
      () => _i703.ImportedBookSaver(
        gh<_i564.AudiobookCatalogRepository>(),
        gh<_i167.BookMetadataRepository>(),
        gh<_i1031.Clock>(),
        gh<_i315.IdGenerator>(),
      ),
    );
    gh.lazySingleton<_i304.TranscriptionPreferences>(
      () => _i345.SettingsTranscriptionPreferences(
        gh<_i852.SettingsRepository>(),
      ),
    );
    gh.factory<_i877.LoadLibraryUseCase>(
      () => _i877.LoadLibraryUseCase(
        gh<_i564.AudiobookCatalogRepository>(),
        gh<_i1002.AudiobookArtworkExtractor>(),
        gh<_i852.SettingsRepository>(),
      ),
    );
    gh.factory<_i938.SaveLibraryBookUseCase>(
      () =>
          _i938.SaveLibraryBookUseCase(gh<_i564.AudiobookCatalogRepository>()),
    );
    gh.factory<_i134.LoadNoteGalleryUseCase>(
      () => _i134.LoadNoteGalleryUseCase(
        gh<_i355.BookNoteRepository>(),
        gh<_i167.BookMetadataRepository>(),
      ),
    );
    gh.factory<_i209.DiagnosticsCubit>(
      () => _i209.DiagnosticsCubit(gh<_i124.DiagnosticsUseCases>()),
    );
    gh.factory<_i981.SettingsUseCases>(
      () => _i981.SettingsUseCases(
        gh<_i981.LoadSettingsUseCase>(),
        gh<_i946.SavePlaybackPreferencesUseCase>(),
        gh<_i230.SaveThemePreferenceUseCase>(),
      ),
    );
    gh.lazySingleton<_i1024.PlayerLifecyclePolicies>(
      () => _i1024.PlayerLifecyclePolicies(
        gh<_i1031.Clock>(),
        gh<_i342.ListeningSessionTracker>(),
        gh<_i199.PlaybackResumePolicy>(),
        gh<_i626.SeriesContinuationPolicy>(),
      ),
    );
    gh.factory<_i983.RemoveAudiobookUseCase>(
      () => _i983.RemoveAudiobookUseCase(
        gh<_i564.AudiobookCatalogRepository>(),
        gh<_i938.FileImportRepository>(),
      ),
    );
    gh.factory<_i232.PortabilityCubit>(
      () => _i232.PortabilityCubit(gh<_i186.PortabilityUseCases>()),
    );
    gh.factory<_i595.UpdateGalleryNoteUseCase>(
      () => _i595.UpdateGalleryNoteUseCase(gh<_i355.BookNoteRepository>()),
    );
    gh.lazySingleton<_i193.BookEditingRepository>(
      () => _i937.LibraryBookEditingRepository(
        gh<_i564.AudiobookCatalogRepository>(),
        gh<_i938.FileImportRepository>(),
      ),
    );
    gh.factory<_i177.PlayerNotesService>(
      () => _i177.PlayerNotesService(
        gh<_i355.BookNoteRepository>(),
        gh<_i623.LocalExportRepository>(),
        gh<_i122.QuoteShareRepository>(),
        gh<_i1031.Clock>(),
        gh<_i315.IdGenerator>(),
      ),
    );
    gh.lazySingleton<_i316.ListeningInsightsRepository>(
      () => _i848.LibraryListeningInsightsRepository(
        gh<_i167.BookMetadataRepository>(),
        gh<_i276.ListeningHistoryRepository>(),
      ),
    );
    gh.factory<_i283.ReadSelectedSpeechModelUseCase>(
      () => _i283.ReadSelectedSpeechModelUseCase(
        gh<_i304.TranscriptionPreferences>(),
      ),
    );
    gh.factory<_i27.SelectSpeechModelUseCase>(
      () => _i27.SelectSpeechModelUseCase(gh<_i304.TranscriptionPreferences>()),
    );
    gh.factory<_i723.TranscribeQuoteUseCase>(
      () => _i723.TranscribeQuoteUseCase(
        gh<_i190.TranscriptionRepository>(),
        gh<_i304.TranscriptionPreferences>(),
      ),
    );
    gh.lazySingleton<_i1014.AudioPlayerRepository>(
      () => appModule.provideAudioPlayerRepository(
        gh<_i437.JustAudioPlayerRepository>(),
      ),
      registerFor: {_prod},
    );
    gh.lazySingleton<_i621.SettingsCubit>(
      () => _i621.SettingsCubit(gh<_i14.SettingsUseCases>()),
    );
    gh.factory<_i781.CleanOrphanFilesUseCase>(
      () =>
          _i781.CleanOrphanFilesUseCase(gh<_i1032.StorageAssistantWorkflow>()),
    );
    gh.factory<_i652.ClearBookishDataUseCase>(
      () =>
          _i652.ClearBookishDataUseCase(gh<_i1032.StorageAssistantWorkflow>()),
    );
    gh.factory<_i12.RemoveMissingBookUseCase>(
      () =>
          _i12.RemoveMissingBookUseCase(gh<_i1032.StorageAssistantWorkflow>()),
    );
    gh.factory<_i40.InspectStorageUseCase>(
      () => _i40.InspectStorageUseCase(gh<_i1032.StorageAssistantWorkflow>()),
    );
    gh.factory<_i751.LibraryUseCases>(
      () => _i751.LibraryUseCases(
        loadLibrary: gh<_i877.LoadLibraryUseCase>(),
        removeBook: gh<_i983.RemoveAudiobookUseCase>(),
        saveLayout: gh<_i751.SaveLibraryLayoutUseCase>(),
        saveBook: gh<_i938.SaveLibraryBookUseCase>(),
      ),
    );
    gh.factory<_i134.NoteGalleryUseCases>(
      () => _i134.NoteGalleryUseCases(
        loadGallery: gh<_i134.LoadNoteGalleryUseCase>(),
        updateNote: gh<_i595.UpdateGalleryNoteUseCase>(),
      ),
    );
    gh.lazySingleton<_i11.PlaybackCommandService>(
      () => _i11.PlaybackCommandService(
        gh<_i1014.AudioPlayerRepository>(),
        gh<_i564.AudiobookCatalogRepository>(),
        gh<_i852.SettingsRepository>(),
      ),
    );
    gh.factory<_i723.QuoteTranscriptionUseCases>(
      () => _i723.QuoteTranscriptionUseCases(
        gh<_i723.TranscribeQuoteUseCase>(),
        gh<_i484.ShareTranscriptionDraftUseCase>(),
      ),
    );
    gh.lazySingleton<_i276.PlayerNoteUseCases>(
      () => _i276.PlayerNoteUseCases(gh<_i177.PlayerNotesService>()),
    );
    gh.factory<_i517.LoadListeningInsightsUseCase>(
      () => _i517.LoadListeningInsightsUseCase(
        gh<_i316.ListeningInsightsRepository>(),
        gh<_i1031.Clock>(),
      ),
    );
    gh.lazySingleton<_i259.MediaProbe>(
      () => _i773.AudioPlayerMediaProbe(gh<_i1014.AudioPlayerRepository>()),
    );
    gh.factory<_i903.SleepTimerUseCase>(
      () => _i903.SleepTimerUseCase(gh<_i1014.AudioPlayerRepository>()),
    );
    gh.factory<_i278.AddBookChapterUseCase>(
      () => _i278.AddBookChapterUseCase(gh<_i193.BookEditingRepository>()),
    );
    gh.factory<_i798.ChangeBookCoverUseCase>(
      () => _i798.ChangeBookCoverUseCase(gh<_i193.BookEditingRepository>()),
    );
    gh.factory<_i997.DeleteBookChapterUseCase>(
      () => _i997.DeleteBookChapterUseCase(gh<_i193.BookEditingRepository>()),
    );
    gh.factory<_i249.EditBookDetailsUseCase>(
      () => _i249.EditBookDetailsUseCase(gh<_i193.BookEditingRepository>()),
    );
    gh.factory<_i121.LoadBookForEditingUseCase>(
      () => _i121.LoadBookForEditingUseCase(gh<_i193.BookEditingRepository>()),
    );
    gh.factory<_i428.ReorderBookTracksUseCase>(
      () => _i428.ReorderBookTracksUseCase(gh<_i193.BookEditingRepository>()),
    );
    gh.lazySingleton<_i58.AudioServiceBootstrap>(
      () => _i129.BookishAudioServiceBootstrap(
        gh<_i501.AudioPlayer>(),
        gh<_i434.JustAudioPlayerRepository>(),
        gh<_i564.AudiobookCatalogRepository>(),
        gh<_i11.PlaybackCommandService>(),
      ),
      registerFor: {_prod},
    );
    gh.lazySingleton<_i58.CarPlayBootstrap>(
      () => _i271.PigeonCarPlayBootstrap(
        gh<_i958.ObservableAudiobookCatalogRepository>(),
        gh<_i11.PlaybackCommandService>(),
      ),
      registerFor: {_prod},
    );
    gh.factory<_i237.SpeechModelUseCases>(
      () => _i237.SpeechModelUseCases(
        loadCachedModels: gh<_i237.LoadCachedSpeechModelsUseCase>(),
        refreshModels: gh<_i766.RefreshSpeechModelsUseCase>(),
        selectedModel: gh<_i283.ReadSelectedSpeechModelUseCase>(),
        selectModel: gh<_i27.SelectSpeechModelUseCase>(),
        downloadModel: gh<_i652.DownloadSpeechModelUseCase>(),
      ),
    );
    gh.factory<_i40.StorageUseCases>(
      () => _i40.StorageUseCases(
        inspectStorage: gh<_i40.InspectStorageUseCase>(),
        cleanOrphanFiles: gh<_i781.CleanOrphanFilesUseCase>(),
        removeMissingBook: gh<_i12.RemoveMissingBookUseCase>(),
        clearBookishData: gh<_i652.ClearBookishDataUseCase>(),
      ),
    );
    gh.lazySingleton<_i1068.PlayerLifecycleUseCases>(
      () => _i1068.PlayerLifecycleUseCases(
        gh<_i1014.AudioPlayerRepository>(),
        gh<_i564.AudiobookCatalogRepository>(),
        gh<_i11.PlaybackCommandService>(),
        gh<_i1024.PlayerLifecyclePolicies>(),
        gh<_i177.PlayerNotesService>(),
      ),
    );
    gh.lazySingleton<_i945.AppBootstrapper>(
      () => _i945.AppBootstrapper(
        gh<_i58.AudioServiceBootstrap>(),
        gh<_i58.CarPlayBootstrap>(),
      ),
    );
    gh.factory<_i627.SpeechModelsCubit>(
      () => _i627.SpeechModelsCubit(gh<_i877.SpeechModelUseCases>()),
    );
    gh.lazySingleton<_i163.PlayerPlaybackStreams>(
      () => _i163.PlayerPlaybackStreams(
        gh<_i1014.AudioPlayerRepository>(),
        gh<_i11.PlaybackCommandService>(),
      ),
    );
    gh.lazySingleton<_i369.PlayerTransportUseCases>(
      () => _i369.PlayerTransportUseCases(
        gh<_i1014.AudioPlayerRepository>(),
        gh<_i564.AudiobookCatalogRepository>(),
        gh<_i11.PlaybackCommandService>(),
        gh<_i479.ChapterNavigationPolicy>(),
      ),
    );
    gh.factory<_i977.NoteGalleryCubit>(
      () => _i977.NoteGalleryCubit(gh<_i152.NoteGalleryUseCases>()),
    );
    gh.factory<_i1063.QuoteTranscriptionCubit>(
      () => _i1063.QuoteTranscriptionCubit(
        gh<_i877.QuoteTranscriptionUseCases>(),
      ),
    );
    gh.factory<_i811.InsightsUseCases>(
      () => _i811.InsightsUseCases(
        loadListeningInsights: gh<_i517.LoadListeningInsightsUseCase>(),
      ),
    );
    gh.lazySingleton<_i246.PlayerSleepUseCases>(
      () => _i246.PlayerSleepUseCases(
        gh<_i903.SleepTimerUseCase>(),
        gh<_i924.PlayerProgressSaver>(),
        gh<_i1014.AudioPlayerRepository>(),
      ),
    );
    gh.factory<_i1063.ImportSourceGateway>(
      () => _i1063.ImportSourceGateway(
        gh<_i938.FileImportRepository>(),
        gh<_i259.MediaProbe>(),
        gh<_i454.M4bChapterParser>(),
        gh<_i1002.AudiobookArtworkExtractor>(),
        gh<_i361.AudiobookMetadataExtractor>(),
      ),
    );
    gh.factory<_i121.EditingChapterUseCases>(
      () => _i121.EditingChapterUseCases(
        gh<_i278.AddBookChapterUseCase>(),
        gh<_i997.DeleteBookChapterUseCase>(),
      ),
    );
    gh.factory<_i160.AudiobookImportWorkflow>(
      () => _i160.AudiobookImportWorkflow(
        gh<_i1063.ImportSourceGateway>(),
        gh<_i703.ImportedBookSaver>(),
        gh<_i1031.Clock>(),
        gh<_i158.ImportCleanup>(),
      ),
    );
    gh.factory<_i121.EditingUseCases>(
      () => _i121.EditingUseCases(
        loadBook: gh<_i121.LoadBookForEditingUseCase>(),
        editDetails: gh<_i249.EditBookDetailsUseCase>(),
        changeCover: gh<_i798.ChangeBookCoverUseCase>(),
        reorderTracks: gh<_i428.ReorderBookTracksUseCase>(),
        chapters: gh<_i121.EditingChapterUseCases>(),
      ),
    );
    gh.factory<_i1000.MetadataEditorCubit>(
      () => _i1000.MetadataEditorCubit(gh<_i498.EditingUseCases>()),
    );
    gh.factory<_i411.ListeningInsightsCubit>(
      () => _i411.ListeningInsightsCubit(gh<_i811.InsightsUseCases>()),
    );
    gh.lazySingleton<_i671.PlayerUseCases>(
      () => _i671.PlayerUseCases(
        lifecycle: gh<_i1068.PlayerLifecycleUseCases>(),
        notes: gh<_i276.PlayerNoteUseCases>(),
        sleep: gh<_i246.PlayerSleepUseCases>(),
        transport: gh<_i369.PlayerTransportUseCases>(),
        showAudioOutputPicker: gh<_i579.ShowAudioOutputPickerUseCase>(),
      ),
    );
    gh.factory<_i309.ImportBookUseCase>(
      () => _i309.ImportBookUseCase(gh<_i160.AudiobookImportWorkflow>()),
    );
    gh.factory<_i233.RemoveTransferredSourcesUseCase>(
      () => _i233.RemoveTransferredSourcesUseCase(
        gh<_i160.AudiobookImportWorkflow>(),
      ),
    );
    gh.factory<_i309.ImportUseCases>(
      () => _i309.ImportUseCases(
        importBook: gh<_i309.ImportBookUseCase>(),
        removeTransferredSources: gh<_i233.RemoveTransferredSourcesUseCase>(),
        copyDiagnostics: gh<_i106.CopyImportDiagnosticsUseCase>(),
      ),
    );
    gh.factory<_i218.ImportCubit>(
      () => _i218.ImportCubit(gh<_i717.ImportUseCases>()),
    );
    gh.lazySingleton<_i948.PlayerCubit>(
      () => _i948.PlayerCubit(
        gh<_i671.PlayerUseCases>(),
        gh<_i570.PlayerStateFactory>(),
        gh<_i163.PlayerPlaybackStreams>(),
      ),
    );
    return this;
  }
}

class _$AppModule extends _i249.AppModule {}
