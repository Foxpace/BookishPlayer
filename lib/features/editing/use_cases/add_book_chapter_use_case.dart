import 'package:injectable/injectable.dart';
import '../../library/models/library_models.dart';
import '../repos/book_editing_repository.dart';

@injectable
class AddBookChapterUseCase {
  const AddBookChapterUseCase(this._books);

  final BookEditingRepository _books;

  Future<Audiobook> call(
    Audiobook book,
    String title,
    Duration position,
  ) async {
    final chapters = [
      ...book.chapters,
      AudioChapter(title: title.trim(), startMs: position.inMilliseconds),
    ]..sort((a, b) => a.startMs.compareTo(b.startMs));
    final updated = book.copyWith(chapters: chapters);
    await _books.saveBook(updated);
    return updated;
  }
}
