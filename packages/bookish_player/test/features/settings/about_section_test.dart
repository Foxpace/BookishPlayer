import 'package:bookish_player/core/localization/generated/l10n.dart';
import 'package:bookish_player/features/settings/cubits/settings_intents.dart';
import 'package:bookish_player/features/settings/ui/widgets/about_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('About section', () {
    Widget buildApp({
      required ValueChanged<SettingsNavigationIntent> onNavigate,
      Locale locale = const Locale('en'),
    }) => MaterialApp(
      locale: locale,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: Scaffold(
        body: SingleChildScrollView(
          child: AboutSection(onNavigate: onNavigate),
        ),
      ),
    );

    testWidgets(
      'Given the about section, When its behavior is exercised, Then uses the selected locale for About settings',
      (tester) async {
        // GIVEN
        await tester.pumpWidget(
          buildApp(locale: const Locale('sk'), onNavigate: (_) {}),
        );
        // WHEN
        await tester.pumpAndSettle();

        // THEN
        expect(find.text('O aplikácii'), findsOneWidget);
        expect(find.text('O aplikácii Bookish'), findsOneWidget);
        expect(find.text('Licencie otvoreného softvéru'), findsOneWidget);
      },
    );

    testWidgets(
      'Given the about section, When its behavior is exercised, Then dispatches typed navigation intents for both destinations',
      (tester) async {
        // GIVEN
        final intents = <SettingsNavigationIntent>[];
        await tester.pumpWidget(buildApp(onNavigate: intents.add));
        await tester.pumpAndSettle();

        await tester.tap(find.text('About Bookish'));
        // WHEN
        await tester.tap(find.text('Open-source licenses'));

        // THEN
        expect(intents, [
          SettingsNavigationIntent.aboutBookish,
          SettingsNavigationIntent.openSourceLicenses,
        ]);
      },
    );
  });
}
