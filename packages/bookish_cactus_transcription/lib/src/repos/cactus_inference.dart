import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:path/path.dart' as p;

import '../cactus_models.dart';
import '../vendor/cactus.dart' as native;

typedef CactusInference = Future<CactusTranscriptionOutcome> Function(
  String modelPath,
  String pcmPath,
);

Future<CactusTranscriptionOutcome> transcribeCactusAudio(
  String modelPath,
  String pcmPath,
) => Isolate.run(() => _transcribe(modelPath, pcmPath));

CactusTranscriptionOutcome _transcribe(String modelPath, String pcmPath) {
  final usesParakeet = File(p.join(modelPath, 'config.txt'))
      .readAsLinesSync()
      .any(
        (line) =>
            RegExp(r'^\s*model_type\s*=\s*parakeet[_-]tdt\s*$').hasMatch(line),
      );
  final model = native.cactusInit(modelPath);
  try {
    return _transcribeLoaded(
      model,
      File(pcmPath).readAsBytesSync(),
      usesParakeet: usesParakeet,
    );
  } finally {
    native.cactusDestroy(model);
  }
}

CactusTranscriptionOutcome _transcribeLoaded(
  native.CactusModelT model,
  Uint8List pcm, {
  required bool usesParakeet,
}) {
  if (usesParakeet) {
    return parseCactusTranscript(native.cactusTranscribe(model, pcm));
  }
  final languageProbe = native.cactusTranscribe(
    model,
    pcm,
    prompt: '<|startoftranscript|>',
    maxTokens: 4,
  );
  final language = whisperTranscriptionPrompt(languageProbe);
  return parseCactusTranscript(
    native.cactusTranscribe(model, pcm, prompt: language),
  );
}

String whisperTranscriptionPrompt(String response) {
  final outcome = parseCactusTranscript(response);
  if (outcome case CactusTranscriptionSucceeded(:final text)) {
    final language = RegExp(r'^<\|[a-z]{2,3}\|>').firstMatch(text)?.group(0);
    if (language != null) {
      return '<|startoftranscript|>$language<|transcribe|><|notimestamps|>';
    }
  }
  throw const CactusTranscriptionException(
    'Could not detect the audio language.',
  );
}

CactusTranscriptionOutcome parseCactusTranscript(String response) {
  final decoded = jsonDecode(response);
  if (decoded is! Map<String, dynamic>) {
    return const CactusTranscriptionOutcome.failure('Invalid Cactus response.');
  }
  if (decoded['success'] != true || decoded['response'] is! String) {
    return CactusTranscriptionOutcome.failure(
      decoded['error'] as String? ?? 'Cactus could not transcribe this audio.',
    );
  }
  return CactusTranscriptionOutcome.success(
    (decoded['response'] as String).trim(),
  );
}
