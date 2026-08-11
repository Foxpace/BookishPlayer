import 'package:bookish_player/features/importing/repos/audiobook_artwork_extractor.dart';
import 'package:bookish_player/features/importing/repos/import_repositories.dart';
import 'package:bookish_player/features/library/cubits/library_cubit.dart';
import 'package:bookish_player/features/library/repos/audiobook_catalog_repository.dart';
import 'package:bookish_player/features/library/use_cases/library_use_case_bundle.dart';
import 'package:bookish_player/features/library/use_cases/load_library_use_case.dart';
import 'package:bookish_player/features/library/use_cases/remove_audiobook_use_case.dart';
import 'package:bookish_player/features/settings/repos/settings_repository.dart';

LibraryCubit createLibraryCubit({
  required AudiobookCatalogRepository books,
  required SettingsRepository settings,
  required FileImportRepository files,
  required AudiobookArtworkExtractor artwork,
  Future<void> Function(String bookId)? prepareBookRemoval,
}) => LibraryCubit(
  LibraryUseCases(
    loadLibrary: LoadLibraryUseCase(books, artwork, settings),
    removeBook: RemoveAudiobookUseCase(books, files),
    saveLayout: SaveLibraryLayoutUseCase(settings),
    saveBook: SaveLibraryBookUseCase(books),
  ),
  prepareBookRemoval ?? _completeRemoval,
);

Future<void> _completeRemoval(String bookId) async {}
