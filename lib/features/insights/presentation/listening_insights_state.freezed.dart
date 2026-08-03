// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'listening_insights_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ListeningInsightsState {

 ListeningInsightsStatus get status; List<Audiobook> get books; List<ListeningSession> get sessions; Duration get totalListening; Duration get lastSevenDays; int get completedBooks; int get activeDays; String? get message;
/// Create a copy of ListeningInsightsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListeningInsightsStateCopyWith<ListeningInsightsState> get copyWith => _$ListeningInsightsStateCopyWithImpl<ListeningInsightsState>(this as ListeningInsightsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListeningInsightsState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.books, books)&&const DeepCollectionEquality().equals(other.sessions, sessions)&&(identical(other.totalListening, totalListening) || other.totalListening == totalListening)&&(identical(other.lastSevenDays, lastSevenDays) || other.lastSevenDays == lastSevenDays)&&(identical(other.completedBooks, completedBooks) || other.completedBooks == completedBooks)&&(identical(other.activeDays, activeDays) || other.activeDays == activeDays)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(books),const DeepCollectionEquality().hash(sessions),totalListening,lastSevenDays,completedBooks,activeDays,message);

@override
String toString() {
  return 'ListeningInsightsState(status: $status, books: $books, sessions: $sessions, totalListening: $totalListening, lastSevenDays: $lastSevenDays, completedBooks: $completedBooks, activeDays: $activeDays, message: $message)';
}


}

/// @nodoc
abstract mixin class $ListeningInsightsStateCopyWith<$Res>  {
  factory $ListeningInsightsStateCopyWith(ListeningInsightsState value, $Res Function(ListeningInsightsState) _then) = _$ListeningInsightsStateCopyWithImpl;
@useResult
$Res call({
 ListeningInsightsStatus status, List<Audiobook> books, List<ListeningSession> sessions, Duration totalListening, Duration lastSevenDays, int completedBooks, int activeDays, String? message
});




}
/// @nodoc
class _$ListeningInsightsStateCopyWithImpl<$Res>
    implements $ListeningInsightsStateCopyWith<$Res> {
  _$ListeningInsightsStateCopyWithImpl(this._self, this._then);

  final ListeningInsightsState _self;
  final $Res Function(ListeningInsightsState) _then;

/// Create a copy of ListeningInsightsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? books = null,Object? sessions = null,Object? totalListening = null,Object? lastSevenDays = null,Object? completedBooks = null,Object? activeDays = null,Object? message = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ListeningInsightsStatus,books: null == books ? _self.books : books // ignore: cast_nullable_to_non_nullable
as List<Audiobook>,sessions: null == sessions ? _self.sessions : sessions // ignore: cast_nullable_to_non_nullable
as List<ListeningSession>,totalListening: null == totalListening ? _self.totalListening : totalListening // ignore: cast_nullable_to_non_nullable
as Duration,lastSevenDays: null == lastSevenDays ? _self.lastSevenDays : lastSevenDays // ignore: cast_nullable_to_non_nullable
as Duration,completedBooks: null == completedBooks ? _self.completedBooks : completedBooks // ignore: cast_nullable_to_non_nullable
as int,activeDays: null == activeDays ? _self.activeDays : activeDays // ignore: cast_nullable_to_non_nullable
as int,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ListeningInsightsState].
extension ListeningInsightsStatePatterns on ListeningInsightsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ListeningInsightsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ListeningInsightsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ListeningInsightsState value)  $default,){
final _that = this;
switch (_that) {
case _ListeningInsightsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ListeningInsightsState value)?  $default,){
final _that = this;
switch (_that) {
case _ListeningInsightsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ListeningInsightsStatus status,  List<Audiobook> books,  List<ListeningSession> sessions,  Duration totalListening,  Duration lastSevenDays,  int completedBooks,  int activeDays,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ListeningInsightsState() when $default != null:
return $default(_that.status,_that.books,_that.sessions,_that.totalListening,_that.lastSevenDays,_that.completedBooks,_that.activeDays,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ListeningInsightsStatus status,  List<Audiobook> books,  List<ListeningSession> sessions,  Duration totalListening,  Duration lastSevenDays,  int completedBooks,  int activeDays,  String? message)  $default,) {final _that = this;
switch (_that) {
case _ListeningInsightsState():
return $default(_that.status,_that.books,_that.sessions,_that.totalListening,_that.lastSevenDays,_that.completedBooks,_that.activeDays,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ListeningInsightsStatus status,  List<Audiobook> books,  List<ListeningSession> sessions,  Duration totalListening,  Duration lastSevenDays,  int completedBooks,  int activeDays,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _ListeningInsightsState() when $default != null:
return $default(_that.status,_that.books,_that.sessions,_that.totalListening,_that.lastSevenDays,_that.completedBooks,_that.activeDays,_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _ListeningInsightsState implements ListeningInsightsState {
  const _ListeningInsightsState({this.status = ListeningInsightsStatus.loading, final  List<Audiobook> books = const <Audiobook>[], final  List<ListeningSession> sessions = const <ListeningSession>[], this.totalListening = Duration.zero, this.lastSevenDays = Duration.zero, this.completedBooks = 0, this.activeDays = 0, this.message}): _books = books,_sessions = sessions;
  

@override@JsonKey() final  ListeningInsightsStatus status;
 final  List<Audiobook> _books;
@override@JsonKey() List<Audiobook> get books {
  if (_books is EqualUnmodifiableListView) return _books;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_books);
}

 final  List<ListeningSession> _sessions;
@override@JsonKey() List<ListeningSession> get sessions {
  if (_sessions is EqualUnmodifiableListView) return _sessions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sessions);
}

@override@JsonKey() final  Duration totalListening;
@override@JsonKey() final  Duration lastSevenDays;
@override@JsonKey() final  int completedBooks;
@override@JsonKey() final  int activeDays;
@override final  String? message;

/// Create a copy of ListeningInsightsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ListeningInsightsStateCopyWith<_ListeningInsightsState> get copyWith => __$ListeningInsightsStateCopyWithImpl<_ListeningInsightsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ListeningInsightsState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._books, _books)&&const DeepCollectionEquality().equals(other._sessions, _sessions)&&(identical(other.totalListening, totalListening) || other.totalListening == totalListening)&&(identical(other.lastSevenDays, lastSevenDays) || other.lastSevenDays == lastSevenDays)&&(identical(other.completedBooks, completedBooks) || other.completedBooks == completedBooks)&&(identical(other.activeDays, activeDays) || other.activeDays == activeDays)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_books),const DeepCollectionEquality().hash(_sessions),totalListening,lastSevenDays,completedBooks,activeDays,message);

@override
String toString() {
  return 'ListeningInsightsState(status: $status, books: $books, sessions: $sessions, totalListening: $totalListening, lastSevenDays: $lastSevenDays, completedBooks: $completedBooks, activeDays: $activeDays, message: $message)';
}


}

/// @nodoc
abstract mixin class _$ListeningInsightsStateCopyWith<$Res> implements $ListeningInsightsStateCopyWith<$Res> {
  factory _$ListeningInsightsStateCopyWith(_ListeningInsightsState value, $Res Function(_ListeningInsightsState) _then) = __$ListeningInsightsStateCopyWithImpl;
@override @useResult
$Res call({
 ListeningInsightsStatus status, List<Audiobook> books, List<ListeningSession> sessions, Duration totalListening, Duration lastSevenDays, int completedBooks, int activeDays, String? message
});




}
/// @nodoc
class __$ListeningInsightsStateCopyWithImpl<$Res>
    implements _$ListeningInsightsStateCopyWith<$Res> {
  __$ListeningInsightsStateCopyWithImpl(this._self, this._then);

  final _ListeningInsightsState _self;
  final $Res Function(_ListeningInsightsState) _then;

/// Create a copy of ListeningInsightsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? books = null,Object? sessions = null,Object? totalListening = null,Object? lastSevenDays = null,Object? completedBooks = null,Object? activeDays = null,Object? message = freezed,}) {
  return _then(_ListeningInsightsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ListeningInsightsStatus,books: null == books ? _self._books : books // ignore: cast_nullable_to_non_nullable
as List<Audiobook>,sessions: null == sessions ? _self._sessions : sessions // ignore: cast_nullable_to_non_nullable
as List<ListeningSession>,totalListening: null == totalListening ? _self.totalListening : totalListening // ignore: cast_nullable_to_non_nullable
as Duration,lastSevenDays: null == lastSevenDays ? _self.lastSevenDays : lastSevenDays // ignore: cast_nullable_to_non_nullable
as Duration,completedBooks: null == completedBooks ? _self.completedBooks : completedBooks // ignore: cast_nullable_to_non_nullable
as int,activeDays: null == activeDays ? _self.activeDays : activeDays // ignore: cast_nullable_to_non_nullable
as int,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
