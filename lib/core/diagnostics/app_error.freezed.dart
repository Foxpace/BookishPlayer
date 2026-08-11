// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_error.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppError {

 String get time; String get operation; String get errorType; String get stack; String get platform; String get platformVersion; String get build; String? get message; Map<String, String> get context; List<String> get history; List<String> get diagnostics;
/// Create a copy of AppError
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppErrorCopyWith<AppError> get copyWith => _$AppErrorCopyWithImpl<AppError>(this as AppError, _$identity);

  /// Serializes this AppError to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppError&&(identical(other.time, time) || other.time == time)&&(identical(other.operation, operation) || other.operation == operation)&&(identical(other.errorType, errorType) || other.errorType == errorType)&&(identical(other.stack, stack) || other.stack == stack)&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.platformVersion, platformVersion) || other.platformVersion == platformVersion)&&(identical(other.build, build) || other.build == build)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other.context, context)&&const DeepCollectionEquality().equals(other.history, history)&&const DeepCollectionEquality().equals(other.diagnostics, diagnostics));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,time,operation,errorType,stack,platform,platformVersion,build,message,const DeepCollectionEquality().hash(context),const DeepCollectionEquality().hash(history),const DeepCollectionEquality().hash(diagnostics));

@override
String toString() {
  return 'AppError(time: $time, operation: $operation, errorType: $errorType, stack: $stack, platform: $platform, platformVersion: $platformVersion, build: $build, message: $message, context: $context, history: $history, diagnostics: $diagnostics)';
}


}

/// @nodoc
abstract mixin class $AppErrorCopyWith<$Res>  {
  factory $AppErrorCopyWith(AppError value, $Res Function(AppError) _then) = _$AppErrorCopyWithImpl;
@useResult
$Res call({
 String time, String operation, String errorType, String stack, String platform, String platformVersion, String build, String? message, Map<String, String> context, List<String> history, List<String> diagnostics
});




}
/// @nodoc
class _$AppErrorCopyWithImpl<$Res>
    implements $AppErrorCopyWith<$Res> {
  _$AppErrorCopyWithImpl(this._self, this._then);

  final AppError _self;
  final $Res Function(AppError) _then;

/// Create a copy of AppError
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? time = null,Object? operation = null,Object? errorType = null,Object? stack = null,Object? platform = null,Object? platformVersion = null,Object? build = null,Object? message = freezed,Object? context = null,Object? history = null,Object? diagnostics = null,}) {
  return _then(_self.copyWith(
time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String,operation: null == operation ? _self.operation : operation // ignore: cast_nullable_to_non_nullable
as String,errorType: null == errorType ? _self.errorType : errorType // ignore: cast_nullable_to_non_nullable
as String,stack: null == stack ? _self.stack : stack // ignore: cast_nullable_to_non_nullable
as String,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String,platformVersion: null == platformVersion ? _self.platformVersion : platformVersion // ignore: cast_nullable_to_non_nullable
as String,build: null == build ? _self.build : build // ignore: cast_nullable_to_non_nullable
as String,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,context: null == context ? _self.context : context // ignore: cast_nullable_to_non_nullable
as Map<String, String>,history: null == history ? _self.history : history // ignore: cast_nullable_to_non_nullable
as List<String>,diagnostics: null == diagnostics ? _self.diagnostics : diagnostics // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [AppError].
extension AppErrorPatterns on AppError {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppError value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppError() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppError value)  $default,){
final _that = this;
switch (_that) {
case _AppError():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppError value)?  $default,){
final _that = this;
switch (_that) {
case _AppError() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String time,  String operation,  String errorType,  String stack,  String platform,  String platformVersion,  String build,  String? message,  Map<String, String> context,  List<String> history,  List<String> diagnostics)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppError() when $default != null:
return $default(_that.time,_that.operation,_that.errorType,_that.stack,_that.platform,_that.platformVersion,_that.build,_that.message,_that.context,_that.history,_that.diagnostics);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String time,  String operation,  String errorType,  String stack,  String platform,  String platformVersion,  String build,  String? message,  Map<String, String> context,  List<String> history,  List<String> diagnostics)  $default,) {final _that = this;
switch (_that) {
case _AppError():
return $default(_that.time,_that.operation,_that.errorType,_that.stack,_that.platform,_that.platformVersion,_that.build,_that.message,_that.context,_that.history,_that.diagnostics);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String time,  String operation,  String errorType,  String stack,  String platform,  String platformVersion,  String build,  String? message,  Map<String, String> context,  List<String> history,  List<String> diagnostics)?  $default,) {final _that = this;
switch (_that) {
case _AppError() when $default != null:
return $default(_that.time,_that.operation,_that.errorType,_that.stack,_that.platform,_that.platformVersion,_that.build,_that.message,_that.context,_that.history,_that.diagnostics);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppError extends AppError {
  const _AppError({required this.time, required this.operation, required this.errorType, required this.stack, required this.platform, required this.platformVersion, required this.build, this.message, final  Map<String, String> context = const <String, String>{}, final  List<String> history = const <String>[], final  List<String> diagnostics = const <String>[]}): _context = context,_history = history,_diagnostics = diagnostics,super._();
  factory _AppError.fromJson(Map<String, dynamic> json) => _$AppErrorFromJson(json);

@override final  String time;
@override final  String operation;
@override final  String errorType;
@override final  String stack;
@override final  String platform;
@override final  String platformVersion;
@override final  String build;
@override final  String? message;
 final  Map<String, String> _context;
@override@JsonKey() Map<String, String> get context {
  if (_context is EqualUnmodifiableMapView) return _context;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_context);
}

 final  List<String> _history;
@override@JsonKey() List<String> get history {
  if (_history is EqualUnmodifiableListView) return _history;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_history);
}

 final  List<String> _diagnostics;
@override@JsonKey() List<String> get diagnostics {
  if (_diagnostics is EqualUnmodifiableListView) return _diagnostics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_diagnostics);
}


/// Create a copy of AppError
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppErrorCopyWith<_AppError> get copyWith => __$AppErrorCopyWithImpl<_AppError>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppErrorToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppError&&(identical(other.time, time) || other.time == time)&&(identical(other.operation, operation) || other.operation == operation)&&(identical(other.errorType, errorType) || other.errorType == errorType)&&(identical(other.stack, stack) || other.stack == stack)&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.platformVersion, platformVersion) || other.platformVersion == platformVersion)&&(identical(other.build, build) || other.build == build)&&(identical(other.message, message) || other.message == message)&&const DeepCollectionEquality().equals(other._context, _context)&&const DeepCollectionEquality().equals(other._history, _history)&&const DeepCollectionEquality().equals(other._diagnostics, _diagnostics));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,time,operation,errorType,stack,platform,platformVersion,build,message,const DeepCollectionEquality().hash(_context),const DeepCollectionEquality().hash(_history),const DeepCollectionEquality().hash(_diagnostics));

@override
String toString() {
  return 'AppError(time: $time, operation: $operation, errorType: $errorType, stack: $stack, platform: $platform, platformVersion: $platformVersion, build: $build, message: $message, context: $context, history: $history, diagnostics: $diagnostics)';
}


}

/// @nodoc
abstract mixin class _$AppErrorCopyWith<$Res> implements $AppErrorCopyWith<$Res> {
  factory _$AppErrorCopyWith(_AppError value, $Res Function(_AppError) _then) = __$AppErrorCopyWithImpl;
@override @useResult
$Res call({
 String time, String operation, String errorType, String stack, String platform, String platformVersion, String build, String? message, Map<String, String> context, List<String> history, List<String> diagnostics
});




}
/// @nodoc
class __$AppErrorCopyWithImpl<$Res>
    implements _$AppErrorCopyWith<$Res> {
  __$AppErrorCopyWithImpl(this._self, this._then);

  final _AppError _self;
  final $Res Function(_AppError) _then;

/// Create a copy of AppError
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? time = null,Object? operation = null,Object? errorType = null,Object? stack = null,Object? platform = null,Object? platformVersion = null,Object? build = null,Object? message = freezed,Object? context = null,Object? history = null,Object? diagnostics = null,}) {
  return _then(_AppError(
time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as String,operation: null == operation ? _self.operation : operation // ignore: cast_nullable_to_non_nullable
as String,errorType: null == errorType ? _self.errorType : errorType // ignore: cast_nullable_to_non_nullable
as String,stack: null == stack ? _self.stack : stack // ignore: cast_nullable_to_non_nullable
as String,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String,platformVersion: null == platformVersion ? _self.platformVersion : platformVersion // ignore: cast_nullable_to_non_nullable
as String,build: null == build ? _self.build : build // ignore: cast_nullable_to_non_nullable
as String,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,context: null == context ? _self._context : context // ignore: cast_nullable_to_non_nullable
as Map<String, String>,history: null == history ? _self._history : history // ignore: cast_nullable_to_non_nullable
as List<String>,diagnostics: null == diagnostics ? _self._diagnostics : diagnostics // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
