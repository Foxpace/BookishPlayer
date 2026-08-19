import 'package:bookish_player/features/editing/cubits/metadata_editor_cubit.dart';
import 'package:bookish_player/features/editing/repos/implementations/library_book_editing_repository.dart';
import 'package:bookish_player/features/editing/use_cases/editing_application.dart';
import 'package:bookish_player/features/importing/repos/file_import_repository.dart';
import 'package:bookish_player/features/library/repos/audiobook_catalog_repository.dart';

MetadataEditorCubit createMetadataEditorCubit(
  AudiobookCatalogRepository books,
  FileImportRepository files,
) {
  final repository = LibraryBookEditingRepository(books, files);
  return MetadataEditorCubit(EditingApplication(repository));
}
