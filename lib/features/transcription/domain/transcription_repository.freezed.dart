// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transcription_repository.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SpeechModel {

 String get slug; bool get isDownloaded; int? get sizeMb;
/// Create a copy of SpeechModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpeechModelCopyWith<SpeechModel> get copyWith => _$SpeechModelCopyWithImpl<SpeechModel>(this as SpeechModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpeechModel&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.isDownloaded, isDownloaded) || other.isDownloaded == isDownloaded)&&(identical(other.sizeMb, sizeMb) || other.sizeMb == sizeMb));
}


@override
int get hashCode => Object.hash(runtimeType,slug,isDownloaded,sizeMb);

@override
String toString() {
  return 'SpeechModel(slug: $slug, isDownloaded: $isDownloaded, sizeMb: $sizeMb)';
}


}

/// @nodoc
abstract mixin class $SpeechModelCopyWith<$Res>  {
  factory $SpeechModelCopyWith(SpeechModel value, $Res Function(SpeechModel) _then) = _$SpeechModelCopyWithImpl;
@useResult
$Res call({
 String slug, bool isDownloaded, int? sizeMb
});




}
/// @nodoc
class _$SpeechModelCopyWithImpl<$Res>
    implements $SpeechModelCopyWith<$Res> {
  _$SpeechModelCopyWithImpl(this._self, this._then);

  final SpeechModel _self;
  final $Res Function(SpeechModel) _then;

/// Create a copy of SpeechModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? slug = null,Object? isDownloaded = null,Object? sizeMb = freezed,}) {
  return _then(_self.copyWith(
slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,isDownloaded: null == isDownloaded ? _self.isDownloaded : isDownloaded // ignore: cast_nullable_to_non_nullable
as bool,sizeMb: freezed == sizeMb ? _self.sizeMb : sizeMb // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [SpeechModel].
extension SpeechModelPatterns on SpeechModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SpeechModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SpeechModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SpeechModel value)  $default,){
final _that = this;
switch (_that) {
case _SpeechModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SpeechModel value)?  $default,){
final _that = this;
switch (_that) {
case _SpeechModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String slug,  bool isDownloaded,  int? sizeMb)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SpeechModel() when $default != null:
return $default(_that.slug,_that.isDownloaded,_that.sizeMb);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String slug,  bool isDownloaded,  int? sizeMb)  $default,) {final _that = this;
switch (_that) {
case _SpeechModel():
return $default(_that.slug,_that.isDownloaded,_that.sizeMb);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String slug,  bool isDownloaded,  int? sizeMb)?  $default,) {final _that = this;
switch (_that) {
case _SpeechModel() when $default != null:
return $default(_that.slug,_that.isDownloaded,_that.sizeMb);case _:
  return null;

}
}

}

/// @nodoc


class _SpeechModel extends SpeechModel {
  const _SpeechModel({required this.slug, required this.isDownloaded, this.sizeMb}): super._();
  

@override final  String slug;
@override final  bool isDownloaded;
@override final  int? sizeMb;

/// Create a copy of SpeechModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SpeechModelCopyWith<_SpeechModel> get copyWith => __$SpeechModelCopyWithImpl<_SpeechModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SpeechModel&&(identical(other.slug, slug) || other.slug == slug)&&(identical(other.isDownloaded, isDownloaded) || other.isDownloaded == isDownloaded)&&(identical(other.sizeMb, sizeMb) || other.sizeMb == sizeMb));
}


@override
int get hashCode => Object.hash(runtimeType,slug,isDownloaded,sizeMb);

@override
String toString() {
  return 'SpeechModel(slug: $slug, isDownloaded: $isDownloaded, sizeMb: $sizeMb)';
}


}

/// @nodoc
abstract mixin class _$SpeechModelCopyWith<$Res> implements $SpeechModelCopyWith<$Res> {
  factory _$SpeechModelCopyWith(_SpeechModel value, $Res Function(_SpeechModel) _then) = __$SpeechModelCopyWithImpl;
@override @useResult
$Res call({
 String slug, bool isDownloaded, int? sizeMb
});




}
/// @nodoc
class __$SpeechModelCopyWithImpl<$Res>
    implements _$SpeechModelCopyWith<$Res> {
  __$SpeechModelCopyWithImpl(this._self, this._then);

  final _SpeechModel _self;
  final $Res Function(_SpeechModel) _then;

/// Create a copy of SpeechModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? slug = null,Object? isDownloaded = null,Object? sizeMb = freezed,}) {
  return _then(_SpeechModel(
slug: null == slug ? _self.slug : slug // ignore: cast_nullable_to_non_nullable
as String,isDownloaded: null == isDownloaded ? _self.isDownloaded : isDownloaded // ignore: cast_nullable_to_non_nullable
as bool,sizeMb: freezed == sizeMb ? _self.sizeMb : sizeMb // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
