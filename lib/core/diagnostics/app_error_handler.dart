import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import 'app_diagnostics.dart';

@lazySingleton
class AppErrorHandler {
  AppErrorHandler(this._diagnostics);

  final AppDiagnostics _diagnostics;

  void install() {
    final previousFlutterHandler = FlutterError.onError;
    FlutterError.onError = (details) {
      previousFlutterHandler?.call(details);
      unawaited(
        _diagnostics.record(
          details.exception,
          details.stack ?? StackTrace.current,
          operation: 'flutter.framework',
        ),
      );
    };

    final previousPlatformHandler = PlatformDispatcher.instance.onError;
    PlatformDispatcher.instance.onError = (error, stackTrace) {
      unawaited(
        _diagnostics.record(error, stackTrace, operation: 'flutter.platform'),
      );
      return previousPlatformHandler?.call(error, stackTrace) ?? false;
    };
  }

  Future<void> recordUncaught(Object error, StackTrace stackTrace) =>
      _diagnostics.record(error, stackTrace, operation: 'app.uncaught');
}
