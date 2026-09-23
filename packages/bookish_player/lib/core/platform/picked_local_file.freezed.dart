// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'picked_local_file.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PickedLocalFile {

 String get name; String? get path; int? get sizeBytes;
/// Create a copy of PickedLocalFile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PickedLocalFileCopyWith<PickedLocalFile> get copyWith => _$PickedLocalFileCopyWithImpl<PickedLocalFile>(this as PickedLocalFile, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PickedLocalFile;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PickedLocalFile&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.path, _this.path) || other.path == _this.path)&&(identical(other.sizeBytes, _this.sizeBytes) || other.sizeBytes == _this.sizeBytes));
}


@override
int get hashCode {
  final _this = this as PickedLocalFile;
  return Object.hash(runtimeType,_this.name,_this.path,_this.sizeBytes);
}

@override
String toString() {
  final _this = this as PickedLocalFile;
  return 'PickedLocalFile(name: ${_this.name}, path: ${_this.path}, sizeBytes: ${_this.sizeBytes})';
}


}

/// @nodoc
abstract mixin class $PickedLocalFileCopyWith<$Res>  {
  factory $PickedLocalFileCopyWith(PickedLocalFile value, $Res Function(PickedLocalFile) _then) = _$PickedLocalFileCopyWithImpl;
@useResult
$Res call({
 String name, String? path, int? sizeBytes
});




}
/// @nodoc
class _$PickedLocalFileCopyWithImpl<$Res>
    implements $PickedLocalFileCopyWith<$Res> {
  _$PickedLocalFileCopyWithImpl(this._self, this._then);

  final PickedLocalFile _self;
  final $Res Function(PickedLocalFile) _then;

/// Create a copy of PickedLocalFile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? path = freezed,Object? sizeBytes = freezed,}) {
  return _then(PickedLocalFile(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,path: freezed == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String?,sizeBytes: freezed == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [PickedLocalFile].
extension PickedLocalFilePatterns on PickedLocalFile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PickedLocalFile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PickedLocalFile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PickedLocalFile value)  $default,){
final _that = this;
switch (_that) {
case _PickedLocalFile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PickedLocalFile value)?  $default,){
final _that = this;
switch (_that) {
case _PickedLocalFile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String? path,  int? sizeBytes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PickedLocalFile() when $default != null:
return $default(_that.name,_that.path,_that.sizeBytes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String? path,  int? sizeBytes)  $default,) {final _that = this;
switch (_that) {
case _PickedLocalFile():
return $default(_that.name,_that.path,_that.sizeBytes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String? path,  int? sizeBytes)?  $default,) {final _that = this;
switch (_that) {
case _PickedLocalFile() when $default != null:
return $default(_that.name,_that.path,_that.sizeBytes);case _:
  return null;

}
}

}

/// @nodoc


class _PickedLocalFile implements PickedLocalFile {
  const _PickedLocalFile({required this.name, required this.path, required this.sizeBytes});
  

@override final  String name;
@override final  String? path;
@override final  int? sizeBytes;

/// Create a copy of PickedLocalFile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PickedLocalFileCopyWith<_PickedLocalFile> get copyWith => __$PickedLocalFileCopyWithImpl<_PickedLocalFile>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PickedLocalFile&&(identical(other.name, name) || other.name == name)&&(identical(other.path, path) || other.path == path)&&(identical(other.sizeBytes, sizeBytes) || other.sizeBytes == sizeBytes));
}


@override
int get hashCode {
    return Object.hash(runtimeType,name,path,sizeBytes);
}

@override
String toString() {
    return 'PickedLocalFile(name: $name, path: $path, sizeBytes: $sizeBytes)';
}


}

/// @nodoc
abstract mixin class _$PickedLocalFileCopyWith<$Res> implements $PickedLocalFileCopyWith<$Res> {
  factory _$PickedLocalFileCopyWith(_PickedLocalFile value, $Res Function(_PickedLocalFile) _then) = __$PickedLocalFileCopyWithImpl;
@override @useResult
$Res call({
 String name, String? path, int? sizeBytes
});




}
/// @nodoc
class __$PickedLocalFileCopyWithImpl<$Res>
    implements _$PickedLocalFileCopyWith<$Res> {
  __$PickedLocalFileCopyWithImpl(this._self, this._then);

  final _PickedLocalFile _self;
  final $Res Function(_PickedLocalFile) _then;

/// Create a copy of PickedLocalFile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? path = freezed,Object? sizeBytes = freezed,}) {
  return _then(_PickedLocalFile(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,path: freezed == path ? _self.path : path // ignore: cast_nullable_to_non_nullable
as String?,sizeBytes: freezed == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
