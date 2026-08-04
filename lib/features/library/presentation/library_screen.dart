import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/localization/generated/l10n.dart';
import '../../../core/navigation/app_router.dart';
import '../../../core/presentation/book_cover.dart';
import '../../../core/presentation/formatters.dart';
import '../../player/presentation/player_cubit.dart';
import '../domain/audiobook.dart';
import 'library_cubit.dart';
import 'library_state.dart';

part 'widgets/library_controls.dart';
part 'widgets/library_view_sheet.dart';
part 'widgets/library_sections.dart';
part 'widgets/book_tiles.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LibraryCubit, LibraryState>(
      listenWhen: (previous, current) =>
          current.message != null && previous.message != current.message,
      listener: (context, state) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(state.message!)));
        context.read<LibraryCubit>().clearMessage();
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          tooltip: 'Import audiobooks',
          onPressed: () => _importAudiobooks(context),
          child: const Icon(Icons.add_rounded),
        ),
        body: SafeArea(
          child: BlocBuilder<LibraryCubit, LibraryState>(
            builder: (context, state) {
              if (state.status == LibraryStatus.loading &&
                  state.books.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }
              return CustomScrollView(
                slivers: [
                  const SliverPadding(
                    padding: EdgeInsets.fromLTRB(24, 28, 24, 20),
                    sliver: SliverToBoxAdapter(child: _Header()),
                  ),
                  if (state.books.isNotEmpty)
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                      sliver: SliverToBoxAdapter(
                        child: _LibrarySearchControls(state: state),
                      ),
                    ),
                  if (state.books.isEmpty)
                    const SliverFillRemaining(
                      hasScrollBody: false,
                      child: _EmptyLibrary(),
                    )
                  else if (state.sections.isEmpty)
                    const SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Text('No books match these filters.'),
                      ),
                    )
                  else
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
                      sliver: SliverList.separated(
                        itemCount: state.sections.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 12),
                        itemBuilder: (context, index) => _LibrarySectionView(
                          section: state.sections[index],
                          showTitle: state.grouping != LibraryGrouping.none,
                          layout: state.layout,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
