import 'player_test_support.dart';

void registerPlayerControlWidgetTests() {
  late _PlayerControlsHarness harness;

  setUp(() async => harness = await _PlayerControlsHarness.opened());
  tearDown(() => harness.close());

  testWidgets(
    'Given player controls, When they are rendered and used, Then skip labels stay centered and readable',
    (tester) async {
      // WHEN
      await harness.pump(tester);
      await tester.tap(find.byTooltip('Choose audio output'));
      await tester.pump();

      // THEN
      expect(harness.outputPickerCalls, 1);
      _expectReadableSkipLabels(tester);
      _expectEvenControlSpacing(tester);
    },
  );
}

void _expectReadableSkipLabels(WidgetTester tester) {
  final labels = tester.widgetList<Text>(find.text('15'));
  expect(labels, hasLength(2));
  expect(
    labels.map((label) => label.textScaler),
    everyElement(TextScaler.noScaling),
  );
  expect(labels.map((label) => label.style?.fontSize), everyElement(10));

  final icons = tester.widgetList<Icon>(find.byIcon(Icons.replay_rounded));
  expect(icons, hasLength(2));
  expect(icons.map((icon) => icon.size), everyElement(50));
  _expectLabelOffsets(tester);
}

void _expectLabelOffsets(WidgetTester tester) {
  final rewind = tester.widget<Transform>(
    find.byKey(const ValueKey('rewind-skip-label')),
  );
  final forward = tester.widget<Transform>(
    find.byKey(const ValueKey('forward-skip-label')),
  );
  expect(rewind.transform.getTranslation().x, 0.5);
  expect(forward.transform.getTranslation().x, -0.5);
  expect(rewind.transform.getTranslation().y, 3.5);
  expect(forward.transform.getTranslation().y, 3.5);
}

void _expectEvenControlSpacing(WidgetTester tester) {
  final centers = _controlKeys
      .map((key) => tester.getCenter(find.byKey(ValueKey(key))).dx)
      .toList();
  final gaps = [
    for (var index = 1; index < centers.length; index++)
      centers[index] - centers[index - 1],
  ];
  expect(gaps, everyElement(closeTo(gaps.first, .01)));
}

final class _PlayerControlsHarness {
  _PlayerControlsHarness(this.audio, this.sut);

  static Future<_PlayerControlsHarness> opened() async {
    final audio = FakeAudioPlayer();
    final sut = createPlayerCubit(
      audio,
      FakeBooks(_book),
      FakeExports(),
      FakeSettings(),
    );
    await sut.open(_book);
    return _PlayerControlsHarness(audio, sut);
  }

  final FakeAudioPlayer audio;
  final PlayerCubit sut;
  var outputPickerCalls = 0;

  Future<void> pump(WidgetTester tester) => tester.pumpWidget(
    PlayerTestApp(
      home: PlayerTestScreenHarness(
        cubit: sut,
        onPickAudioOutput: () => outputPickerCalls++,
      ),
    ),
  );

  Future<void> close() async {
    await sut.close();
    await audio.close();
  }
}

final _book = Audiobook(
  id: 'book',
  title: 'Book',
  filePath: '/book.mp3',
  durationMs: 60000,
  addedAt: DateTime(2026),
);

const _controlKeys = [
  'previous-chapter-slot',
  'rewind-slot',
  'playback-slot',
  'forward-slot',
  'next-chapter-slot',
];
