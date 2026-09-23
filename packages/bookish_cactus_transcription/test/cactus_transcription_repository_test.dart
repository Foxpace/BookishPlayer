import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:bookish_cactus_transcription/src/cactus_models.dart';
import 'package:bookish_cactus_transcription/src/cactus_pcm_stream_factory.dart';
import 'package:bookish_cactus_transcription/src/repos/cactus_inference.dart';
import 'package:bookish_cactus_transcription/src/repos/cactus_model_download.dart';
import 'package:bookish_cactus_transcription/src/repos/cactus_transcription_repository.dart';
import 'package:test/test.dart';

void main() {
  late Directory directory;
  const source = CactusAudioSource(
    tracks: [CactusAudioTrack(filePath: 'book.mp3', durationMs: 1000)],
  );
  setUp(() => directory = Directory.systemTemp.createTempSync('cactus-test-'));
  tearDown(() => directory.deleteSync(recursive: true));

  void prepareModel() {
    final model = Directory(
      '${directory.path}/cactus-v2.0.1/models/whisper-base',
    )..createSync(recursive: true);
    File('${model.path}/config.txt').writeAsStringSync('model_type=whisper');
    File('${model.path}/.complete')
        .writeAsStringSync(cactusModelRevisions['whisper-base']!);
    File('${model.path}/components/manifest.json')
      ..createSync(recursive: true)
      ..writeAsStringSync('{}');
  }

  CactusTranscriptionRepository repository(CactusInference inference) =>
      CactusTranscriptionRepository(
        CactusPcmStreamFactory(
          ({required track, required start, required duration}) =>
              Stream.value(Uint8List.fromList([1, 2, 3, 4])),
        ),
        documents: () async => directory,
        inference: inference,
      );

  Future<CactusTranscriptionOutcome> transcribe(
    CactusTranscriptionRepository sut,
  ) => sut.transcribeRange(
    source: source,
    start: Duration.zero,
    end: const Duration(seconds: 1),
    model: 'whisper-base',
  );

  test('Given old or incomplete models, When listing offline, Then requires a new download', () async {
    // GIVEN
    Directory('${directory.path}/models/whisper-tiny')
        .createSync(recursive: true);
    Directory('${directory.path}/cactus-v2.0.1/models/whisper-base')
        .createSync(recursive: true);
    final sut = repository(
      (_, _) async => const CactusTranscriptionOutcome.success(''),
    );
    // WHEN
    final models = await sut.listModels();
    // THEN
    expect(models.map((model) => model.isDownloaded), [false, false, false]);
    expect(await sut.isModelDownloaded('../whisper-tiny'), isFalse);
  });

  test('Given a downloaded model, When it is removed, Then its files are deleted and the catalog reports it missing', () async {
    // GIVEN
    prepareModel();
    final sut = repository(
      (_, _) async => const CactusTranscriptionOutcome.success(''),
    );
    expect(await sut.isModelDownloaded('whisper-base'), isTrue);

    // WHEN
    await sut.removeModel('whisper-base');

    // THEN
    expect(await sut.isModelDownloaded('whisper-base'), isFalse);
    expect(
      Directory('${directory.path}/cactus-v2.0.1/models/whisper-base')
          .existsSync(),
      isFalse,
    );
    await expectLater(
      sut.removeModel('../models'),
      throwsA(isA<CactusTranscriptionException>()),
    );
  });

  test('Given active transcription, When its model is removed, Then deletion waits for inference', () async {
    // GIVEN
    prepareModel();
    final inference = Completer<CactusTranscriptionOutcome>();
    final started = Completer<void>();
    final sut = repository((_, _) {
      started.complete();
      return inference.future;
    });
    final transcription = transcribe(sut);
    await started.future;

    // WHEN
    final removal = sut.removeModel('whisper-base');
    await Future<void>.delayed(Duration.zero);
    expect(await sut.isModelDownloaded('whisper-base'), isTrue);
    inference.complete(const CactusTranscriptionOutcome.success('done'));
    await transcription;
    await removal;

    // THEN
    expect(await sut.isModelDownloaded('whisper-base'), isFalse);
  });

  test('Given queued transcription before removal, When the model is removed, Then queued work finishes before deletion', () async {
    // GIVEN
    prepareModel();
    final first = Completer<CactusTranscriptionOutcome>();
    final started = Completer<void>();
    var calls = 0;
    final sut = repository((_, _) {
      calls++;
      if (calls == 1) {
        started.complete();
        return first.future;
      }
      return Future.value(const CactusTranscriptionOutcome.success('second'));
    });
    final one = transcribe(sut);
    await started.future;
    final two = transcribe(sut);

    // WHEN
    final removal = sut.removeModel('whisper-base');
    first.complete(const CactusTranscriptionOutcome.success('first'));
    await Future.wait([one, two, removal]).timeout(const Duration(seconds: 3));

    // THEN
    expect(calls, 2);
    expect(await sut.isModelDownloaded('whisper-base'), isFalse);
  });

  test('Given a ready model, When transcribing, Then passes decoded PCM and removes the temporary file', () async {
    // GIVEN
    prepareModel();
    String? temporaryPath;
    final sut = repository((model, pcm) async {
      temporaryPath = pcm;
      expect(model, endsWith('cactus-v2.0.1/models/whisper-base'));
      expect(await File(pcm).readAsBytes(), [1, 2, 3, 4]);
      return const CactusTranscriptionOutcome.success('hello');
    });
    // WHEN
    final result = await transcribe(sut);
    // THEN
    expect(result, const CactusTranscriptionOutcome.success('hello'));
    expect(File(temporaryPath!).existsSync(), isFalse);
  });

  test('Given failed inference, When transcribing, Then reports failure and removes temporary audio', () async {
    // GIVEN
    prepareModel();
    String? temporaryPath;
    final sut = repository((_, pcm) async {
      temporaryPath = pcm;
      throw StateError('native failure');
    });
    // WHEN
    final result = await transcribe(sut);
    // THEN
    expect(result, isA<CactusTranscriptionFailed>());
    expect(File(temporaryPath!).existsSync(), isFalse);
  });

  test('Given overlapping requests, When transcribing, Then inference runs one request at a time', () async {
    // GIVEN
    prepareModel();
    final first = Completer<CactusTranscriptionOutcome>();
    final started = Completer<void>();
    var calls = 0;
    final sut = repository((_, _) async {
      calls++;
      if (calls == 1) {
        started.complete();
        return first.future;
      }
      return const CactusTranscriptionOutcome.success('second');
    });
    // WHEN
    final one = transcribe(sut);
    await started.future;
    final two = transcribe(sut);
    await Future<void>.delayed(Duration.zero);
    // THEN
    expect(calls, 1);
    first.complete(const CactusTranscriptionOutcome.success('first'));
    await Future.wait([one, two]);
    expect(calls, 2);
  });

  test('Given native response JSON, When parsing, Then reads the response field and preserves failures', () {
    // WHEN
    final success = parseCactusTranscript(
      '{"success":true,"response":" hello "}',
    );
    final failure = parseCactusTranscript('{"success":false,"error":"failed"}');
    // THEN
    expect(success, const CactusTranscriptionOutcome.success('hello'));
    expect(failure, const CactusTranscriptionOutcome.failure('failed'));
  });
  test('Given a detected Whisper language, When transcribing, Then uses the detected language', () {
    // GIVEN
    final calls = <(String?, int?)>[];
    String transcribe({String? prompt, int? maxTokens}) {
      calls.add((prompt, maxTokens));
      return calls.length == 1
          ? '{"success":true,"response":"<|startoftranscript|><|sk|><|transcribe|>"}'
          : '{"success":true,"response":"Ahoj"}';
    }

    // WHEN
    final outcome = transcribeWhisperAudio(transcribe);

    // THEN
    expect(outcome, const CactusTranscriptionOutcome.success('Ahoj'));
    expect(calls, [
      ('<|startoftranscript|>', 4),
      ('<|startoftranscript|><|sk|><|transcribe|><|notimestamps|>', null),
    ]);
  });

  test('Given an inconclusive Whisper language probe, When transcribing, Then uses the model prompt', () {
    // GIVEN
    final calls = <(String?, int?)>[];
    String transcribe({String? prompt, int? maxTokens}) {
      calls.add((prompt, maxTokens));
      return calls.length == 1
          ? '{"success":true,"response":""}'
          : '{"success":true,"response":"hello"}';
    }

    // WHEN
    final outcome = transcribeWhisperAudio(transcribe);

    // THEN
    expect(outcome, const CactusTranscriptionOutcome.success('hello'));
    expect(calls, [('<|startoftranscript|>', 4), (null, null)]);
  });

  test('Given a failed Whisper language probe, When transcribing, Then attempts the model prompt', () {
    // GIVEN
    var calls = 0;
    String transcribe({String? prompt, int? maxTokens}) {
      calls++;
      return calls == 1
          ? '{"success":false,"error":"probe failed"}'
          : '{"success":false,"error":"transcription failed"}';
    }

    // WHEN
    final outcome = transcribeWhisperAudio(transcribe);

    // THEN
    expect(calls, 2);
    expect(
      outcome,
      const CactusTranscriptionOutcome.failure('transcription failed'),
    );
  });
}
