import 'package:bookish_player/core/foundation/id_generator.dart';

class FakeIdGenerator implements IdGenerator {
  FakeIdGenerator([this.prefix = 'test-id']);

  final String prefix;
  var _next = 0;

  @override
  String generate() => '$prefix-${_next++}';
}
