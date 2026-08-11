// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player_chapter.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PlayerChapter {

 int get index; String get title; Duration get start; Duration get duration;
/// Create a copy of PlayerChapter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerChapterCopyWith<PlayerChapter> get copyWith => _$PlayerChapterCopyWithImpl<PlayerChapter>(this as PlayerChapter, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerChapter&&(identical(other.index, index) || other.index == index)&&(identical(other.title, title) || other.title == title)&&(identical(other.start, start) || other.start == start)&&(identical(other.duration, duration) || other.duration == duration));
}


@override
int get hashCode => Object.hash(runtimeType,index,title,start,duration);

@override
String toString() {
  return 'PlayerChapter(index: $index, title: $title, start: $start, duration: $duration)';
}


}

/// @nodoc
abstract mixin class $PlayerChapterCopyWith<$Res>  {
  factory $PlayerChapterCopyWith(PlayerChapter value, $Res Function(PlayerChapter) _then) = _$PlayerChapterCopyWithImpl;
@useResult
$Res call({
 int index, String title, Duration start, Duration duration
});




}
/// @nodoc
class _$PlayerChapterCopyWithImpl<$Res>
    implements $PlayerChapterCopyWith<$Res> {
  _$PlayerChapterCopyWithImpl(this._self, this._then);

  final PlayerChapter _self;
  final $Res Function(PlayerChapter) _then;

/// Create a copy of PlayerChapter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? index = null,Object? title = null,Object? start = null,Object? duration = null,}) {
  return _then(_self.copyWith(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as Duration,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}

}


/// Adds pattern-matching-related methods to [PlayerChapter].
extension PlayerChapterPatterns on PlayerChapter {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlayerChapter value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlayerChapter() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlayerChapter value)  $default,){
final _that = this;
switch (_that) {
case _PlayerChapter():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlayerChapter value)?  $default,){
final _that = this;
switch (_that) {
case _PlayerChapter() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int index,  String title,  Duration start,  Duration duration)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlayerChapter() when $default != null:
return $default(_that.index,_that.title,_that.start,_that.duration);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int index,  String title,  Duration start,  Duration duration)  $default,) {final _that = this;
switch (_that) {
case _PlayerChapter():
return $default(_that.index,_that.title,_that.start,_that.duration);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int index,  String title,  Duration start,  Duration duration)?  $default,) {final _that = this;
switch (_that) {
case _PlayerChapter() when $default != null:
return $default(_that.index,_that.title,_that.start,_that.duration);case _:
  return null;

}
}

}

/// @nodoc


class _PlayerChapter implements PlayerChapter {
  const _PlayerChapter({required this.index, required this.title, required this.start, required this.duration});
  

@override final  int index;
@override final  String title;
@override final  Duration start;
@override final  Duration duration;

/// Create a copy of PlayerChapter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlayerChapterCopyWith<_PlayerChapter> get copyWith => __$PlayerChapterCopyWithImpl<_PlayerChapter>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlayerChapter&&(identical(other.index, index) || other.index == index)&&(identical(other.title, title) || other.title == title)&&(identical(other.start, start) || other.start == start)&&(identical(other.duration, duration) || other.duration == duration));
}


@override
int get hashCode => Object.hash(runtimeType,index,title,start,duration);

@override
String toString() {
  return 'PlayerChapter(index: $index, title: $title, start: $start, duration: $duration)';
}


}

/// @nodoc
abstract mixin class _$PlayerChapterCopyWith<$Res> implements $PlayerChapterCopyWith<$Res> {
  factory _$PlayerChapterCopyWith(_PlayerChapter value, $Res Function(_PlayerChapter) _then) = __$PlayerChapterCopyWithImpl;
@override @useResult
$Res call({
 int index, String title, Duration start, Duration duration
});




}
/// @nodoc
class __$PlayerChapterCopyWithImpl<$Res>
    implements _$PlayerChapterCopyWith<$Res> {
  __$PlayerChapterCopyWithImpl(this._self, this._then);

  final _PlayerChapter _self;
  final $Res Function(_PlayerChapter) _then;

/// Create a copy of PlayerChapter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? index = null,Object? title = null,Object? start = null,Object? duration = null,}) {
  return _then(_PlayerChapter(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as Duration,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}


}

// dart format on
