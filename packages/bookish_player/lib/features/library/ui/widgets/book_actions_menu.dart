import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';
import '../../cubits/library_intents.dart';
import '../../models/library_models.dart';

class BookActionsMenu extends StatelessWidget {
  const BookActionsMenu({
    required this.book,
    required this.onSelected,
    this.compact = false,
    super.key,
  });

  final Audiobook book;
  final ValueChanged<BookAction> onSelected;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final button = PopupMenuButton<BookAction>(
      tooltip: S.of(context).bookActions,
      padding: EdgeInsets.zero,
      iconSize: compact ? 20 : 24,
      onSelected: onSelected,
      itemBuilder: (_) => _menuItems(context),
    );
    return compact ? SizedBox.square(dimension: 40, child: button) : button;
  }

  List<PopupMenuEntry<BookAction>> _menuItems(BuildContext context) => [
    PopupMenuItem(
      value: BookAction.toggleFavorite,
      child: Text(
        book.isFavorite
            ? S.of(context).removeFavorite
            : S.of(context).addFavorite,
      ),
    ),
    PopupMenuItem(
      value: BookAction.wantToListen,
      child: Text(S.of(context).wantToListen),
    ),
    PopupMenuItem(
      value: BookAction.markFinished,
      child: Text(S.of(context).markFinished),
    ),
    PopupMenuItem(
      value: BookAction.markUnfinished,
      child: Text(S.of(context).markUnfinished),
    ),
    if (book.statusOverride != null)
      PopupMenuItem(
        value: BookAction.useProgressStatus,
        child: Text(S.of(context).useProgressStatus),
      ),
    const PopupMenuDivider(),
    PopupMenuItem(
      value: BookAction.viewFullTitle,
      child: Text(S.of(context).viewFullTitle),
    ),
    PopupMenuItem(
      value: BookAction.editMetadata,
      child: Text(S.of(context).editMetadata),
    ),
    PopupMenuItem(
      value: BookAction.removeFromDevice,
      child: Text(S.of(context).removeFromDevice),
    ),
  ];
}
