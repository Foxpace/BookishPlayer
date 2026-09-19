import 'package:bookish_player/features/library/models/library_models.dart';
import 'package:bookish_player/features/transcription/cubits/transcription_preview_cubit.dart';
import 'package:bookish_player/features/transcription/cubits/transcription_preview_effect.dart';
import 'package:bookish_player/features/transcription/cubits/transcription_preview_status.dart';
import 'package:bookish_player/features/transcription/models/transcription_draft.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Transcription preview cubit', () {
    test(
      'Given an edited transcription, When save and share is requested, Then the note is stored before the edited text is shared',
      () async {
        // GIVEN
        final calls = <String>[];
        final sut = TranscriptionPreviewCubit(
          draft: _draft,
          storeNote: (text, _) async => calls.add('save:$text'),
          shareDraft: (_, text, {required subject, origin}) async {
            calls.add('share:$text:$subject');
          },
        );
        addTearDown(sut.close);
        sut.edit('  Edited quote  ');

        // WHEN
        await sut.saveAndShare(subject: 'Quote from The Book');

        // THEN
        expect(calls, [
          'save:Edited quote',
          'share:Edited quote:Quote from The Book',
        ]);
        expect(sut.state.status, TranscriptionPreviewStatus.ready);
        expect(sut.state.effect, TranscriptionPreviewEffect.shared);
        expect(sut.state.effectRevision, 1);
      },
    );

    test(
      'Given an empty transcription, When save is requested, Then no note is stored',
      () async {
        // GIVEN
        var saveCalls = 0;
        final sut = TranscriptionPreviewCubit(
          draft: _draft,
          storeNote: (_, _) async => saveCalls++,
          shareDraft: (_, _, {required subject, origin}) async {},
        );
        addTearDown(sut.close);
        sut.edit('   ');

        // WHEN
        await sut.save();

        // THEN
        expect(saveCalls, 0);
        expect(sut.state.status, TranscriptionPreviewStatus.ready);
        expect(sut.state.effect, isNull);
      },
    );
  });
}

final _draft = TranscriptionDraft(
  book: Audiobook(
    id: 'book',
    title: 'The Book',
    filePath: '/book.mp3',
    durationMs: 600000,
    addedAt: DateTime(2026),
  ),
  text: 'Original quote',
  start: const Duration(minutes: 1),
  end: const Duration(minutes: 1, seconds: 20),
  chapterStart: Duration.zero,
  chapterEnd: const Duration(seconds: 20),
  chapterTitle: 'Chapter one',
);
