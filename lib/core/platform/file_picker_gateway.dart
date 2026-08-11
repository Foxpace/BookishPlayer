import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';

abstract interface class FilePickerGateway {
  Future<FilePickerResult?> pickAudioFiles(List<String> extensions);

  Future<FilePickerResult?> pickImage();

  Future<FilePickerResult?> pickJson();

  Future<String?> saveFile({
    required String filename,
    required List<String> extensions,
    required Uint8List bytes,
  });

  Future<bool?> clearTemporaryFiles();
}
