import 'package:injectable/injectable.dart';

import '../../library/models/library_models.dart';
import '../repos/book_editing_repository.dart';
import 'edit_book_details_use_case.dart';
import 'change_book_cover_use_case.dart';
import 'reorder_book_tracks_use_case.dart';
import 'add_book_chapter_use_case.dart';
import 'delete_book_chapter_use_case.dart';

part 'load_book_for_editing_use_case.dart';
part 'editing_chapter_use_cases.dart';

@injectable
class EditingUseCases {
  const EditingUseCases({
    required this.loadBook,
    required this.editDetails,
    required this.changeCover,
    required this.reorderTracks,
    required this.chapters,
  });

  final LoadBookForEditingUseCase loadBook;
  final EditBookDetailsUseCase editDetails;
  final ChangeBookCoverUseCase changeCover;
  final ReorderBookTracksUseCase reorderTracks;
  final EditingChapterUseCases chapters;

  AddBookChapterUseCase get addChapter => chapters.add;
  DeleteBookChapterUseCase get deleteChapter => chapters.delete;
}
