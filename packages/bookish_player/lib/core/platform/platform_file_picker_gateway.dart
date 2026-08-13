import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';

import 'file_picker_gateway.dart';

@LazySingleton(as: FilePickerGateway)
class PlatformFilePickerGateway implements FilePickerGateway {
  @override
  Future<FilePickerResult?> pickAudioFiles(List<String> extensions) =>
      FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: extensions,
        withData: false,
      );

  @override
  Future<FilePickerResult?> pickImage() => FilePicker.platform.pickFiles(
    type: FileType.image,
    allowMultiple: false,
    withData: false,
  );

  @override
  Future<FilePickerResult?> pickJson() => FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: const ['json'],
    allowMultiple: false,
    withData: true,
  );

  @override
  Future<String?> saveFile({
    required String filename,
    required List<String> extensions,
    required Uint8List bytes,
  }) => FilePicker.platform.saveFile(
    fileName: filename,
    type: FileType.custom,
    allowedExtensions: extensions,
    bytes: bytes,
  );

  @override
  Future<bool?> clearTemporaryFiles() =>
      FilePicker.platform.clearTemporaryFiles();
}
