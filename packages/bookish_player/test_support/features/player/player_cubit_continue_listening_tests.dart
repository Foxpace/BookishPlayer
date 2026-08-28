import 'player_test_support.dart';

void registerPlayerCubitContinueListeningTests() {
  group('Continue listening', () {
    late _ContinueListeningHarness harness;

    tearDown(() => harness.close());

    test(
      'Given unfinished listened books, When continue listening is offered, Then only the most recently played book is offered once',
      () async {
        // GIVEN
        final older = _book(
          id: 'older',
          title: 'Older',
        ).copyWith(positionMs: 10000, lastPlayedAt: DateTime(2026, 1));
        final recent = _book(
          id: 'recent',
          title: 'Recent',
        ).copyWith(positionMs: 20000, lastPlayedAt: DateTime(2026, 2));
        final finished = _book(id: 'finished', title: 'Finished').copyWith(
          positionMs: 60000,
          lastPlayedAt: DateTime(2026, 3),
          completedAt: DateTime(2026, 3),
        );
        harness = _ContinueListeningHarness([older, recent, finished]);
        final sut = harness.sut;

        // WHEN
        await sut.offerContinueListening();

        // THEN
        expect(sut.state.continueListeningBook?.id, recent.id);

        sut.cancelContinueListening();
        await sut.offerContinueListening();
        expect(sut.state.continueListeningBook, isNull);
      },
    );

    test(
      'Given a continue listening offer, When the user continues, Then the saved book opens and starts playing',
      () async {
        // GIVEN
        final book = _book(
          id: 'saved',
          title: 'Saved',
        ).copyWith(positionMs: 15000, lastPlayedAt: DateTime(2026, 2));
        harness = _ContinueListeningHarness([book]);
        final sut = harness.sut;
        await sut.offerContinueListening();

        // WHEN
        await sut.continueListening();

        // THEN
        expect(sut.state.continueListeningBook, isNull);
        expect(sut.state.book?.id, book.id);
        expect(sut.state.position, const Duration(seconds: 15));
        expect(harness.audio.playing, isTrue);
      },
    );
  });
}

final class _ContinueListeningHarness {
  _ContinueListeningHarness(List<Audiobook> books) : audio = FakeAudioPlayer() {
    sut = createPlayerCubit(
      audio,
      FakeBooks.withBooks(books),
      FakeExports(),
      FakeSettings(),
    );
  }

  final FakeAudioPlayer audio;
  late final PlayerCubit sut;

  Future<void> close() async {
    await sut.close();
    await audio.close();
  }
}

Audiobook _book({required String id, required String title}) => Audiobook(
  id: id,
  title: title,
  filePath: '/$id.mp3',
  durationMs: 60000,
  addedAt: DateTime(2026),
);
