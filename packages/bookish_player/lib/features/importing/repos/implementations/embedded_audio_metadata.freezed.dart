// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'embedded_audio_metadata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EmbeddedArtwork {

 Uint8List get bytes; String get mimeType;
/// Create a copy of EmbeddedArtwork
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmbeddedArtworkCopyWith<EmbeddedArtwork> get copyWith => _$EmbeddedArtworkCopyWithImpl<EmbeddedArtwork>(this as EmbeddedArtwork, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmbeddedArtwork&&const DeepCollectionEquality().equals(other.bytes, bytes)&&(identical(other.mimeType, mimeType) || other.mimeType == mimeType));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(bytes),mimeType);

@override
String toString() {
  return 'EmbeddedArtwork(bytes: $bytes, mimeType: $mimeType)';
}


}

/// @nodoc
abstract mixin class $EmbeddedArtworkCopyWith<$Res>  {
  factory $EmbeddedArtworkCopyWith(EmbeddedArtwork value, $Res Function(EmbeddedArtwork) _then) = _$EmbeddedArtworkCopyWithImpl;
@useResult
$Res call({
 Uint8List bytes, String mimeType
});




}
/// @nodoc
class _$EmbeddedArtworkCopyWithImpl<$Res>
    implements $EmbeddedArtworkCopyWith<$Res> {
  _$EmbeddedArtworkCopyWithImpl(this._self, this._then);

  final EmbeddedArtwork _self;
  final $Res Function(EmbeddedArtwork) _then;

/// Create a copy of EmbeddedArtwork
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? bytes = null,Object? mimeType = null,}) {
  return _then(_self.copyWith(
bytes: null == bytes ? _self.bytes : bytes // ignore: cast_nullable_to_non_nullable
as Uint8List,mimeType: null == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [EmbeddedArtwork].
extension EmbeddedArtworkPatterns on EmbeddedArtwork {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EmbeddedArtwork value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EmbeddedArtwork() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EmbeddedArtwork value)  $default,){
final _that = this;
switch (_that) {
case _EmbeddedArtwork():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EmbeddedArtwork value)?  $default,){
final _that = this;
switch (_that) {
case _EmbeddedArtwork() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Uint8List bytes,  String mimeType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EmbeddedArtwork() when $default != null:
return $default(_that.bytes,_that.mimeType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Uint8List bytes,  String mimeType)  $default,) {final _that = this;
switch (_that) {
case _EmbeddedArtwork():
return $default(_that.bytes,_that.mimeType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Uint8List bytes,  String mimeType)?  $default,) {final _that = this;
switch (_that) {
case _EmbeddedArtwork() when $default != null:
return $default(_that.bytes,_that.mimeType);case _:
  return null;

}
}

}

/// @nodoc


class _EmbeddedArtwork implements EmbeddedArtwork {
  const _EmbeddedArtwork({required this.bytes, required this.mimeType});
  

@override final  Uint8List bytes;
@override final  String mimeType;

/// Create a copy of EmbeddedArtwork
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmbeddedArtworkCopyWith<_EmbeddedArtwork> get copyWith => __$EmbeddedArtworkCopyWithImpl<_EmbeddedArtwork>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmbeddedArtwork&&const DeepCollectionEquality().equals(other.bytes, bytes)&&(identical(other.mimeType, mimeType) || other.mimeType == mimeType));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(bytes),mimeType);

@override
String toString() {
  return 'EmbeddedArtwork(bytes: $bytes, mimeType: $mimeType)';
}


}

/// @nodoc
abstract mixin class _$EmbeddedArtworkCopyWith<$Res> implements $EmbeddedArtworkCopyWith<$Res> {
  factory _$EmbeddedArtworkCopyWith(_EmbeddedArtwork value, $Res Function(_EmbeddedArtwork) _then) = __$EmbeddedArtworkCopyWithImpl;
@override @useResult
$Res call({
 Uint8List bytes, String mimeType
});




}
/// @nodoc
class __$EmbeddedArtworkCopyWithImpl<$Res>
    implements _$EmbeddedArtworkCopyWith<$Res> {
  __$EmbeddedArtworkCopyWithImpl(this._self, this._then);

  final _EmbeddedArtwork _self;
  final $Res Function(_EmbeddedArtwork) _then;

/// Create a copy of EmbeddedArtwork
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? bytes = null,Object? mimeType = null,}) {
  return _then(_EmbeddedArtwork(
bytes: null == bytes ? _self.bytes : bytes // ignore: cast_nullable_to_non_nullable
as Uint8List,mimeType: null == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
