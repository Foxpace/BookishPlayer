import 'package:flutter/material.dart';

class BookishScaffold extends StatelessWidget {
  const BookishScaffold({
    required this.body,
    this.appBar,
    this.floatingActionButton,
    this.safeArea = const (enabled: true, top: null),
    super.key,
  });

  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? floatingActionButton;
  final ({bool enabled, bool? top}) safeArea;

  @override
  Widget build(BuildContext context) {
    final content = safeArea.enabled
        ? SafeArea(top: safeArea.top ?? appBar == null, child: body)
        : body;

    return Scaffold(
      appBar: appBar,
      body: content,
      floatingActionButton: floatingActionButton,
    );
  }
}
