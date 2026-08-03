// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'listening_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ListeningSession {

 String get id; String get bookId; DateTime get startedAt; DateTime get endedAt; int get listenedMs; int get startPositionMs; int get endPositionMs; double get speed;
/// Create a copy of ListeningSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListeningSessionCopyWith<ListeningSession> get copyWith => _$ListeningSessionCopyWithImpl<ListeningSession>(this as ListeningSession, _$identity);

  /// Serializes this ListeningSession to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListeningSession&&(identical(other.id, id) || other.id == id)&&(identical(other.bookId, bookId) || other.bookId == bookId)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.endedAt, endedAt) || other.endedAt == endedAt)&&(identical(other.listenedMs, listenedMs) || other.listenedMs == listenedMs)&&(identical(other.startPositionMs, startPositionMs) || other.startPositionMs == startPositionMs)&&(identical(other.endPositionMs, endPositionMs) || other.endPositionMs == endPositionMs)&&(identical(other.speed, speed) || other.speed == speed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,bookId,startedAt,endedAt,listenedMs,startPositionMs,endPositionMs,speed);

@override
String toString() {
  return 'ListeningSession(id: $id, bookId: $bookId, startedAt: $startedAt, endedAt: $endedAt, listenedMs: $listenedMs, startPositionMs: $startPositionMs, endPositionMs: $endPositionMs, speed: $speed)';
}


}

/// @nodoc
abstract mixin class $ListeningSessionCopyWith<$Res>  {
  factory $ListeningSessionCopyWith(ListeningSession value, $Res Function(ListeningSession) _then) = _$ListeningSessionCopyWithImpl;
@useResult
$Res call({
 String id, String bookId, DateTime startedAt, DateTime endedAt, int listenedMs, int startPositionMs, int endPositionMs, double speed
});




}
/// @nodoc
class _$ListeningSessionCopyWithImpl<$Res>
    implements $ListeningSessionCopyWith<$Res> {
  _$ListeningSessionCopyWithImpl(this._self, this._then);

  final ListeningSession _self;
  final $Res Function(ListeningSession) _then;

/// Create a copy of ListeningSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? bookId = null,Object? startedAt = null,Object? endedAt = null,Object? listenedMs = null,Object? startPositionMs = null,Object? endPositionMs = null,Object? speed = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,bookId: null == bookId ? _self.bookId : bookId // ignore: cast_nullable_to_non_nullable
as String,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,endedAt: null == endedAt ? _self.endedAt : endedAt // ignore: cast_nullable_to_non_nullable
as DateTime,listenedMs: null == listenedMs ? _self.listenedMs : listenedMs // ignore: cast_nullable_to_non_nullable
as int,startPositionMs: null == startPositionMs ? _self.startPositionMs : startPositionMs // ignore: cast_nullable_to_non_nullable
as int,endPositionMs: null == endPositionMs ? _self.endPositionMs : endPositionMs // ignore: cast_nullable_to_non_nullable
as int,speed: null == speed ? _self.speed : speed // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [ListeningSession].
extension ListeningSessionPatterns on ListeningSession {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ListeningSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ListeningSession() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ListeningSession value)  $default,){
final _that = this;
switch (_that) {
case _ListeningSession():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ListeningSession value)?  $default,){
final _that = this;
switch (_that) {
case _ListeningSession() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String bookId,  DateTime startedAt,  DateTime endedAt,  int listenedMs,  int startPositionMs,  int endPositionMs,  double speed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ListeningSession() when $default != null:
return $default(_that.id,_that.bookId,_that.startedAt,_that.endedAt,_that.listenedMs,_that.startPositionMs,_that.endPositionMs,_that.speed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String bookId,  DateTime startedAt,  DateTime endedAt,  int listenedMs,  int startPositionMs,  int endPositionMs,  double speed)  $default,) {final _that = this;
switch (_that) {
case _ListeningSession():
return $default(_that.id,_that.bookId,_that.startedAt,_that.endedAt,_that.listenedMs,_that.startPositionMs,_that.endPositionMs,_that.speed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String bookId,  DateTime startedAt,  DateTime endedAt,  int listenedMs,  int startPositionMs,  int endPositionMs,  double speed)?  $default,) {final _that = this;
switch (_that) {
case _ListeningSession() when $default != null:
return $default(_that.id,_that.bookId,_that.startedAt,_that.endedAt,_that.listenedMs,_that.startPositionMs,_that.endPositionMs,_that.speed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ListeningSession implements ListeningSession {
  const _ListeningSession({required this.id, required this.bookId, required this.startedAt, required this.endedAt, required this.listenedMs, required this.startPositionMs, required this.endPositionMs, required this.speed});
  factory _ListeningSession.fromJson(Map<String, dynamic> json) => _$ListeningSessionFromJson(json);

@override final  String id;
@override final  String bookId;
@override final  DateTime startedAt;
@override final  DateTime endedAt;
@override final  int listenedMs;
@override final  int startPositionMs;
@override final  int endPositionMs;
@override final  double speed;

/// Create a copy of ListeningSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ListeningSessionCopyWith<_ListeningSession> get copyWith => __$ListeningSessionCopyWithImpl<_ListeningSession>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ListeningSessionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ListeningSession&&(identical(other.id, id) || other.id == id)&&(identical(other.bookId, bookId) || other.bookId == bookId)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.endedAt, endedAt) || other.endedAt == endedAt)&&(identical(other.listenedMs, listenedMs) || other.listenedMs == listenedMs)&&(identical(other.startPositionMs, startPositionMs) || other.startPositionMs == startPositionMs)&&(identical(other.endPositionMs, endPositionMs) || other.endPositionMs == endPositionMs)&&(identical(other.speed, speed) || other.speed == speed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,bookId,startedAt,endedAt,listenedMs,startPositionMs,endPositionMs,speed);

@override
String toString() {
  return 'ListeningSession(id: $id, bookId: $bookId, startedAt: $startedAt, endedAt: $endedAt, listenedMs: $listenedMs, startPositionMs: $startPositionMs, endPositionMs: $endPositionMs, speed: $speed)';
}


}

/// @nodoc
abstract mixin class _$ListeningSessionCopyWith<$Res> implements $ListeningSessionCopyWith<$Res> {
  factory _$ListeningSessionCopyWith(_ListeningSession value, $Res Function(_ListeningSession) _then) = __$ListeningSessionCopyWithImpl;
@override @useResult
$Res call({
 String id, String bookId, DateTime startedAt, DateTime endedAt, int listenedMs, int startPositionMs, int endPositionMs, double speed
});




}
/// @nodoc
class __$ListeningSessionCopyWithImpl<$Res>
    implements _$ListeningSessionCopyWith<$Res> {
  __$ListeningSessionCopyWithImpl(this._self, this._then);

  final _ListeningSession _self;
  final $Res Function(_ListeningSession) _then;

/// Create a copy of ListeningSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? bookId = null,Object? startedAt = null,Object? endedAt = null,Object? listenedMs = null,Object? startPositionMs = null,Object? endPositionMs = null,Object? speed = null,}) {
  return _then(_ListeningSession(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,bookId: null == bookId ? _self.bookId : bookId // ignore: cast_nullable_to_non_nullable
as String,startedAt: null == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime,endedAt: null == endedAt ? _self.endedAt : endedAt // ignore: cast_nullable_to_non_nullable
as DateTime,listenedMs: null == listenedMs ? _self.listenedMs : listenedMs // ignore: cast_nullable_to_non_nullable
as int,startPositionMs: null == startPositionMs ? _self.startPositionMs : startPositionMs // ignore: cast_nullable_to_non_nullable
as int,endPositionMs: null == endPositionMs ? _self.endPositionMs : endPositionMs // ignore: cast_nullable_to_non_nullable
as int,speed: null == speed ? _self.speed : speed // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
