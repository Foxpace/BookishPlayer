import 'package:flutter/material.dart';

import '../../../core/localization/generated/l10n.dart';
import '../../../core/presentation/bookish_scaffold.dart';
import '../cubits/library_intents.dart';
import '../cubits/library_cubits.dart';
import '../models/library_models.dart';
import 'widgets/library_header.dart';
import 'widgets/library_search_controls.dart';
import 'widgets/empty_library.dart';
import 'widgets/library_section_view.dart';

typedef LibraryScreenIntents = ({
  VoidCallback importBooks,
  VoidCallback openNotes,
  VoidCallback openSettings,
  ValueChanged<String> queryChanged,
  VoidCallback openView,
  ValueChanged<Audiobook> openBook,
  ValueChanged<Audiobook> removeBook,
  void Function(Audiobook book, BookAction action) bookAction,
});

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({required this.state, required this.intents, super.key});

  final LibraryState state;
  final LibraryScreenIntents intents;

  @override
  Widget build(BuildContext context) {
    return BookishScaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: S.of(context).importAudiobooks,
        onPressed: intents.importBooks,
        child: const Icon(Icons.add_rounded),
      ),
      body: state.status == LibraryStatus.loading && state.books.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
                  sliver: SliverToBoxAdapter(
                    child: LibraryHeader(
                      onOpenNotes: intents.openNotes,
                      onOpenSettings: intents.openSettings,
                    ),
                  ),
                ),
                if (state.books.isNotEmpty)
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                    sliver: SliverToBoxAdapter(
                      child: LibrarySearchControls(
                        state: state,
                        onQueryChanged: intents.queryChanged,
                        onOpenView: intents.openView,
                      ),
                    ),
                  ),
                _LibraryContent(
                  state: state,
                  onImport: intents.importBooks,
                  onOpenBook: intents.openBook,
                  onRemoveBook: intents.removeBook,
                  onBookAction: intents.bookAction,
                ),
              ],
            ),
    );
  }
}

class _LibraryContent extends StatelessWidget {
  const _LibraryContent({
    required this.state,
    required this.onImport,
    required this.onOpenBook,
    required this.onRemoveBook,
    required this.onBookAction,
  });

  final LibraryState state;
  final VoidCallback onImport;
  final ValueChanged<Audiobook> onOpenBook;
  final ValueChanged<Audiobook> onRemoveBook;
  final void Function(Audiobook book, BookAction action) onBookAction;

  @override
  Widget build(BuildContext context) {
    if (state.books.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: EmptyLibrary(onImport: onImport),
      );
    }
    if (state.sections.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(child: Text(S.of(context).noBooksMatchFilters)),
      );
    }
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
      sliver: SliverList.separated(
        itemCount: state.sections.length,
        separatorBuilder: (_, _) => const SizedBox(height: 12),
        itemBuilder: (context, index) => LibrarySectionView(
          section: state.sections[index],
          showTitle: state.grouping != LibraryGrouping.none,
          layout: state.layout,
          actions: (
            open: onOpenBook,
            remove: onRemoveBook,
            select: onBookAction,
          ),
        ),
      ),
    );
  }
}
