import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:injectable/injectable.dart';

import '../../library/domain/audiobook.dart';
import '../../player/domain/book_note.dart';
import '../domain/local_export_repository.dart';

@LazySingleton(as: LocalExportRepository)
class FilePickerLocalExportRepository implements LocalExportRepository {
  @override
  Future<bool> exportNotes(Audiobook book, List<BookNote> notes) async {
    final buffer = StringBuffer()
      ..writeln('# ${book.title}')
      ..writeln()
      ..writeln(book.author.isEmpty ? '' : 'Author: ${book.author}\n');
    for (final note in notes) {
      buffer
        ..writeln('## ${_timestamp(note.positionMs)}')
        ..writeln(note.text)
        ..writeln();
    }
    return _save(
      filename: '${_safeFilename(book.title)}-notes.md',
      contents: buffer.toString(),
      extensions: const ['md'],
    );
  }

  @override
  Future<bool> exportBackup(Map<String, dynamic> backup) {
    return _save(
      filename: 'bookish-backup.json',
      contents: const JsonEncoder.withIndent('  ').convert(backup),
      extensions: const ['json'],
    );
  }

  @override
  Future<Map<String, dynamic>?> pickBackup() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['json'],
      allowMultiple: false,
      withData: true,
    );
    final bytes = result?.files.single.bytes;
    if (bytes == null) {
      return null;
    }
    return Map<String, dynamic>.from(jsonDecode(utf8.decode(bytes)) as Map);
  }

  Future<bool> _save({
    required String filename,
    required String contents,
    required List<String> extensions,
  }) async {
    final path = await FilePicker.platform.saveFile(
      dialogTitle: 'Export from Bookish',
      fileName: filename,
      type: FileType.custom,
      allowedExtensions: extensions,
      bytes: Uint8List.fromList(utf8.encode(contents)),
    );
    return path != null;
  }

  String _timestamp(int milliseconds) {
    final duration = Duration(milliseconds: milliseconds);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  String _safeFilename(String value) => value
      .replaceAll(RegExp('[^a-zA-Z0-9 _-]'), '')
      .trim()
      .replaceAll(RegExp(r'\s+'), '-');
}
