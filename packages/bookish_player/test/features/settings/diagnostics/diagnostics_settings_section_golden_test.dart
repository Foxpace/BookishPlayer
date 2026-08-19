import 'package:bookish_player/features/settings/diagnostics/use_cases/diagnostics_workflow.dart';
import 'package:bookish_player/features/settings/diagnostics/repos/diagnostics_export_repository.dart';
import 'package:bookish_player/features/settings/diagnostics/cubits/diagnostics_cubit.dart';
import 'package:bookish_player/features/settings/diagnostics/ui/diagnostics_settings_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../test_support/support/fakes/fake_app_diagnostics.dart';
import '../../../../test_support/support/pump_bookish_app.dart';

void main() {
  group('Diagnostics settings capability', () {
    testWidgets(
      'Given the diagnostics settings capability, When rendered in the light English appearance, Then it matches the approved golden',
      (tester) async {
        // GIVEN
        final cubit = _cubit();
        // WHEN
        await tester.pumpBookishApp(
          display: const (
            themeMode: ThemeMode.light,
            locale: Locale('en'),
            viewport: Size(390, 500),
            textScale: 1,
          ),
          blocProviders: [
            (child) => BlocProvider.value(value: cubit, child: child),
          ],
          child: _screen(cubit),
        );

        // THEN
        await expectLater(
          find.byType(Scaffold),
          matchesGoldenFile('goldens/diagnostics_settings_light_en.png'),
        );
        await cubit.close();
      },
    );

    testWidgets(
      'Given the diagnostics settings capability, When rendered in the dark Slovak appearance with large text, Then it matches the approved golden',
      (tester) async {
        // GIVEN
        final cubit = _cubit();
        // WHEN
        await tester.pumpBookishApp(
          display: const (
            themeMode: ThemeMode.dark,
            locale: Locale('sk'),
            viewport: Size(500, 700),
            textScale: 1.3,
          ),
          blocProviders: [
            (child) => BlocProvider.value(value: cubit, child: child),
          ],
          child: _screen(cubit),
        );

        // THEN
        await expectLater(
          find.byType(Scaffold),
          matchesGoldenFile('goldens/diagnostics_settings_dark_sk.png'),
        );
        await cubit.close();
      },
    );
  });
}

Widget _screen(DiagnosticsCubit cubit) {
  return Scaffold(
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: DiagnosticsSettingsSection(
          state: cubit.state,
          onExport: cubit.export,
          onDelete: cubit.clear,
        ),
      ),
    ),
  );
}

DiagnosticsCubit _cubit() => DiagnosticsCubit(
  DiagnosticsWorkflow(FakeAppDiagnostics(), _FakeDiagnosticsExporter()),
);

class _FakeDiagnosticsExporter implements DiagnosticsExportRepository {
  @override
  Future<bool> export(String sourcePath) async => true;
}
