import 'dart:convert';
import 'dart:typed_data';

import 'package:injectable/injectable.dart';

import '../../../../core/platform/file_picker_gateway.dart';
import '../../../library/models/library_models.dart';
import '../../../notes/models/book_note.dart';
import '../../models/bookish_backup.dart';
import '../local_export_repository.dart';

@LazySingleton(as: LocalExportRepository)
class FilePickerLocalExportRepository implements LocalExportRepository {
  const FilePickerLocalExportRepository(this._picker);

  final FilePickerGateway _picker;

  @override
  Future<bool> exportNotes(Audiobook book, List<BookNote> notes) async {
    final buffer = StringBuffer()
      ..writeln('# ${book.title}')
      ..writeln()
      ..writeln(book.author.isEmpty ? '' : 'Author: ${book.author}\n');
    for (final note in notes) {
      buffer
        ..writeln('## ${_formatTimestamp(note.positionMs)}')
        ..writeln(note.text)
        ..writeln();
    }
    return _writeExportFile(
      filename: '${_buildSafeFilename(book.title)}-notes.md',
      contents: buffer.toString(),
      extensions: const ['md'],
    );
  }

  @override
  Future<bool> exportBackup(BookishBackup backup) {
    return _writeExportFile(
      filename: 'bookish-backup.json',
      contents: const JsonEncoder.withIndent('  ').convert(backup.toJson()),
      extensions: const ['json'],
    );
  }

  @override
  Future<BookishBackup?> pickBackup() async {
    final result = await _picker.pickJson();
    final bytes = result?.files.single.bytes;
    if (bytes == null) {
      return null;
    }
    return BookishBackup.fromJson(
      Map<String, dynamic>.from(jsonDecode(utf8.decode(bytes)) as Map),
    );
  }

  Future<bool> _writeExportFile({
    required String filename,
    required String contents,
    required List<String> extensions,
  }) async {
    final path = await _picker.saveFile(
      filename: filename,
      extensions: extensions,
      bytes: Uint8List.fromList(utf8.encode(contents)),
    );
    return path != null;
  }

  String _formatTimestamp(int milliseconds) {
    final duration = Duration(milliseconds: milliseconds);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  String _buildSafeFilename(String value) => value
      .replaceAll(RegExp('[^a-zA-Z0-9 _-]'), '')
      .trim()
      .replaceAll(RegExp(r'\s+'), '-');
}
