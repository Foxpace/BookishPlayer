part of 'library_state.dart';

@freezed
abstract class LibrarySection with _$LibrarySection {
  const factory LibrarySection({
    required List<Audiobook> books,
    @Default('') String title,
    LibrarySectionLabel? label,
  }) = _LibrarySection;
}
