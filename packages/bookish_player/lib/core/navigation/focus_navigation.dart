import 'package:flutter/widgets.dart';

void dismissRestoredRouteFocus() {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    FocusManager.instance.primaryFocus?.unfocus();
  });
}
