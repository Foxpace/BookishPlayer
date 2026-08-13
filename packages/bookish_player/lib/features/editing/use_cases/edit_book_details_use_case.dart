import 'package:injectable/injectable.dart';
import '../../library/models/library_models.dart';
import '../models/editable_book_details.dart';
import '../repos/book_editing_repository.dart';

@injectable
class EditBookDetailsUseCase {
  const EditBookDetailsUseCase(this._books);

  final BookEditingRepository _books;

  Future<Audiobook> call(Audiobook book, EditableBookDetails details) => _save(
    book.copyWith(
      title: details.title.trim(),
      author: details.author.trim(),
      series: details.series.trim(),
      seriesPosition: double.tryParse(details.seriesPosition.trim()),
      narrator: details.narrator.trim(),
      year: _parseYear(details.year),
      folder: details.folder.trim().isEmpty
          ? 'Imported'
          : details.folder.trim(),
    ),
  );

  int? _parseYear(String value) {
    final parsed = int.tryParse(value.trim());
    return parsed != null && parsed >= 1000 && parsed <= 2999 ? parsed : null;
  }

  Future<Audiobook> _save(Audiobook book) async {
    await _books.saveBook(book);
    return book;
  }
}
