// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'appearance_preferences.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppearancePreferences {

 ThemePreference get theme; bool get useSystemColors; int get primaryColor;
/// Create a copy of AppearancePreferences
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppearancePreferencesCopyWith<AppearancePreferences> get copyWith => _$AppearancePreferencesCopyWithImpl<AppearancePreferences>(this as AppearancePreferences, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppearancePreferences&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.useSystemColors, useSystemColors) || other.useSystemColors == useSystemColors)&&(identical(other.primaryColor, primaryColor) || other.primaryColor == primaryColor));
}


@override
int get hashCode => Object.hash(runtimeType,theme,useSystemColors,primaryColor);

@override
String toString() {
  return 'AppearancePreferences(theme: $theme, useSystemColors: $useSystemColors, primaryColor: $primaryColor)';
}


}

/// @nodoc
abstract mixin class $AppearancePreferencesCopyWith<$Res>  {
  factory $AppearancePreferencesCopyWith(AppearancePreferences value, $Res Function(AppearancePreferences) _then) = _$AppearancePreferencesCopyWithImpl;
@useResult
$Res call({
 ThemePreference theme, bool useSystemColors, int primaryColor
});




}
/// @nodoc
class _$AppearancePreferencesCopyWithImpl<$Res>
    implements $AppearancePreferencesCopyWith<$Res> {
  _$AppearancePreferencesCopyWithImpl(this._self, this._then);

  final AppearancePreferences _self;
  final $Res Function(AppearancePreferences) _then;

/// Create a copy of AppearancePreferences
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? theme = null,Object? useSystemColors = null,Object? primaryColor = null,}) {
  return _then(_self.copyWith(
theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as ThemePreference,useSystemColors: null == useSystemColors ? _self.useSystemColors : useSystemColors // ignore: cast_nullable_to_non_nullable
as bool,primaryColor: null == primaryColor ? _self.primaryColor : primaryColor // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AppearancePreferences].
extension AppearancePreferencesPatterns on AppearancePreferences {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppearancePreferences value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppearancePreferences() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppearancePreferences value)  $default,){
final _that = this;
switch (_that) {
case _AppearancePreferences():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppearancePreferences value)?  $default,){
final _that = this;
switch (_that) {
case _AppearancePreferences() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ThemePreference theme,  bool useSystemColors,  int primaryColor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppearancePreferences() when $default != null:
return $default(_that.theme,_that.useSystemColors,_that.primaryColor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ThemePreference theme,  bool useSystemColors,  int primaryColor)  $default,) {final _that = this;
switch (_that) {
case _AppearancePreferences():
return $default(_that.theme,_that.useSystemColors,_that.primaryColor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ThemePreference theme,  bool useSystemColors,  int primaryColor)?  $default,) {final _that = this;
switch (_that) {
case _AppearancePreferences() when $default != null:
return $default(_that.theme,_that.useSystemColors,_that.primaryColor);case _:
  return null;

}
}

}

/// @nodoc


class _AppearancePreferences implements AppearancePreferences {
  const _AppearancePreferences({this.theme = ThemePreference.system, this.useSystemColors = true, this.primaryColor = defaultBookishSeedColorValue});
  

@override@JsonKey() final  ThemePreference theme;
@override@JsonKey() final  bool useSystemColors;
@override@JsonKey() final  int primaryColor;

/// Create a copy of AppearancePreferences
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppearancePreferencesCopyWith<_AppearancePreferences> get copyWith => __$AppearancePreferencesCopyWithImpl<_AppearancePreferences>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppearancePreferences&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.useSystemColors, useSystemColors) || other.useSystemColors == useSystemColors)&&(identical(other.primaryColor, primaryColor) || other.primaryColor == primaryColor));
}


@override
int get hashCode => Object.hash(runtimeType,theme,useSystemColors,primaryColor);

@override
String toString() {
  return 'AppearancePreferences(theme: $theme, useSystemColors: $useSystemColors, primaryColor: $primaryColor)';
}


}

/// @nodoc
abstract mixin class _$AppearancePreferencesCopyWith<$Res> implements $AppearancePreferencesCopyWith<$Res> {
  factory _$AppearancePreferencesCopyWith(_AppearancePreferences value, $Res Function(_AppearancePreferences) _then) = __$AppearancePreferencesCopyWithImpl;
@override @useResult
$Res call({
 ThemePreference theme, bool useSystemColors, int primaryColor
});




}
/// @nodoc
class __$AppearancePreferencesCopyWithImpl<$Res>
    implements _$AppearancePreferencesCopyWith<$Res> {
  __$AppearancePreferencesCopyWithImpl(this._self, this._then);

  final _AppearancePreferences _self;
  final $Res Function(_AppearancePreferences) _then;

/// Create a copy of AppearancePreferences
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? theme = null,Object? useSystemColors = null,Object? primaryColor = null,}) {
  return _then(_AppearancePreferences(
theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as ThemePreference,useSystemColors: null == useSystemColors ? _self.useSystemColors : useSystemColors // ignore: cast_nullable_to_non_nullable
as bool,primaryColor: null == primaryColor ? _self.primaryColor : primaryColor // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
