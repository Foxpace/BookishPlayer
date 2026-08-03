import 'package:freezed_annotation/freezed_annotation.dart';

import '../domain/audiobook.dart';

part 'library_state.freezed.dart';

enum LibraryStatus { initial, loading, ready, importing, failure }

enum LibraryGrouping { none, listeningStatus, author, series, folder }

enum LibraryLayout { list, grid }

@freezed
abstract class LibrarySection with _$LibrarySection {
  const factory LibrarySection({
    required String title,
    required List<Audiobook> books,
  }) = _LibrarySection;
}

@freezed
abstract class LibraryState with _$LibraryState {
  const factory LibraryState({
    @Default(LibraryStatus.initial) LibraryStatus status,
    @Default(<Audiobook>[]) List<Audiobook> books,
    @Default(LibraryGrouping.none) LibraryGrouping grouping,
    @Default(LibraryLayout.list) LibraryLayout layout,
    @Default(<LibrarySection>[]) List<LibrarySection> sections,
    String? message,
  }) = _LibraryState;
}
