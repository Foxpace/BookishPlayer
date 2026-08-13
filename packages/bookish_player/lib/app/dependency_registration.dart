import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../core/di/injection.dart';
import '../features/transcription/repos/transcription_repository.dart';
import 'dependency_registration.config.dart';

@InjectableInit(ignoreUnregisteredTypes: [TranscriptionRepository])
Future<GetIt> configureDependencies({
  GetIt? container,
  Set<String> environments = const {productionEnvironment},
}) => (container ?? getIt).init(
  environmentFilter: NoEnvOrContainsAny(environments),
);
