import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/presentation/app_message.dart';
import '../models/library_models.dart';

import 'library_status.dart';
import 'library_grouping.dart';
import 'library_layout.dart';
import 'library_filter.dart';
import 'library_sort.dart';
import 'library_section_label.dart';
part 'library_state.freezed.dart';
part 'library_section.dart';

@freezed
abstract class LibraryState with _$LibraryState {
  const factory LibraryState({
    @Default(LibraryStatus.initial) LibraryStatus status,
    @Default(<Audiobook>[]) List<Audiobook> books,
    @Default(LibraryGrouping.none) LibraryGrouping grouping,
    @Default(LibraryLayout.list) LibraryLayout layout,
    @Default('') String query,
    @Default(LibraryFilter.all) LibraryFilter filter,
    @Default(LibrarySort.recent) LibrarySort sort,
    @Default(<LibrarySection>[]) List<LibrarySection> sections,
    AppMessage? message,
    @Default(0) int effectRevision,
  }) = _LibraryState;
}
