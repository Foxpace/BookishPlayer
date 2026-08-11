// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'selected_audio_file.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SelectedAudioFile {

 String get sourcePath; String get displayName; int? get sizeBytes;
/// Create a copy of SelectedAudioFile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SelectedAudioFileCopyWith<SelectedAudioFile> get copyWith => _$SelectedAudioFileCopyWithImpl<SelectedAudioFile>(this as SelectedAudioFile, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SelectedAudioFile&&(identical(other.sourcePath, sourcePath) || other.sourcePath == sourcePath)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.sizeBytes, sizeBytes) || other.sizeBytes == sizeBytes));
}


@override
int get hashCode => Object.hash(runtimeType,sourcePath,displayName,sizeBytes);

@override
String toString() {
  return 'SelectedAudioFile(sourcePath: $sourcePath, displayName: $displayName, sizeBytes: $sizeBytes)';
}


}

/// @nodoc
abstract mixin class $SelectedAudioFileCopyWith<$Res>  {
  factory $SelectedAudioFileCopyWith(SelectedAudioFile value, $Res Function(SelectedAudioFile) _then) = _$SelectedAudioFileCopyWithImpl;
@useResult
$Res call({
 String sourcePath, String displayName, int? sizeBytes
});




}
/// @nodoc
class _$SelectedAudioFileCopyWithImpl<$Res>
    implements $SelectedAudioFileCopyWith<$Res> {
  _$SelectedAudioFileCopyWithImpl(this._self, this._then);

  final SelectedAudioFile _self;
  final $Res Function(SelectedAudioFile) _then;

/// Create a copy of SelectedAudioFile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sourcePath = null,Object? displayName = null,Object? sizeBytes = freezed,}) {
  return _then(_self.copyWith(
sourcePath: null == sourcePath ? _self.sourcePath : sourcePath // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,sizeBytes: freezed == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [SelectedAudioFile].
extension SelectedAudioFilePatterns on SelectedAudioFile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SelectedAudioFile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SelectedAudioFile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SelectedAudioFile value)  $default,){
final _that = this;
switch (_that) {
case _SelectedAudioFile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SelectedAudioFile value)?  $default,){
final _that = this;
switch (_that) {
case _SelectedAudioFile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String sourcePath,  String displayName,  int? sizeBytes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SelectedAudioFile() when $default != null:
return $default(_that.sourcePath,_that.displayName,_that.sizeBytes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String sourcePath,  String displayName,  int? sizeBytes)  $default,) {final _that = this;
switch (_that) {
case _SelectedAudioFile():
return $default(_that.sourcePath,_that.displayName,_that.sizeBytes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String sourcePath,  String displayName,  int? sizeBytes)?  $default,) {final _that = this;
switch (_that) {
case _SelectedAudioFile() when $default != null:
return $default(_that.sourcePath,_that.displayName,_that.sizeBytes);case _:
  return null;

}
}

}

/// @nodoc


class _SelectedAudioFile implements SelectedAudioFile {
  const _SelectedAudioFile({required this.sourcePath, required this.displayName, this.sizeBytes});
  

@override final  String sourcePath;
@override final  String displayName;
@override final  int? sizeBytes;

/// Create a copy of SelectedAudioFile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SelectedAudioFileCopyWith<_SelectedAudioFile> get copyWith => __$SelectedAudioFileCopyWithImpl<_SelectedAudioFile>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SelectedAudioFile&&(identical(other.sourcePath, sourcePath) || other.sourcePath == sourcePath)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.sizeBytes, sizeBytes) || other.sizeBytes == sizeBytes));
}


@override
int get hashCode => Object.hash(runtimeType,sourcePath,displayName,sizeBytes);

@override
String toString() {
  return 'SelectedAudioFile(sourcePath: $sourcePath, displayName: $displayName, sizeBytes: $sizeBytes)';
}


}

/// @nodoc
abstract mixin class _$SelectedAudioFileCopyWith<$Res> implements $SelectedAudioFileCopyWith<$Res> {
  factory _$SelectedAudioFileCopyWith(_SelectedAudioFile value, $Res Function(_SelectedAudioFile) _then) = __$SelectedAudioFileCopyWithImpl;
@override @useResult
$Res call({
 String sourcePath, String displayName, int? sizeBytes
});




}
/// @nodoc
class __$SelectedAudioFileCopyWithImpl<$Res>
    implements _$SelectedAudioFileCopyWith<$Res> {
  __$SelectedAudioFileCopyWithImpl(this._self, this._then);

  final _SelectedAudioFile _self;
  final $Res Function(_SelectedAudioFile) _then;

/// Create a copy of SelectedAudioFile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sourcePath = null,Object? displayName = null,Object? sizeBytes = freezed,}) {
  return _then(_SelectedAudioFile(
sourcePath: null == sourcePath ? _self.sourcePath : sourcePath // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,sizeBytes: freezed == sizeBytes ? _self.sizeBytes : sizeBytes // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
