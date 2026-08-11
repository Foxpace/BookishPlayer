import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<GetIt> configureDependencies({
  GetIt? container,
  String environment = 'prod',
}) => (container ?? getIt).init(environment: environment);
