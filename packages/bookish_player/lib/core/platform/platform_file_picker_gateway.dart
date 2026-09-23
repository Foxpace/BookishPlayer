import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';

import 'file_picker_gateway.dart';
import 'picked_local_file.dart';

extension _PlatformFilePickedLocalFile on PlatformFile {
  PickedLocalFile get pickedLocalFile =>
      PickedLocalFile(name: name, path: path, sizeBytes: lengthSync());
}

@LazySingleton(as: FilePickerGateway)
class PlatformFilePickerGateway implements FilePickerGateway {
  @override
  Future<List<PickedLocalFile>> pickAudioFiles(List<String> extensions) async {
    final files = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: extensions,
    );
    return files.map((file) => file.pickedLocalFile).toList(growable: false);
  }

  @override
  Future<PickedLocalFile?> pickImage() async {
    final file = await FilePicker.pickFile(type: FileType.image);
    return file?.pickedLocalFile;
  }

  @override
  Future<Uint8List?> pickJsonBytes() async {
    final file = await FilePicker.pickFile(
      type: FileType.custom,
      allowedExtensions: const ['json'],
    );
    if (file == null) {
      return null;
    }
    return file.readAsBytes();
  }

  @override
  Future<bool> saveFile({
    required String filename,
    required List<String> extensions,
    required Uint8List bytes,
  }) async {
    final savedFile = await FilePicker.saveFile(
      fileName: filename,
      type: FileType.custom,
      allowedExtensions: extensions,
      bytes: bytes,
    );
    return savedFile != null;
  }

  @override
  Future<void> clearTemporaryFiles() => FilePicker.clearTemporaryFiles();
}
