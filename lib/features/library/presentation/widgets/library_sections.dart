part of '../library_screen.dart';

class _LibrarySectionView extends StatelessWidget {
  const _LibrarySectionView({
    required this.section,
    required this.showTitle,
    required this.layout,
  });

  final LibrarySection section;
  final bool showTitle;
  final LibraryLayout layout;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showTitle) ...[
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 8, 4, 10),
            child: Text(
              section.title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
          ),
        ],
        if (layout == LibraryLayout.list)
          for (var index = 0; index < section.books.length; index++) ...[
            if (index > 0) const SizedBox(height: 12),
            _BookTile(book: section.books[index]),
          ]
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 220,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: .54,
            ),
            itemCount: section.books.length,
            itemBuilder: (context, index) =>
                _BookGridTile(book: section.books[index]),
          ),
      ],
    );
  }
}

class _EmptyLibrary extends StatelessWidget {
  const _EmptyLibrary();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(36),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.library_music_outlined,
            size: 64,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(height: 22),
          Text(
            'A quiet shelf, for now',
            style: Theme.of(
              context,
            ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 10),
          Text(
            'Import MP3, M4A, M4B, AAC, FLAC, WAV, OGG, or Opus files from your device or cloud storage.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              height: 1.5,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            onPressed: () => _importAudiobooks(context),
            icon: const Icon(Icons.file_open_outlined),
            label: const Text('Choose audiobooks'),
          ),
        ],
      ),
    );
  }
}
