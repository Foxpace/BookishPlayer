import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';
import 'id_generator.dart';

@LazySingleton(as: IdGenerator)
class UuidGenerator implements IdGenerator {
  const UuidGenerator();

  @override
  String generate() => const Uuid().v4();
}
