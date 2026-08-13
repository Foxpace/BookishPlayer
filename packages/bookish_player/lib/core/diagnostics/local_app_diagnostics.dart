import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:injectable/injectable.dart';

import '../app_metadata.dart';
import '../foundation/clock.dart';
import 'app_diagnostics.dart';
import 'app_error.dart';
import 'diagnostics_file_provider.dart';

@LazySingleton(as: AppDiagnostics)
class LocalAppDiagnostics implements AppDiagnostics {
  LocalAppDiagnostics(this._clock, this._files);

  static const _maximumRecords = 200;
  static final _absolutePath = RegExp(
    r'(?:/[\w .-]+){2,}|(?:[A-Za-z]:\\[^\s]+)',
  );

  final Clock _clock;
  final DiagnosticsFileProvider _files;
  var _pendingWrite = Future<void>.value();

  @override
  Future<void> record(
    Object error,
    StackTrace stackTrace, {
    required String operation,
  }) {
    final entry = AppError(
      time: _clock.now().toUtc().toIso8601String(),
      operation: operation,
      errorType: error.runtimeType.toString(),
      stack: _sanitizeStack(stackTrace),
      platform: Platform.operatingSystem,
      platformVersion: Platform.operatingSystemVersion,
      build: appVersion,
    );
    _pendingWrite = _pendingWrite.then((_) => _append(entry));
    return _pendingWrite;
  }

  @override
  Future<String?> exportPath() async {
    await _pendingWrite;
    final file = await _files.diagnosticsFile();
    return file.existsSync() ? file.path : null;
  }

  @override
  Future<void> clear() async {
    await _pendingWrite;
    final file = await _files.diagnosticsFile();
    if (file.existsSync()) {
      file.deleteSync();
    }
  }

  Future<void> _append(AppError entry) async {
    final file = await _files.diagnosticsFile();
    final existing = file.existsSync()
        ? file.readAsLinesSync()
        : const <String>[];
    final records = [...existing, jsonEncode(entry.toJson())];
    final retained = records.length <= _maximumRecords
        ? records
        : records.sublist(records.length - _maximumRecords);
    file.writeAsStringSync('${retained.join('\n')}\n', flush: true);
  }

  String _sanitizeStack(StackTrace stackTrace) => stackTrace
      .toString()
      .replaceAll(_absolutePath, '<redacted-path>')
      .split('\n')
      .take(80)
      .join('\n');
}
