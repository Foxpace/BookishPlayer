// Minimal Bookish bindings for cactus_engine.h at Cactus v2.0.1.
// The native source is pinned by tool/build_cactus.sh.
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:ffi/ffi.dart';

typedef CactusModelT = Pointer<Void>;

typedef _InitNative = CactusModelT Function(Pointer<Utf8>, Pointer<Utf8>, Bool);
typedef _InitDart = CactusModelT Function(Pointer<Utf8>, Pointer<Utf8>, bool);
typedef _DestroyNative = Void Function(CactusModelT);
typedef _DestroyDart = void Function(CactusModelT);
typedef _TranscribeNative = Int32 Function(
  CactusModelT,
  Pointer<Utf8>,
  Pointer<Utf8>,
  Pointer<Utf8>,
  IntPtr,
  Pointer<Utf8>,
  Pointer<Void>,
  Pointer<Void>,
  Pointer<Uint8>,
  IntPtr,
);
typedef _TranscribeDart = int Function(
  CactusModelT,
  Pointer<Utf8>,
  Pointer<Utf8>,
  Pointer<Utf8>,
  int,
  Pointer<Utf8>,
  Pointer<Void>,
  Pointer<Void>,
  Pointer<Uint8>,
  int,
);
typedef _LastErrorNative = Pointer<Utf8> Function();
typedef _LastErrorDart = Pointer<Utf8> Function();

DynamicLibrary _openLibrary() {
  if (Platform.isAndroid) {
    return DynamicLibrary.open('libcactus_engine.so');
  }
  if (Platform.isIOS) {
    return DynamicLibrary.open('cactus.framework/cactus');
  }
  final explicit = Platform.environment['CACTUS_DYLIB_PATH'];
  if (Platform.isMacOS && explicit != null) {
    return DynamicLibrary.open(explicit);
  }
  throw UnsupportedError(
    'Cactus is unavailable on ${Platform.operatingSystem}.',
  );
}

final _library = _openLibrary();
String _symbol(String name) => Platform.isAndroid ? 'bookish_$name' : name;

final _init = _library.lookupFunction<_InitNative, _InitDart>(
  _symbol('cactus_init'),
);
final _destroy = _library.lookupFunction<_DestroyNative, _DestroyDart>(
  _symbol('cactus_destroy'),
);
final _transcribe = _library.lookupFunction<_TranscribeNative, _TranscribeDart>(
  _symbol('cactus_transcribe'),
);
final _lastError = _library.lookupFunction<_LastErrorNative, _LastErrorDart>(
  _symbol('cactus_get_last_error'),
);

CactusModelT cactusInit(String path) {
  final nativePath = path.toNativeUtf8();
  try {
    final model = _init(nativePath, nullptr, false);
    if (model == nullptr) {
      throw StateError(
        'Cactus model initialization failed: ${_lastError().toDartString()}',
      );
    }
    return model;
  } finally {
    calloc.free(nativePath);
  }
}

void cactusDestroy(CactusModelT model) => _destroy(model);

String cactusTranscribe(
  CactusModelT model,
  Uint8List pcm, {
  String? prompt,
  int? maxTokens,
}) {
  const responseCapacity = 65536;
  final options = maxTokens == null
      ? '{"telemetry_enabled":false,"auto_handoff":false}'
      : '{"telemetry_enabled":false,"auto_handoff":false,"max_tokens":$maxTokens}';
  final response = calloc<Uint8>(responseCapacity);
  final nativeOptions = options.toNativeUtf8();
  final nativePrompt = prompt?.toNativeUtf8() ?? nullptr;
  final nativePcm = calloc<Uint8>(pcm.length);
  nativePcm.asTypedList(pcm.length).setAll(0, pcm);
  try {
    final count = _transcribe(
      model,
      nullptr,
      nativePrompt,
      response.cast(),
      responseCapacity,
      nativeOptions,
      nullptr,
      nullptr,
      nativePcm,
      pcm.length,
    );
    if (count < 0) {
      throw StateError(
        'Cactus transcription failed: ${_lastError().toDartString()}',
      );
    }
    return response.cast<Utf8>().toDartString();
  } finally {
    calloc.free(response);
    calloc.free(nativeOptions);
    if (nativePrompt != nullptr) calloc.free(nativePrompt);
    calloc.free(nativePcm);
  }
}
