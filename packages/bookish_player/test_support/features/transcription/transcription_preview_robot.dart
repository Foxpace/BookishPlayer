import '../../support/robots/widget_robot.dart';

final class TranscriptionPreviewRobot extends WidgetRobot {
  const TranscriptionPreviewRobot(super.tester);

  void expectDraft(Iterable<String> labels) {
    for (final label in labels) {
      expectText(label);
    }
  }
}
