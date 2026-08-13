part of 'editing_use_cases.dart';

@injectable
class LoadBookForEditingUseCase {
  const LoadBookForEditingUseCase(this._books);

  final BookEditingRepository _books;

  Future<Audiobook> call(String bookId) async {
    final book = await _books.loadBook(bookId);
    if (book == null) {
      throw StateError('Audiobook "$bookId" was not found.');
    }
    return book;
  }
}
