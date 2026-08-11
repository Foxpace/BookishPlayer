import 'package:bookish_player/features/editing/cubits/metadata_editor_cubit.dart';
import 'package:bookish_player/features/editing/repos/implementations/library_book_editing_repository.dart';
import 'package:bookish_player/features/editing/use_cases/editing_use_cases_barrel.dart';
import 'package:bookish_player/features/importing/repos/import_repositories.dart';
import 'package:bookish_player/features/library/repos/audiobook_catalog_repository.dart';

MetadataEditorCubit createMetadataEditorCubit(
  AudiobookCatalogRepository books,
  FileImportRepository files,
) {
  final repository = LibraryBookEditingRepository(books, files);
  return MetadataEditorCubit(
    EditingUseCases(
      loadBook: LoadBookForEditingUseCase(repository),
      editDetails: EditBookDetailsUseCase(repository),
      changeCover: ChangeBookCoverUseCase(repository),
      reorderTracks: ReorderBookTracksUseCase(repository),
      chapters: EditingChapterUseCases(
        AddBookChapterUseCase(repository),
        DeleteBookChapterUseCase(repository),
      ),
    ),
  );
}
