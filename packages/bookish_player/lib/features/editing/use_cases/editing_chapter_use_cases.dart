part of 'editing_use_cases.dart';

@injectable
class EditingChapterUseCases {
  const EditingChapterUseCases(this.add, this.delete);

  final AddBookChapterUseCase add;
  final DeleteBookChapterUseCase delete;
}
