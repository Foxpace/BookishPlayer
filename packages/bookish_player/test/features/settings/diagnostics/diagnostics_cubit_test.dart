import 'package:bookish_player/core/diagnostics/app_diagnostics.dart';
import 'package:bookish_player/features/settings/diagnostics/use_cases/diagnostics_workflow.dart';
import 'package:bookish_player/features/settings/diagnostics/use_cases/delete_diagnostics_use_case.dart';
import 'package:bookish_player/features/settings/diagnostics/use_cases/diagnostics_use_cases.dart';
import 'package:bookish_player/features/settings/diagnostics/repos/diagnostics_export_repository.dart';
import 'package:bookish_player/features/settings/diagnostics/cubits/diagnostics_cubit.dart';
import 'package:bookish_player/features/settings/diagnostics/cubits/diagnostics_message.dart';
import 'package:bookish_player/features/settings/diagnostics/cubits/diagnostics_status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DiagnosticsCubit', () {
    late _FakeDiagnostics diagnostics;
    late _FakeDiagnosticsExporter exporter;
    late DiagnosticsCubit sut;

    setUp(() {
      diagnostics = _FakeDiagnostics();
      exporter = _FakeDiagnosticsExporter();
      sut = _cubit(DiagnosticsWorkflow(diagnostics, exporter));
    });

    tearDown(() => sut.close());

    test(
      'Given a local diagnostics file, When the user exports diagnostics, Then the file is forwarded and a revisioned effect is emitted',
      () async {
        // GIVEN
        diagnostics.sourcePath = '/safe/diagnostics.jsonl';

        // WHEN
        await sut.export();

        // THEN
        expect(exporter.exportedPaths, ['/safe/diagnostics.jsonl']);
        expect(sut.state.status, DiagnosticsStatus.success);
        expect(sut.state.message, DiagnosticsMessage.exported);
        expect(sut.state.effectRevision, 1);
      },
    );

    test(
      'Given no recorded local diagnostics, When the user requests an export, Then no platform export is opened',
      () async {
        // WHEN
        await sut.export();

        // THEN
        expect(exporter.exportedPaths, isEmpty);
        expect(sut.state.message, DiagnosticsMessage.noRecords);
      },
    );

    test(
      'Given locally recorded diagnostics, When the user deletes them, Then the local store is cleared and success is emitted',
      () async {
        // GIVEN
        diagnostics.sourcePath = '/diagnostics.jsonl';

        // WHEN
        await sut.clear();

        // THEN
        expect(diagnostics.clearCalls, 1);
        expect(sut.state.message, DiagnosticsMessage.deleted);
      },
    );
  });
}

DiagnosticsCubit _cubit(DiagnosticsWorkflow workflow) => DiagnosticsCubit(
  DiagnosticsUseCases(
    ExportDiagnosticsUseCase(workflow),
    DeleteDiagnosticsUseCase(workflow),
  ),
);

class _FakeDiagnostics implements AppDiagnostics {
  String? sourcePath;
  var clearCalls = 0;
  final recordedOperations = <String>[];

  @override
  Future<void> clear() async {
    clearCalls++;
  }

  @override
  Future<String?> exportPath() async => sourcePath;

  @override
  Future<void> record(
    Object error,
    StackTrace stackTrace, {
    required String operation,
  }) async {
    recordedOperations.add(operation);
  }
}

class _FakeDiagnosticsExporter implements DiagnosticsExportRepository {
  final exportedPaths = <String>[];
  var result = true;

  @override
  Future<bool> export(String sourcePath) async {
    exportedPaths.add(sourcePath);
    return result;
  }
}
