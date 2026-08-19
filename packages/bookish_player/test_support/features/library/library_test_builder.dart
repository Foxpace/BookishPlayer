import 'package:bookish_player/features/importing/repos/audiobook_artwork_extractor.dart';
import 'package:bookish_player/features/importing/repos/file_import_repository.dart';
import 'package:bookish_player/features/library/cubits/library_cubit.dart';
import 'package:bookish_player/features/library/repos/audiobook_catalog_repository.dart';
import 'package:bookish_player/features/library/use_cases/library_application.dart';
import 'package:bookish_player/features/settings/repos/settings_repository.dart';

LibraryCubit createLibraryCubit({
  required AudiobookCatalogRepository books,
  required SettingsRepository settings,
  required FileImportRepository files,
  required AudiobookArtworkExtractor artwork,
  Future<void> Function(String bookId)? prepareBookRemoval,
}) => LibraryCubit(
  LibraryApplication(
    books,
    artwork,
    files,
    settings,
    prepareBookRemoval ?? _completeRemoval,
  ),
);

Future<void> _completeRemoval(String bookId) async {}
