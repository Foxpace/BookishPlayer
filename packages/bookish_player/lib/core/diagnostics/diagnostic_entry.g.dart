// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'diagnostic_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DiagnosticEntry _$DiagnosticEntryFromJson(Map<String, dynamic> json) =>
    _DiagnosticEntry(
      time: json['time'] as String,
      operation: json['operation'] as String,
      errorType: json['errorType'] as String,
      stack: json['stack'] as String,
      platform: json['platform'] as String,
      platformVersion: json['platformVersion'] as String,
      build: json['build'] as String,
      message: json['message'] as String?,
      context:
          (json['context'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const <String, String>{},
      history:
          (json['history'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
      diagnostics:
          (json['diagnostics'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$DiagnosticEntryToJson(_DiagnosticEntry instance) =>
    <String, dynamic>{
      'time': instance.time,
      'operation': instance.operation,
      'errorType': instance.errorType,
      'stack': instance.stack,
      'platform': instance.platform,
      'platformVersion': instance.platformVersion,
      'build': instance.build,
      'message': instance.message,
      'context': instance.context,
      'history': instance.history,
      'diagnostics': instance.diagnostics,
    };
