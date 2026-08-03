// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'listening_insights_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ListeningInsightsSummary {

 List<Audiobook> get books; List<ListeningSession> get sessions; Duration get totalListening; Duration get lastSevenDays; int get completedBooks; int get activeDays;
/// Create a copy of ListeningInsightsSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListeningInsightsSummaryCopyWith<ListeningInsightsSummary> get copyWith => _$ListeningInsightsSummaryCopyWithImpl<ListeningInsightsSummary>(this as ListeningInsightsSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListeningInsightsSummary&&const DeepCollectionEquality().equals(other.books, books)&&const DeepCollectionEquality().equals(other.sessions, sessions)&&(identical(other.totalListening, totalListening) || other.totalListening == totalListening)&&(identical(other.lastSevenDays, lastSevenDays) || other.lastSevenDays == lastSevenDays)&&(identical(other.completedBooks, completedBooks) || other.completedBooks == completedBooks)&&(identical(other.activeDays, activeDays) || other.activeDays == activeDays));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(books),const DeepCollectionEquality().hash(sessions),totalListening,lastSevenDays,completedBooks,activeDays);

@override
String toString() {
  return 'ListeningInsightsSummary(books: $books, sessions: $sessions, totalListening: $totalListening, lastSevenDays: $lastSevenDays, completedBooks: $completedBooks, activeDays: $activeDays)';
}


}

/// @nodoc
abstract mixin class $ListeningInsightsSummaryCopyWith<$Res>  {
  factory $ListeningInsightsSummaryCopyWith(ListeningInsightsSummary value, $Res Function(ListeningInsightsSummary) _then) = _$ListeningInsightsSummaryCopyWithImpl;
@useResult
$Res call({
 List<Audiobook> books, List<ListeningSession> sessions, Duration totalListening, Duration lastSevenDays, int completedBooks, int activeDays
});




}
/// @nodoc
class _$ListeningInsightsSummaryCopyWithImpl<$Res>
    implements $ListeningInsightsSummaryCopyWith<$Res> {
  _$ListeningInsightsSummaryCopyWithImpl(this._self, this._then);

  final ListeningInsightsSummary _self;
  final $Res Function(ListeningInsightsSummary) _then;

/// Create a copy of ListeningInsightsSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? books = null,Object? sessions = null,Object? totalListening = null,Object? lastSevenDays = null,Object? completedBooks = null,Object? activeDays = null,}) {
  return _then(_self.copyWith(
books: null == books ? _self.books : books // ignore: cast_nullable_to_non_nullable
as List<Audiobook>,sessions: null == sessions ? _self.sessions : sessions // ignore: cast_nullable_to_non_nullable
as List<ListeningSession>,totalListening: null == totalListening ? _self.totalListening : totalListening // ignore: cast_nullable_to_non_nullable
as Duration,lastSevenDays: null == lastSevenDays ? _self.lastSevenDays : lastSevenDays // ignore: cast_nullable_to_non_nullable
as Duration,completedBooks: null == completedBooks ? _self.completedBooks : completedBooks // ignore: cast_nullable_to_non_nullable
as int,activeDays: null == activeDays ? _self.activeDays : activeDays // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ListeningInsightsSummary].
extension ListeningInsightsSummaryPatterns on ListeningInsightsSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ListeningInsightsSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ListeningInsightsSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ListeningInsightsSummary value)  $default,){
final _that = this;
switch (_that) {
case _ListeningInsightsSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ListeningInsightsSummary value)?  $default,){
final _that = this;
switch (_that) {
case _ListeningInsightsSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Audiobook> books,  List<ListeningSession> sessions,  Duration totalListening,  Duration lastSevenDays,  int completedBooks,  int activeDays)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ListeningInsightsSummary() when $default != null:
return $default(_that.books,_that.sessions,_that.totalListening,_that.lastSevenDays,_that.completedBooks,_that.activeDays);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Audiobook> books,  List<ListeningSession> sessions,  Duration totalListening,  Duration lastSevenDays,  int completedBooks,  int activeDays)  $default,) {final _that = this;
switch (_that) {
case _ListeningInsightsSummary():
return $default(_that.books,_that.sessions,_that.totalListening,_that.lastSevenDays,_that.completedBooks,_that.activeDays);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Audiobook> books,  List<ListeningSession> sessions,  Duration totalListening,  Duration lastSevenDays,  int completedBooks,  int activeDays)?  $default,) {final _that = this;
switch (_that) {
case _ListeningInsightsSummary() when $default != null:
return $default(_that.books,_that.sessions,_that.totalListening,_that.lastSevenDays,_that.completedBooks,_that.activeDays);case _:
  return null;

}
}

}

/// @nodoc


class _ListeningInsightsSummary implements ListeningInsightsSummary {
  const _ListeningInsightsSummary({required final  List<Audiobook> books, required final  List<ListeningSession> sessions, required this.totalListening, required this.lastSevenDays, required this.completedBooks, required this.activeDays}): _books = books,_sessions = sessions;
  

 final  List<Audiobook> _books;
@override List<Audiobook> get books {
  if (_books is EqualUnmodifiableListView) return _books;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_books);
}

 final  List<ListeningSession> _sessions;
@override List<ListeningSession> get sessions {
  if (_sessions is EqualUnmodifiableListView) return _sessions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sessions);
}

@override final  Duration totalListening;
@override final  Duration lastSevenDays;
@override final  int completedBooks;
@override final  int activeDays;

/// Create a copy of ListeningInsightsSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ListeningInsightsSummaryCopyWith<_ListeningInsightsSummary> get copyWith => __$ListeningInsightsSummaryCopyWithImpl<_ListeningInsightsSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ListeningInsightsSummary&&const DeepCollectionEquality().equals(other._books, _books)&&const DeepCollectionEquality().equals(other._sessions, _sessions)&&(identical(other.totalListening, totalListening) || other.totalListening == totalListening)&&(identical(other.lastSevenDays, lastSevenDays) || other.lastSevenDays == lastSevenDays)&&(identical(other.completedBooks, completedBooks) || other.completedBooks == completedBooks)&&(identical(other.activeDays, activeDays) || other.activeDays == activeDays));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_books),const DeepCollectionEquality().hash(_sessions),totalListening,lastSevenDays,completedBooks,activeDays);

@override
String toString() {
  return 'ListeningInsightsSummary(books: $books, sessions: $sessions, totalListening: $totalListening, lastSevenDays: $lastSevenDays, completedBooks: $completedBooks, activeDays: $activeDays)';
}


}

/// @nodoc
abstract mixin class _$ListeningInsightsSummaryCopyWith<$Res> implements $ListeningInsightsSummaryCopyWith<$Res> {
  factory _$ListeningInsightsSummaryCopyWith(_ListeningInsightsSummary value, $Res Function(_ListeningInsightsSummary) _then) = __$ListeningInsightsSummaryCopyWithImpl;
@override @useResult
$Res call({
 List<Audiobook> books, List<ListeningSession> sessions, Duration totalListening, Duration lastSevenDays, int completedBooks, int activeDays
});




}
/// @nodoc
class __$ListeningInsightsSummaryCopyWithImpl<$Res>
    implements _$ListeningInsightsSummaryCopyWith<$Res> {
  __$ListeningInsightsSummaryCopyWithImpl(this._self, this._then);

  final _ListeningInsightsSummary _self;
  final $Res Function(_ListeningInsightsSummary) _then;

/// Create a copy of ListeningInsightsSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? books = null,Object? sessions = null,Object? totalListening = null,Object? lastSevenDays = null,Object? completedBooks = null,Object? activeDays = null,}) {
  return _then(_ListeningInsightsSummary(
books: null == books ? _self._books : books // ignore: cast_nullable_to_non_nullable
as List<Audiobook>,sessions: null == sessions ? _self._sessions : sessions // ignore: cast_nullable_to_non_nullable
as List<ListeningSession>,totalListening: null == totalListening ? _self.totalListening : totalListening // ignore: cast_nullable_to_non_nullable
as Duration,lastSevenDays: null == lastSevenDays ? _self.lastSevenDays : lastSevenDays // ignore: cast_nullable_to_non_nullable
as Duration,completedBooks: null == completedBooks ? _self.completedBooks : completedBooks // ignore: cast_nullable_to_non_nullable
as int,activeDays: null == activeDays ? _self.activeDays : activeDays // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
