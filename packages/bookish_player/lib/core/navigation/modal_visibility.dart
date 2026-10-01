import 'package:material_ui/material_ui.dart';

class ModalVisibility extends NavigatorObserver with ChangeNotifier {
  var isVisible = false;

  @override
  void didChangeTop(Route<dynamic> topRoute, Route<dynamic>? previousTopRoute) {
    final visible = topRoute is PopupRoute;
    if (isVisible == visible) {
      return;
    }
    isVisible = visible;
    notifyListeners();
  }
}
