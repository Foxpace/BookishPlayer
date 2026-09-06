import 'dart:typed_data';

import 'picked_local_file.dart';

abstract interface class FilePickerGateway {
  Future<List<PickedLocalFile>> pickAudioFiles(List<String> extensions);

  Future<PickedLocalFile?> pickImage();

  Future<Uint8List?> pickJsonBytes();

  Future<bool> saveFile({
    required String filename,
    required List<String> extensions,
    required Uint8List bytes,
  });

  Future<void> clearTemporaryFiles();
}
