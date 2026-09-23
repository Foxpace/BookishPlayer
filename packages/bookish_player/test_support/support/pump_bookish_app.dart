import 'package:bookish_player/core/localization/generated/l10n.dart';
import 'package:bookish_player/core/theme/bookish_theme.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

extension PumpBookishApp on WidgetTester {
  Future<void> pumpBookishApp({
    Widget? child,
    GoRouter? router,
    List<Widget Function(Widget child)> blocProviders = const [],
    ({ThemeMode themeMode, Locale locale, Size viewport, double textScale})
    display = const (
      themeMode: ThemeMode.light,
      locale: Locale('en'),
      viewport: Size(390, 844),
      textScale: 1,
    ),
  }) async {
    assert((child == null) != (router == null));
    view
      ..physicalSize = display.viewport
      ..devicePixelRatio = 1;
    addTearDown(view.resetPhysicalSize);
    addTearDown(view.resetDevicePixelRatio);

    Widget app = router == null
        ? MaterialApp(
            theme: BookishTheme.light,
            darkTheme: BookishTheme.dark,
            themeMode: display.themeMode,
            locale: display.locale,
            localizationsDelegates: const [
              S.delegate,
              ...GlobalMaterialLocalizations.delegates,
            ],
            supportedLocales: S.delegate.supportedLocales,
            builder: (context, content) => MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: TextScaler.linear(display.textScale)),
              child: content ?? const SizedBox.shrink(),
            ),
            home: child,
          )
        : MaterialApp.router(
            theme: BookishTheme.light,
            darkTheme: BookishTheme.dark,
            themeMode: display.themeMode,
            locale: display.locale,
            localizationsDelegates: const [
              S.delegate,
              ...GlobalMaterialLocalizations.delegates,
            ],
            supportedLocales: S.delegate.supportedLocales,
            routerConfig: router,
            builder: (context, content) => MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: TextScaler.linear(display.textScale)),
              child: content ?? const SizedBox.shrink(),
            ),
          );
    if (blocProviders.isNotEmpty) {
      app = blocProviders.reversed.fold(
        app,
        (child, provider) => provider(child),
      );
    }
    await pumpWidget(app);
    await pump();
  }
}
