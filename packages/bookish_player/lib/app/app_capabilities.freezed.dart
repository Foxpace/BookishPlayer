// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_capabilities.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppCapabilities {

 bool get transcriptionEnabled;
/// Create a copy of AppCapabilities
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppCapabilitiesCopyWith<AppCapabilities> get copyWith => _$AppCapabilitiesCopyWithImpl<AppCapabilities>(this as AppCapabilities, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppCapabilities&&(identical(other.transcriptionEnabled, transcriptionEnabled) || other.transcriptionEnabled == transcriptionEnabled));
}


@override
int get hashCode => Object.hash(runtimeType,transcriptionEnabled);

@override
String toString() {
  return 'AppCapabilities(transcriptionEnabled: $transcriptionEnabled)';
}


}

/// @nodoc
abstract mixin class $AppCapabilitiesCopyWith<$Res>  {
  factory $AppCapabilitiesCopyWith(AppCapabilities value, $Res Function(AppCapabilities) _then) = _$AppCapabilitiesCopyWithImpl;
@useResult
$Res call({
 bool transcriptionEnabled
});




}
/// @nodoc
class _$AppCapabilitiesCopyWithImpl<$Res>
    implements $AppCapabilitiesCopyWith<$Res> {
  _$AppCapabilitiesCopyWithImpl(this._self, this._then);

  final AppCapabilities _self;
  final $Res Function(AppCapabilities) _then;

/// Create a copy of AppCapabilities
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? transcriptionEnabled = null,}) {
  return _then(_self.copyWith(
transcriptionEnabled: null == transcriptionEnabled ? _self.transcriptionEnabled : transcriptionEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [AppCapabilities].
extension AppCapabilitiesPatterns on AppCapabilities {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppCapabilities value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppCapabilities() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppCapabilities value)  $default,){
final _that = this;
switch (_that) {
case _AppCapabilities():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppCapabilities value)?  $default,){
final _that = this;
switch (_that) {
case _AppCapabilities() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool transcriptionEnabled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppCapabilities() when $default != null:
return $default(_that.transcriptionEnabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool transcriptionEnabled)  $default,) {final _that = this;
switch (_that) {
case _AppCapabilities():
return $default(_that.transcriptionEnabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool transcriptionEnabled)?  $default,) {final _that = this;
switch (_that) {
case _AppCapabilities() when $default != null:
return $default(_that.transcriptionEnabled);case _:
  return null;

}
}

}

/// @nodoc


class _AppCapabilities implements AppCapabilities {
  const _AppCapabilities({this.transcriptionEnabled = false});
  

@override@JsonKey() final  bool transcriptionEnabled;

/// Create a copy of AppCapabilities
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppCapabilitiesCopyWith<_AppCapabilities> get copyWith => __$AppCapabilitiesCopyWithImpl<_AppCapabilities>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppCapabilities&&(identical(other.transcriptionEnabled, transcriptionEnabled) || other.transcriptionEnabled == transcriptionEnabled));
}


@override
int get hashCode => Object.hash(runtimeType,transcriptionEnabled);

@override
String toString() {
  return 'AppCapabilities(transcriptionEnabled: $transcriptionEnabled)';
}


}

/// @nodoc
abstract mixin class _$AppCapabilitiesCopyWith<$Res> implements $AppCapabilitiesCopyWith<$Res> {
  factory _$AppCapabilitiesCopyWith(_AppCapabilities value, $Res Function(_AppCapabilities) _then) = __$AppCapabilitiesCopyWithImpl;
@override @useResult
$Res call({
 bool transcriptionEnabled
});




}
/// @nodoc
class __$AppCapabilitiesCopyWithImpl<$Res>
    implements _$AppCapabilitiesCopyWith<$Res> {
  __$AppCapabilitiesCopyWithImpl(this._self, this._then);

  final _AppCapabilities _self;
  final $Res Function(_AppCapabilities) _then;

/// Create a copy of AppCapabilities
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? transcriptionEnabled = null,}) {
  return _then(_AppCapabilities(
transcriptionEnabled: null == transcriptionEnabled ? _self.transcriptionEnabled : transcriptionEnabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
