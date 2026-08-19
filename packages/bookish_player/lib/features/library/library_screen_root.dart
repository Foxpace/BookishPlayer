import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/di/injection.dart';
import '../../core/localization/generated/l10n.dart';
import '../../core/navigation/app_router.dart';
import '../../core/navigation/import_source.dart';
import '../../core/navigation/focus_navigation.dart';
import '../../core/presentation/app_message.dart';
import '../importing/models/import_route_result.dart';
import '../player/cubits/player_cubit.dart';
import 'cubits/library_cubit.dart';
import 'cubits/library_intents.dart';
import 'cubits/library_cubits.dart';
import 'models/library_models.dart';
import 'ui/library_screen.dart';
import 'ui/widgets/audiobook_removal_dialog.dart';
import 'ui/widgets/full_title_dialog.dart';
import 'ui/widgets/library_controls.dart';
import 'ui/widgets/library_view_sheet.dart';
import 'use_cases/library_use_cases.dart';

/// Composition boundary for the library feature.
class LibraryScreenRoot extends StatelessWidget {
  const LibraryScreenRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LibraryCubit>(
      create: (_) => LibraryCubit(
        getIt<LibraryUseCases>(),
        getIt<PlayerCubit>().removeBook,
      )..load(),
      child: BlocConsumer<LibraryCubit, LibraryState>(
        listenWhen: (previous, current) =>
            current.message != null &&
            previous.effectRevision != current.effectRevision,
        listener: _showMessage,
        builder: (context, state) {
          final cubit = context.read<LibraryCubit>();
          return LibraryScreen(
            state: state,
            intents: (
              importBooks: () => importAudiobooks(
                context,
                (source) => _openImport(context, cubit, source),
              ),
              openNotes: () => context.pushNamed(AppRoutes.notes),
              openSettings: () => context.pushNamed(AppRoutes.settings),
              queryChanged: cubit.setQuery,
              openView: () => _showLibraryView(context, cubit),
              openBook: (book) => _openBook(context, cubit, book),
              removeBook: (book) => _removeBook(context, cubit, book),
              bookAction: (book, action) =>
                  _handleBookAction(context, cubit, book, action),
            ),
          );
        },
      ),
    );
  }

  void _showMessage(BuildContext context, LibraryState state) {
    final message = state.message;
    if (message != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message.localize(context))));
    }
    context.read<LibraryCubit>().clearMessage();
  }

  Future<void> _openImport(
    BuildContext context,
    LibraryCubit cubit,
    ImportSource source,
  ) async {
    final result = await context.pushNamed<ImportRouteResult>(
      AppRoutes.import,
      extra: source,
    );
    if ((result?.importedCount ?? 0) > 0 && context.mounted) {
      await cubit.load();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).audiobookImported)),
        );
      }
    }
  }

  Future<void> _showLibraryView(BuildContext context, LibraryCubit cubit) {
    return showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (_) => BlocBuilder<LibraryCubit, LibraryState>(
        bloc: cubit,
        builder: (context, state) => LibraryViewSheet(
          state: state,
          intents: (
            filter: cubit.setFilter,
            grouping: cubit.setGrouping,
            sort: cubit.setSort,
            layout: cubit.setLayout,
          ),
        ),
      ),
    );
  }

  Future<void> _openBook(
    BuildContext context,
    LibraryCubit cubit,
    Audiobook book,
  ) async {
    await context.pushNamed<void>(
      AppRoutes.player,
      pathParameters: {'bookId': book.id},
    );
    if (context.mounted) {
      dismissRestoredRouteFocus();
      await cubit.load();
    }
  }

  Future<void> _removeBook(
    BuildContext context,
    LibraryCubit cubit,
    Audiobook book,
  ) async {
    final mode = await showAudiobookRemovalDialog(context, book);
    if (mode != null && context.mounted) {
      await cubit.deleteBook(book, mode);
    }
  }

  Future<void> _handleBookAction(
    BuildContext context,
    LibraryCubit cubit,
    Audiobook book,
    BookAction action,
  ) async {
    switch (action) {
      case BookAction.toggleFavorite:
        await cubit.toggleFavorite(book);
      case BookAction.wantToListen:
        await cubit.setListeningStatus(book, ListeningStatus.wantToListen);
      case BookAction.markFinished:
        await cubit.setListeningStatus(book, ListeningStatus.finished);
      case BookAction.markUnfinished:
        await cubit.setListeningStatus(book, ListeningStatus.inProgress);
      case BookAction.useProgressStatus:
        await cubit.setListeningStatus(book, null);
      case BookAction.viewFullTitle:
        await showFullBookTitle(context, book);
      case BookAction.editMetadata:
        await context.pushNamed<void>(
          AppRoutes.editBook,
          pathParameters: {'bookId': book.id},
        );
        if (context.mounted) {
          await cubit.load();
        }
      case BookAction.removeFromDevice:
        await _removeBook(context, cubit, book);
    }
  }
}
