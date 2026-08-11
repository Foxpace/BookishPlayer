import 'dart:async';

import 'package:bookish_player/features/library/models/library_models.dart';
import 'package:bookish_player/features/player/cubits/player_cubit.dart';

import 'fake_audio_player.dart';
import 'fake_books.dart';
import 'fake_exports.dart';
import 'fake_settings.dart';

import 'player_cubit_builder.dart';

final class PlayerCubitTestHarness {
  PlayerCubitTestHarness._(this.book, this.audio, this.books, this.sut);

  static Future<PlayerCubitTestHarness> opened(Audiobook book) async {
    final audio = FakeAudioPlayer();
    final books = FakeBooks(book);
    final sut = createPlayerCubit(audio, books, FakeExports(), FakeSettings());
    await sut.open(book);
    return PlayerCubitTestHarness._(book, audio, books, sut);
  }

  final Audiobook book;
  final FakeAudioPlayer audio;
  final FakeBooks books;
  final PlayerCubit sut;

  Future<void> close() async {
    await sut.close();
    await audio.close();
  }
}
