import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';
import 'player_top_button.dart';

class PlayerAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PlayerAppBar({
    required this.onBack,
    required this.onOpenSettings,
    super.key,
  });

  final VoidCallback onBack;
  final VoidCallback onOpenSettings;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      leadingWidth: 64,
      leading: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: PlayerTopButton(
          tooltip: S.of(context).backToLibraryTooltip,
          onPressed: onBack,
          icon: Icons.arrow_back_rounded,
        ),
      ),
      title: Text(
        S.of(context).nowPlaying,
        style: const TextStyle(fontSize: 11, letterSpacing: 2.4),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 12),
          child: PlayerTopButton(
            tooltip: S.of(context).settingsTitle,
            onPressed: onOpenSettings,
            icon: Icons.settings_outlined,
          ),
        ),
      ],
    );
  }
}
