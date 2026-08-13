import 'package:injectable/injectable.dart';
import '../../library/models/library_models.dart';
import '../repos/book_editing_repository.dart';

@injectable
class ReorderBookTracksUseCase {
  const ReorderBookTracksUseCase(this._books);

  final BookEditingRepository _books;

  Future<Audiobook> call(Audiobook book, int oldIndex, int newIndex) async {
    final tracks = [...book.playableTracks];
    final moved = tracks.removeAt(oldIndex);
    tracks.insert(newIndex, moved);
    final updated = book.copyWith(
      tracks: [
        for (var index = 0; index < tracks.length; index++)
          tracks[index].copyWith(order: index),
      ],
    );
    await _books.saveBook(updated);
    return updated;
  }
}
