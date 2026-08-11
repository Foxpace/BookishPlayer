import 'package:bookish_player/features/notes/repos/voice_note_transcription_repository.dart';
import 'package:bookish_player/features/notes/ui/widgets/voice_note_sheet.dart';
import 'package:bookish_player/features/notes/cubits/voice_note_cubit.dart';
import 'package:bookish_player/features/notes/cubits/notes_cubits.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../support/pump_bookish_app.dart';
import 'notes_test_builder.dart';

void main() {
  group('Voice note sheet', () {
    late _Speech speech;
    late VoiceNoteCubit sut;

    setUp(() {
      speech = _Speech();
      sut = createVoiceNoteCubit(speech);
    });

    tearDown(() => sut.close());

    testWidgets(
      'Given an available local speech recognizer, When speech is captured and saved, Then the trimmed voice note closes the sheet as its result',
      (tester) async {
        // GIVEN
        String? result;

        await tester.pumpBookishApp(
          child: Scaffold(
            body: Builder(
              builder: (context) => FilledButton(
                onPressed: () async {
                  result = await showModalBottomSheet<String>(
                    context: context,
                    builder: (sheetContext) => _VoiceHarness(
                      cubit: sut,
                      onSave: (text) => Navigator.pop(sheetContext, text),
                    ),
                  );
                },
                child: const Text('Open voice note'),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Open voice note'));
        // WHEN
        await tester.pumpAndSettle();
        // THEN
        expect(find.text('Tap the microphone and speak.'), findsOneWidget);
        expect(
          tester
              .widget<FilledButton>(
                find.widgetWithText(FilledButton, 'Save voice note'),
              )
              .onPressed,
          isNull,
        );

        await tester.tap(find.byTooltip('Start listening'));
        await tester.pump();
        expect(find.byTooltip('Stop listening'), findsOneWidget);
        speech.emitText('  Remember this thought  ');
        await tester.pump();
        expect(find.text('  Remember this thought  '), findsOneWidget);

        await tester.tap(find.text('Save voice note'));
        await tester.pumpAndSettle();
        expect(result, 'Remember this thought');
      },
    );

    testWidgets(
      'Given an unavailable local speech recognizer, When listening is requested, Then a localized typed failure stays in the sheet',
      (tester) async {
        // GIVEN
        speech.available = false;

        // WHEN
        await tester.pumpBookishApp(
          child: Scaffold(body: _VoiceHarness(cubit: sut)),
        );
        await tester.tap(find.byTooltip('Start listening'));
        await tester.pumpAndSettle();

        // THEN
        expect(
          find.text('Speech recognition is not available.'),
          findsOneWidget,
        );
        expect(find.text('Save voice note'), findsOneWidget);
      },
    );
  });
}

class _VoiceHarness extends StatelessWidget {
  const _VoiceHarness({required this.cubit, this.onSave});

  final VoiceNoteCubit cubit;
  final ValueChanged<String>? onSave;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VoiceNoteCubit, VoiceNoteState>(
      bloc: cubit,
      builder: (_, state) => VoiceNoteSheet(
        state: state,
        onToggle: cubit.toggle,
        onSave: onSave ?? (_) {},
      ),
    );
  }
}

class _Speech implements VoiceNoteTranscriptionRepository {
  var available = true;
  void Function(String)? _onText;

  @override
  Future<bool> initialize({
    required void Function(String message) onError,
    required void Function() onDone,
  }) async => available;

  @override
  Future<void> listen(void Function(String text) onText) async {
    _onText = onText;
  }

  @override
  Future<void> stop() async {}

  void emitText(String text) => _onText?.call(text);
}
