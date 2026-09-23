import 'package:bookish_player/core/localization/generated/l10n.dart';
import 'package:material_ui/material_ui.dart';

import 'player_test_support.dart';

class PlayerTestApp extends StatelessWidget {
  const PlayerTestApp({required this.home, this.navigatorKey, super.key});

  final Widget home;
  final GlobalKey<NavigatorState>? navigatorKey;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      localizationsDelegates: const [
        S.delegate,
        ...GlobalMaterialLocalizations.delegates,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: home,
    );
  }
}
