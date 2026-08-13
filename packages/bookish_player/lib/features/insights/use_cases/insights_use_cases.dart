import 'package:injectable/injectable.dart';

import 'load_listening_insights_use_case.dart';

@injectable
class InsightsUseCases {
  const InsightsUseCases({required this.loadListeningInsights});

  final LoadListeningInsightsUseCase loadListeningInsights;
}
