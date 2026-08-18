import 'dart:convert';
import 'dart:io';

import 'package:bookish_player/core/diagnostics/diagnostics_file_provider.dart';
import 'package:bookish_player/core/diagnostics/local_app_diagnostics.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../test_support/support/fakes/fake_clock.dart';

void main() {
  late Directory directory;
  late File file;
  late LocalAppDiagnostics sut;

  setUp(() {
    directory = Directory.systemTemp.createTempSync(
      'bookish-diagnostics-test-',
    );
    file = File('${directory.path}/diagnostics.jsonl');
    sut = LocalAppDiagnostics(FakeClock(), _FakeFileProvider(file));
  });

  tearDown(() {
    if (directory.existsSync()) {
      directory.deleteSync(recursive: true);
    }
  });

  group('Error containing private content and an absolute path', () {
    test(
      'Given an error containing private content and an absolute path, When it is recorded locally, Then only sanitized bounded metadata is persisted',
      () async {
        // GIVEN
        const privateContent = 'Private Book Title and note transcript';
        final stack = StackTrace.fromString(
          '/Users/person/Library/$privateContent/source.dart:10:2',
        );

        await sut.record(
          StateError(privateContent),
          stack,
          operation: 'player.open',
        );
        // WHEN
        final payload = jsonDecode(file.readAsLinesSync().single) as Map;

        // THEN
        expect(payload['operation'], 'player.open');
        expect(payload['errorType'], 'StateError');
        expect(payload['stack'], contains('<redacted-path>'));
        expect(jsonEncode(payload), isNot(contains(privateContent)));
        expect(payload, containsPair('build', isNotEmpty));
      },
    );
  });

  group('More diagnostic failures than the local retention limit', () {
    test(
      'Given more diagnostic failures than the local retention limit, When records are appended and then deleted, Then only the newest 200 remain and clear removes the file',
      () async {
        // WHEN
        for (var index = 0; index < 205; index++) {
          await sut.record(
            StateError('ignored'),
            StackTrace.fromString('frame $index'),
            operation: 'test.$index',
          );
        }

        // THEN
        expect(file.readAsLinesSync(), hasLength(200));
        expect(await sut.exportPath(), file.path);

        await sut.clear();

        expect(file.existsSync(), isFalse);
      },
    );
  });
}

class _FakeFileProvider implements DiagnosticsFileProvider {
  const _FakeFileProvider(this.file);

  final File file;

  @override
  Future<File> diagnosticsFile() async => file;
}
