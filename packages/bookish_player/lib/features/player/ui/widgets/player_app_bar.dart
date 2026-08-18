import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';

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
      leading: IconButton(
        tooltip: S.of(context).backToLibraryTooltip,
        onPressed: onBack,
        icon: const Icon(Icons.arrow_back_rounded),
      ),
      title: Text(
        S.of(context).nowPlaying,
        style: const TextStyle(fontSize: 11, letterSpacing: 2.4),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          tooltip: S.of(context).settingsTitle,
          onPressed: onOpenSettings,
          icon: const Icon(Icons.settings_outlined),
        ),
      ],
    );
  }
}
