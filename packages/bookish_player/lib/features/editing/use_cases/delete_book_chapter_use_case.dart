import 'package:injectable/injectable.dart';
import '../../library/models/library_models.dart';
import '../repos/book_editing_repository.dart';

@injectable
class DeleteBookChapterUseCase {
  const DeleteBookChapterUseCase(this._books);

  final BookEditingRepository _books;

  Future<Audiobook> call(Audiobook book, AudioChapter chapter) async {
    final updated = book.copyWith(
      chapters: book.chapters.where((item) => item != chapter).toList(),
    );
    await _books.saveBook(updated);
    return updated;
  }
}
