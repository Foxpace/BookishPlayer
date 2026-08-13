import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_capabilities.freezed.dart';

@freezed
abstract class AppCapabilities with _$AppCapabilities {
  const factory AppCapabilities({@Default(false) bool transcriptionEnabled}) =
      _AppCapabilities;
}
