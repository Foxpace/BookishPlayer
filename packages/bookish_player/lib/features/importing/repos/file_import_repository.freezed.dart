// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'file_import_repository.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ImportedAudioFile {

 String get path; String get displayName;
/// Create a copy of ImportedAudioFile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImportedAudioFileCopyWith<ImportedAudioFile> get copyWith => _$ImportedAudioFileCopyWithImpl<ImportedAudioFile>(this as ImportedAudioFile, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImportedAudioFile&&(identical(other.path, path) || other.path == path)&&(identical(other.displayName, displayName) || other.displayName == displayName));
}


@override
int get hashCode => Object.hash(runtimeType,path,displayName);

@override
String toString() {
  return 'ImportedAudioFile(path: $path, displayName: $displayName)';
}


}

/// @nodoc
abstract mixin class $ImportedAudioFileCopyWith<$Res>  {
  factory $ImportedAudioFileCopyWith(ImportedAudioFile value, $Res Function(ImportedAudioFile) _then) = _$ImportedAudioFileCopyWithImpl;
@useResult
$Res call({
 String path, String displayName
});




}
/// @nodoc
class _$ImportedAudioFileCopyWithImpl<$Res>
    implements $ImportedAudioFileCopyWith<$Res> {
  _$ImportedAudioFileCopyWithImpl(this._self, this._then);

  final ImportedAudioFile _self;
  final $Res Function(ImportedAudioFile) _then;

/// Create a copy of ImportedAudioFile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? path = null,Object? displayName = null,}) {
  return _then(_self.copyWith(
path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ImportedAudioFile].
extension ImportedAudioFilePatterns on ImportedAudioFile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ImportedAudioFile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ImportedAudioFile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ImportedAudioFile value)  $default,){
final _that = this;
switch (_that) {
case _ImportedAudioFile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ImportedAudioFile value)?  $default,){
final _that = this;
switch (_that) {
case _ImportedAudioFile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String path,  String displayName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ImportedAudioFile() when $default != null:
return $default(_that.path,_that.displayName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String path,  String displayName)  $default,) {final _that = this;
switch (_that) {
case _ImportedAudioFile():
return $default(_that.path,_that.displayName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String path,  String displayName)?  $default,) {final _that = this;
switch (_that) {
case _ImportedAudioFile() when $default != null:
return $default(_that.path,_that.displayName);case _:
  return null;

}
}

}

/// @nodoc


class _ImportedAudioFile implements ImportedAudioFile {
  const _ImportedAudioFile({required this.path, required this.displayName});
  

@override final  String path;
@override final  String displayName;

/// Create a copy of ImportedAudioFile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ImportedAudioFileCopyWith<_ImportedAudioFile> get copyWith => __$ImportedAudioFileCopyWithImpl<_ImportedAudioFile>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ImportedAudioFile&&(identical(other.path, path) || other.path == path)&&(identical(other.displayName, displayName) || other.displayName == displayName));
}


@override
int get hashCode => Object.hash(runtimeType,path,displayName);

@override
String toString() {
  return 'ImportedAudioFile(path: $path, displayName: $displayName)';
}


}

/// @nodoc
abstract mixin class _$ImportedAudioFileCopyWith<$Res> implements $ImportedAudioFileCopyWith<$Res> {
  factory _$ImportedAudioFileCopyWith(_ImportedAudioFile value, $Res Function(_ImportedAudioFile) _then) = __$ImportedAudioFileCopyWithImpl;
@override @useResult
$Res call({
 String path, String displayName
});




}
/// @nodoc
class __$ImportedAudioFileCopyWithImpl<$Res>
    implements _$ImportedAudioFileCopyWith<$Res> {
  __$ImportedAudioFileCopyWithImpl(this._self, this._then);

  final _ImportedAudioFile _self;
  final $Res Function(_ImportedAudioFile) _then;

/// Create a copy of ImportedAudioFile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? path = null,Object? displayName = null,}) {
  return _then(_ImportedAudioFile(
path: null == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
