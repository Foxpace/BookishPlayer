import 'package:injectable/injectable.dart';

import '../../settings/repos/settings_repository.dart';
import 'load_library_use_case.dart';
import 'remove_audiobook_use_case.dart';
import 'save_library_book_use_case.dart';

part 'save_library_layout_use_case.dart';

@injectable
class LibraryUseCases {
  const LibraryUseCases({
    required this.loadLibrary,
    required this.removeBook,
    required this.saveLayout,
    required this.saveBook,
  });

  final LoadLibraryUseCase loadLibrary;
  final RemoveAudiobookUseCase removeBook;
  final SaveLibraryLayoutUseCase saveLayout;
  final SaveLibraryBookUseCase saveBook;
}
