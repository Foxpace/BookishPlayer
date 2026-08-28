import 'package:flutter/material.dart';

import '../../../../core/localization/generated/l10n.dart';
import '../../../../core/presentation/book_cover.dart';
import '../../../library/models/library_models.dart';

typedef ContinueListeningIntents = ({
  VoidCallback continueBook,
  VoidCallback cancel,
});

Future<void> showContinueListeningSheet(
  BuildContext context, {
  required Audiobook book,
  required ContinueListeningIntents intents,
}) => showModalBottomSheet<void>(
  context: context,
  isScrollControlled: true,
  isDismissible: false,
  enableDrag: false,
  builder: (_) => ContinueListeningSheet(book: book, intents: intents),
);

class ContinueListeningSheet extends StatelessWidget {
  const ContinueListeningSheet({
    required this.book,
    required this.intents,
    super.key,
  });

  final Audiobook book;
  final ContinueListeningIntents intents;

  @override
  Widget build(BuildContext context) {
    final strings = S.of(context);

    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (book.artworkPath case final artworkPath?) ...[
              Center(
                child: BookCover(
                  title: book.title,
                  artworkPath: artworkPath,
                  layout: const (
                    size: 88,
                    heightFactor: 1.22,
                    imageFit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
            Text(
              strings.continueListeningQuestion(book.title),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            OutlinedButton(
              onPressed: () {
                Navigator.pop(context);
                intents.cancel();
              },
              child: Text(strings.cancel),
            ),
            const SizedBox(height: 10),
            FilledButton.icon(
              onPressed: () {
                Navigator.pop(context);
                intents.continueBook();
              },
              icon: const Icon(Icons.play_arrow_rounded),
              label: Text(strings.play),
            ),
          ],
        ),
      ),
    );
  }
}
