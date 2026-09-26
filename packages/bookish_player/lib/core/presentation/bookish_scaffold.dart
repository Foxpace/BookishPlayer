import 'package:material_ui/material_ui.dart';

import 'bottom_overlay_space.dart';

class BookishScaffold extends StatelessWidget {
  const BookishScaffold({
    required this.body,
    this.appBar,
    this.floatingActionButton,
    this.safeArea = const (enabled: true, top: null),
    this.reserveBottomOverlaySpace = true,
    this.resizeToAvoidBottomInset = true,
    super.key,
  });

  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? floatingActionButton;
  final ({bool enabled, bool? top}) safeArea;
  final bool reserveBottomOverlaySpace;
  final bool resizeToAvoidBottomInset;

  @override
  Widget build(BuildContext context) {
    final bottomOverlayHeight = reserveBottomOverlaySpace
        ? BottomOverlaySpace.of(context)
        : 0.0;
    final content = safeArea.enabled
        ? SafeArea(top: safeArea.top ?? appBar == null, child: body)
        : body;

    return Scaffold(
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: appBar,
      body: content,
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: bottomOverlayHeight > 0
          ? SizedBox(height: bottomOverlayHeight)
          : null,
    );
  }
}
