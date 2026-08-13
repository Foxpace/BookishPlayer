import 'package:freezed_annotation/freezed_annotation.dart';

import 'audiobook.dart';

part 'library_load_result.freezed.dart';

@freezed
abstract class LibraryLoadResult with _$LibraryLoadResult {
  const factory LibraryLoadResult({
    required List<Audiobook> books,
    required String layout,
  }) = _LibraryLoadResult;
}
