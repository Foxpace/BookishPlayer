import 'package:material_ui/material_ui.dart';

class BottomOverlaySpace extends InheritedWidget {
  const BottomOverlaySpace({
    required this.height,
    required super.child,
    super.key,
  });

  final double height;

  static double of(BuildContext context) =>
      context
          .dependOnInheritedWidgetOfExactType<BottomOverlaySpace>()
          ?.height ??
      0;

  @override
  bool updateShouldNotify(BottomOverlaySpace oldWidget) =>
      height != oldWidget.height;
}
