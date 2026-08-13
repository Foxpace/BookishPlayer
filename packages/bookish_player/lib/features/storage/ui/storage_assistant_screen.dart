import 'package:flutter/material.dart';

import '../../../core/localization/generated/l10n.dart';
import '../../../core/presentation/bookish_scaffold.dart';
import '../cubits/storage_assistant_state.dart';
import 'widgets/duplicate_books_section.dart';
import 'widgets/missing_files_section.dart';
import 'widgets/reset_bookish_section.dart';
import 'widgets/storage_overview_card.dart';

class StorageAssistantScreen extends StatelessWidget {
  const StorageAssistantScreen({
    required this.state,
    required this.onClean,
    required this.onRemoveMissing,
    required this.onReset,
    super.key,
  });

  final StorageAssistantState state;
  final VoidCallback onClean;
  final void Function(String id, String title) onRemoveMissing;
  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    final booksById = {for (final book in state.books) book.id: book};
    return BookishScaffold(
      appBar: AppBar(title: Text(S.of(context).storageAssistantTitle)),
      body: state.loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
              children: [
                StorageOverviewCard(report: state.report, onClean: onClean),
                const SizedBox(height: 22),
                MissingFilesSection(
                  bookIds: state.report.missingBookIds,
                  booksById: booksById,
                  onRemove: onRemoveMissing,
                ),
                const SizedBox(height: 22),
                DuplicateBooksSection(
                  groups: state.report.duplicateBookIds,
                  booksById: booksById,
                ),
                const SizedBox(height: 32),
                ResetBookishSection(onReset: onReset),
              ],
            ),
    );
  }
}
