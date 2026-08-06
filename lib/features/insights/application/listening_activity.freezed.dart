// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'listening_activity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ListeningActivityBucket {

 DateTime get startDate; DateTime get endDate; Duration get listening;
/// Create a copy of ListeningActivityBucket
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListeningActivityBucketCopyWith<ListeningActivityBucket> get copyWith => _$ListeningActivityBucketCopyWithImpl<ListeningActivityBucket>(this as ListeningActivityBucket, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListeningActivityBucket&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.listening, listening) || other.listening == listening));
}


@override
int get hashCode => Object.hash(runtimeType,startDate,endDate,listening);

@override
String toString() {
  return 'ListeningActivityBucket(startDate: $startDate, endDate: $endDate, listening: $listening)';
}


}

/// @nodoc
abstract mixin class $ListeningActivityBucketCopyWith<$Res>  {
  factory $ListeningActivityBucketCopyWith(ListeningActivityBucket value, $Res Function(ListeningActivityBucket) _then) = _$ListeningActivityBucketCopyWithImpl;
@useResult
$Res call({
 DateTime startDate, DateTime endDate, Duration listening
});




}
/// @nodoc
class _$ListeningActivityBucketCopyWithImpl<$Res>
    implements $ListeningActivityBucketCopyWith<$Res> {
  _$ListeningActivityBucketCopyWithImpl(this._self, this._then);

  final ListeningActivityBucket _self;
  final $Res Function(ListeningActivityBucket) _then;

/// Create a copy of ListeningActivityBucket
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? startDate = null,Object? endDate = null,Object? listening = null,}) {
  return _then(_self.copyWith(
startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,listening: null == listening ? _self.listening : listening // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}

}


/// Adds pattern-matching-related methods to [ListeningActivityBucket].
extension ListeningActivityBucketPatterns on ListeningActivityBucket {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ListeningActivityBucket value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ListeningActivityBucket() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ListeningActivityBucket value)  $default,){
final _that = this;
switch (_that) {
case _ListeningActivityBucket():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ListeningActivityBucket value)?  $default,){
final _that = this;
switch (_that) {
case _ListeningActivityBucket() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime startDate,  DateTime endDate,  Duration listening)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ListeningActivityBucket() when $default != null:
return $default(_that.startDate,_that.endDate,_that.listening);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime startDate,  DateTime endDate,  Duration listening)  $default,) {final _that = this;
switch (_that) {
case _ListeningActivityBucket():
return $default(_that.startDate,_that.endDate,_that.listening);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime startDate,  DateTime endDate,  Duration listening)?  $default,) {final _that = this;
switch (_that) {
case _ListeningActivityBucket() when $default != null:
return $default(_that.startDate,_that.endDate,_that.listening);case _:
  return null;

}
}

}

/// @nodoc


class _ListeningActivityBucket implements ListeningActivityBucket {
  const _ListeningActivityBucket({required this.startDate, required this.endDate, required this.listening});
  

@override final  DateTime startDate;
@override final  DateTime endDate;
@override final  Duration listening;

/// Create a copy of ListeningActivityBucket
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ListeningActivityBucketCopyWith<_ListeningActivityBucket> get copyWith => __$ListeningActivityBucketCopyWithImpl<_ListeningActivityBucket>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ListeningActivityBucket&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.listening, listening) || other.listening == listening));
}


@override
int get hashCode => Object.hash(runtimeType,startDate,endDate,listening);

@override
String toString() {
  return 'ListeningActivityBucket(startDate: $startDate, endDate: $endDate, listening: $listening)';
}


}

/// @nodoc
abstract mixin class _$ListeningActivityBucketCopyWith<$Res> implements $ListeningActivityBucketCopyWith<$Res> {
  factory _$ListeningActivityBucketCopyWith(_ListeningActivityBucket value, $Res Function(_ListeningActivityBucket) _then) = __$ListeningActivityBucketCopyWithImpl;
@override @useResult
$Res call({
 DateTime startDate, DateTime endDate, Duration listening
});




}
/// @nodoc
class __$ListeningActivityBucketCopyWithImpl<$Res>
    implements _$ListeningActivityBucketCopyWith<$Res> {
  __$ListeningActivityBucketCopyWithImpl(this._self, this._then);

  final _ListeningActivityBucket _self;
  final $Res Function(_ListeningActivityBucket) _then;

/// Create a copy of ListeningActivityBucket
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? startDate = null,Object? endDate = null,Object? listening = null,}) {
  return _then(_ListeningActivityBucket(
startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,listening: null == listening ? _self.listening : listening // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}


}

/// @nodoc
mixin _$ListeningActivityRange {

 Duration get totalListening; List<ListeningActivityBucket> get buckets;
/// Create a copy of ListeningActivityRange
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListeningActivityRangeCopyWith<ListeningActivityRange> get copyWith => _$ListeningActivityRangeCopyWithImpl<ListeningActivityRange>(this as ListeningActivityRange, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListeningActivityRange&&(identical(other.totalListening, totalListening) || other.totalListening == totalListening)&&const DeepCollectionEquality().equals(other.buckets, buckets));
}


@override
int get hashCode => Object.hash(runtimeType,totalListening,const DeepCollectionEquality().hash(buckets));

@override
String toString() {
  return 'ListeningActivityRange(totalListening: $totalListening, buckets: $buckets)';
}


}

/// @nodoc
abstract mixin class $ListeningActivityRangeCopyWith<$Res>  {
  factory $ListeningActivityRangeCopyWith(ListeningActivityRange value, $Res Function(ListeningActivityRange) _then) = _$ListeningActivityRangeCopyWithImpl;
@useResult
$Res call({
 Duration totalListening, List<ListeningActivityBucket> buckets
});




}
/// @nodoc
class _$ListeningActivityRangeCopyWithImpl<$Res>
    implements $ListeningActivityRangeCopyWith<$Res> {
  _$ListeningActivityRangeCopyWithImpl(this._self, this._then);

  final ListeningActivityRange _self;
  final $Res Function(ListeningActivityRange) _then;

/// Create a copy of ListeningActivityRange
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalListening = null,Object? buckets = null,}) {
  return _then(_self.copyWith(
totalListening: null == totalListening ? _self.totalListening : totalListening // ignore: cast_nullable_to_non_nullable
as Duration,buckets: null == buckets ? _self.buckets : buckets // ignore: cast_nullable_to_non_nullable
as List<ListeningActivityBucket>,
  ));
}

}


/// Adds pattern-matching-related methods to [ListeningActivityRange].
extension ListeningActivityRangePatterns on ListeningActivityRange {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ListeningActivityRange value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ListeningActivityRange() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ListeningActivityRange value)  $default,){
final _that = this;
switch (_that) {
case _ListeningActivityRange():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ListeningActivityRange value)?  $default,){
final _that = this;
switch (_that) {
case _ListeningActivityRange() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Duration totalListening,  List<ListeningActivityBucket> buckets)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ListeningActivityRange() when $default != null:
return $default(_that.totalListening,_that.buckets);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Duration totalListening,  List<ListeningActivityBucket> buckets)  $default,) {final _that = this;
switch (_that) {
case _ListeningActivityRange():
return $default(_that.totalListening,_that.buckets);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Duration totalListening,  List<ListeningActivityBucket> buckets)?  $default,) {final _that = this;
switch (_that) {
case _ListeningActivityRange() when $default != null:
return $default(_that.totalListening,_that.buckets);case _:
  return null;

}
}

}

/// @nodoc


class _ListeningActivityRange implements ListeningActivityRange {
  const _ListeningActivityRange({required this.totalListening, required final  List<ListeningActivityBucket> buckets}): _buckets = buckets;
  

@override final  Duration totalListening;
 final  List<ListeningActivityBucket> _buckets;
@override List<ListeningActivityBucket> get buckets {
  if (_buckets is EqualUnmodifiableListView) return _buckets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_buckets);
}


/// Create a copy of ListeningActivityRange
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ListeningActivityRangeCopyWith<_ListeningActivityRange> get copyWith => __$ListeningActivityRangeCopyWithImpl<_ListeningActivityRange>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ListeningActivityRange&&(identical(other.totalListening, totalListening) || other.totalListening == totalListening)&&const DeepCollectionEquality().equals(other._buckets, _buckets));
}


@override
int get hashCode => Object.hash(runtimeType,totalListening,const DeepCollectionEquality().hash(_buckets));

@override
String toString() {
  return 'ListeningActivityRange(totalListening: $totalListening, buckets: $buckets)';
}


}

/// @nodoc
abstract mixin class _$ListeningActivityRangeCopyWith<$Res> implements $ListeningActivityRangeCopyWith<$Res> {
  factory _$ListeningActivityRangeCopyWith(_ListeningActivityRange value, $Res Function(_ListeningActivityRange) _then) = __$ListeningActivityRangeCopyWithImpl;
@override @useResult
$Res call({
 Duration totalListening, List<ListeningActivityBucket> buckets
});




}
/// @nodoc
class __$ListeningActivityRangeCopyWithImpl<$Res>
    implements _$ListeningActivityRangeCopyWith<$Res> {
  __$ListeningActivityRangeCopyWithImpl(this._self, this._then);

  final _ListeningActivityRange _self;
  final $Res Function(_ListeningActivityRange) _then;

/// Create a copy of ListeningActivityRange
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalListening = null,Object? buckets = null,}) {
  return _then(_ListeningActivityRange(
totalListening: null == totalListening ? _self.totalListening : totalListening // ignore: cast_nullable_to_non_nullable
as Duration,buckets: null == buckets ? _self._buckets : buckets // ignore: cast_nullable_to_non_nullable
as List<ListeningActivityBucket>,
  ));
}


}

// dart format on
