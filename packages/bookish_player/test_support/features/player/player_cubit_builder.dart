import 'package:bookish_player/core/foundation/clock.dart';
import 'package:bookish_player/core/foundation/id_generator.dart';
import 'package:bookish_player/features/library/repos/audiobook_repository.dart';
import 'package:bookish_player/features/library/repos/listening_history_repository.dart';
import 'package:bookish_player/features/notes/use_cases/player_notes_service.dart';
import 'package:bookish_player/features/player/use_cases/chapter_navigation_policy.dart';
import 'package:bookish_player/features/player/use_cases/listening_session_tracker.dart';
import 'package:bookish_player/features/player/use_cases/playback_command_service.dart';
import 'package:bookish_player/features/player/use_cases/playback_resume_policy.dart';
import 'package:bookish_player/features/player/use_cases/player_application.dart';
import 'package:bookish_player/features/player/use_cases/player_device_gateway.dart';
import 'package:bookish_player/features/player/use_cases/player_lifecycle_policies.dart';
import 'package:bookish_player/features/player/use_cases/player_lifecycle_use_cases.dart';
import 'package:bookish_player/features/player/use_cases/player_note_use_cases.dart';
import 'package:bookish_player/features/player/use_cases/player_progress_saver.dart';
import 'package:bookish_player/features/player/use_cases/player_sleep_use_cases.dart';
import 'package:bookish_player/features/player/use_cases/player_transport_use_cases.dart';
import 'package:bookish_player/features/player/use_cases/series_continuation_policy.dart';
import 'package:bookish_player/features/player/use_cases/sleep_timer_use_case.dart';
import 'package:bookish_player/features/player/repos/audio_player_repository.dart';
import 'package:bookish_player/features/player/models/share_origin.dart';
import 'package:bookish_player/features/player/repos/quote_share_repository.dart';
import 'package:bookish_player/features/player/repos/audio_output_picker.dart';
import 'package:bookish_player/features/player/cubits/player_cubit.dart';
import 'package:bookish_player/features/player/cubits/player_state_factory.dart';
import 'package:bookish_player/features/portability/repos/local_export_repository.dart';
import 'package:bookish_player/features/settings/repos/settings_repository.dart';

import '../../support/fakes/fake_clock.dart';
import '../../support/fakes/fake_id_generator.dart';

abstract interface class PlayerTestBooks
    implements AudiobookRepository, ListeningHistoryRepository {}

typedef PlayerCubitHarness = ({
  PlayerCubit sut,
  PlaybackCommandService commands,
});

PlayerCubit createPlayerCubit(
  AudioPlayerRepository audio,
  PlayerTestBooks books,
  LocalExportRepository exports,
  SettingsRepository settings, [
  QuoteShareRepository? sharing,
]) => createPlayerCubitHarness(audio, books, exports, settings, sharing).sut;

PlayerCubitHarness createPlayerCubitHarness(
  AudioPlayerRepository audio,
  PlayerTestBooks books,
  LocalExportRepository exports,
  SettingsRepository settings, [
  QuoteShareRepository? sharing,
]) {
  final Clock clock = FakeClock();
  final IdGenerator ids = FakeIdGenerator();
  const states = PlayerStateFactory();
  const chapters = ChapterNavigationPolicy();
  const series = SeriesContinuationPolicy();
  final commands = PlaybackCommandService(audio, books, settings);
  final progress = PlayerProgressSaver(books, clock);
  final notes = PlayerNotesService(
    books,
    exports,
    sharing ?? _FakeSharing(),
    clock,
    ids,
  );
  final sleep = PlayerSleepUseCases(SleepTimerUseCase(audio), progress, audio);
  final lifecycle = PlayerLifecycleUseCases(
    audio,
    books,
    commands,
    PlayerLifecyclePolicies(
      clock,
      ListeningSessionTracker(books, clock, ids),
      PlaybackResumePolicy(clock),
      series,
    ),
    notes,
  );
  final application = PlayerApplication(
    lifecycle,
    PlayerNoteUseCases(notes),
    sleep,
    PlayerTransportUseCases(audio, books, commands, chapters),
    PlayerDeviceGateway(audio, commands, const _FakeAudioOutputPicker()),
  );
  final sut = PlayerCubit(application, states);

  return (sut: sut, commands: commands);
}

class _FakeAudioOutputPicker implements AudioOutputPicker {
  const _FakeAudioOutputPicker();

  @override
  Future<void> showAudioOutputPicker() async {}
}

class _FakeSharing implements QuoteShareRepository {
  @override
  Future<void> share({
    required String text,
    required String subject,
    ShareOrigin? origin,
  }) async {}
}
