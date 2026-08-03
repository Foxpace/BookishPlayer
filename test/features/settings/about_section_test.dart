import 'package:bookish_player/core/localization/generated/l10n.dart';
import 'package:bookish_player/features/settings/presentation/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildApp({Locale locale = const Locale('en')}) => MaterialApp(
    locale: locale,
    localizationsDelegates: const [
      S.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
    ],
    supportedLocales: S.delegate.supportedLocales,
    home: const Scaffold(body: SingleChildScrollView(child: AboutSection())),
  );

  testWidgets('uses the selected locale for About settings', (tester) async {
    await tester.pumpWidget(buildApp(locale: const Locale('sk')));
    await tester.pumpAndSettle();

    expect(find.text('O aplikácii'), findsOneWidget);
    expect(find.text('O aplikácii Bookish'), findsOneWidget);
    expect(find.text('Licencie otvoreného softvéru'), findsOneWidget);
  });

  testWidgets('opens licenses above settings instead of above the dialog', (
    tester,
  ) async {
    await tester.pumpWidget(buildApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('About Bookish'));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsOneWidget);
    expect(
      find.descendant(
        of: find.byType(AlertDialog),
        matching: find.text('Version 0.1.0+1'),
      ),
      findsOneWidget,
    );

    await tester.tap(find.text('View licenses'));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsNothing);
    expect(find.byType(LicensePage), findsOneWidget);
    expect(find.text('Bookish'), findsWidgets);

    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();

    expect(find.byType(LicensePage), findsNothing);
    expect(find.text('About Bookish'), findsOneWidget);
  });
}
