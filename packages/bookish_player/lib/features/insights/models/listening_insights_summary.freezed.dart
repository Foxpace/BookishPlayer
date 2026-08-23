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

 Map<InsightsPeriod, ListeningActivityRange> get activityByPeriod; Duration get totalListening; int get completedBooks; int get activeDays; int get streakDays;
/// Create a copy of ListeningInsightsSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListeningInsightsSummaryCopyWith<ListeningInsightsSummary> get copyWith => _$ListeningInsightsSummaryCopyWithImpl<ListeningInsightsSummary>(this as ListeningInsightsSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListeningInsightsSummary&&const DeepCollectionEquality().equals(other.activityByPeriod, activityByPeriod)&&(identical(other.totalListening, totalListening) || other.totalListening == totalListening)&&(identical(other.completedBooks, completedBooks) || other.completedBooks == completedBooks)&&(identical(other.activeDays, activeDays) || other.activeDays == activeDays)&&(identical(other.streakDays, streakDays) || other.streakDays == streakDays));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(activityByPeriod),totalListening,completedBooks,activeDays,streakDays);

@override
String toString() {
  return 'ListeningInsightsSummary(activityByPeriod: $activityByPeriod, totalListening: $totalListening, completedBooks: $completedBooks, activeDays: $activeDays, streakDays: $streakDays)';
}


}

/// @nodoc
abstract mixin class $ListeningInsightsSummaryCopyWith<$Res>  {
  factory $ListeningInsightsSummaryCopyWith(ListeningInsightsSummary value, $Res Function(ListeningInsightsSummary) _then) = _$ListeningInsightsSummaryCopyWithImpl;
@useResult
$Res call({
 Map<InsightsPeriod, ListeningActivityRange> activityByPeriod, Duration totalListening, int completedBooks, int activeDays, int streakDays
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
@pragma('vm:prefer-inline') @override $Res call({Object? activityByPeriod = null,Object? totalListening = null,Object? completedBooks = null,Object? activeDays = null,Object? streakDays = null,}) {
  return _then(_self.copyWith(
activityByPeriod: null == activityByPeriod ? _self.activityByPeriod : activityByPeriod // ignore: cast_nullable_to_non_nullable
as Map<InsightsPeriod, ListeningActivityRange>,totalListening: null == totalListening ? _self.totalListening : totalListening // ignore: cast_nullable_to_non_nullable
as Duration,completedBooks: null == completedBooks ? _self.completedBooks : completedBooks // ignore: cast_nullable_to_non_nullable
as int,activeDays: null == activeDays ? _self.activeDays : activeDays // ignore: cast_nullable_to_non_nullable
as int,streakDays: null == streakDays ? _self.streakDays : streakDays // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Map<InsightsPeriod, ListeningActivityRange> activityByPeriod,  Duration totalListening,  int completedBooks,  int activeDays,  int streakDays)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ListeningInsightsSummary() when $default != null:
return $default(_that.activityByPeriod,_that.totalListening,_that.completedBooks,_that.activeDays,_that.streakDays);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Map<InsightsPeriod, ListeningActivityRange> activityByPeriod,  Duration totalListening,  int completedBooks,  int activeDays,  int streakDays)  $default,) {final _that = this;
switch (_that) {
case _ListeningInsightsSummary():
return $default(_that.activityByPeriod,_that.totalListening,_that.completedBooks,_that.activeDays,_that.streakDays);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Map<InsightsPeriod, ListeningActivityRange> activityByPeriod,  Duration totalListening,  int completedBooks,  int activeDays,  int streakDays)?  $default,) {final _that = this;
switch (_that) {
case _ListeningInsightsSummary() when $default != null:
return $default(_that.activityByPeriod,_that.totalListening,_that.completedBooks,_that.activeDays,_that.streakDays);case _:
  return null;

}
}

}

/// @nodoc


class _ListeningInsightsSummary implements ListeningInsightsSummary {
  const _ListeningInsightsSummary({required final  Map<InsightsPeriod, ListeningActivityRange> activityByPeriod, required this.totalListening, required this.completedBooks, required this.activeDays, required this.streakDays}): _activityByPeriod = activityByPeriod;
  

 final  Map<InsightsPeriod, ListeningActivityRange> _activityByPeriod;
@override Map<InsightsPeriod, ListeningActivityRange> get activityByPeriod {
  if (_activityByPeriod is EqualUnmodifiableMapView) return _activityByPeriod;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_activityByPeriod);
}

@override final  Duration totalListening;
@override final  int completedBooks;
@override final  int activeDays;
@override final  int streakDays;

/// Create a copy of ListeningInsightsSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ListeningInsightsSummaryCopyWith<_ListeningInsightsSummary> get copyWith => __$ListeningInsightsSummaryCopyWithImpl<_ListeningInsightsSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ListeningInsightsSummary&&const DeepCollectionEquality().equals(other._activityByPeriod, _activityByPeriod)&&(identical(other.totalListening, totalListening) || other.totalListening == totalListening)&&(identical(other.completedBooks, completedBooks) || other.completedBooks == completedBooks)&&(identical(other.activeDays, activeDays) || other.activeDays == activeDays)&&(identical(other.streakDays, streakDays) || other.streakDays == streakDays));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_activityByPeriod),totalListening,completedBooks,activeDays,streakDays);

@override
String toString() {
  return 'ListeningInsightsSummary(activityByPeriod: $activityByPeriod, totalListening: $totalListening, completedBooks: $completedBooks, activeDays: $activeDays, streakDays: $streakDays)';
}


}

/// @nodoc
abstract mixin class _$ListeningInsightsSummaryCopyWith<$Res> implements $ListeningInsightsSummaryCopyWith<$Res> {
  factory _$ListeningInsightsSummaryCopyWith(_ListeningInsightsSummary value, $Res Function(_ListeningInsightsSummary) _then) = __$ListeningInsightsSummaryCopyWithImpl;
@override @useResult
$Res call({
 Map<InsightsPeriod, ListeningActivityRange> activityByPeriod, Duration totalListening, int completedBooks, int activeDays, int streakDays
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
@override @pragma('vm:prefer-inline') $Res call({Object? activityByPeriod = null,Object? totalListening = null,Object? completedBooks = null,Object? activeDays = null,Object? streakDays = null,}) {
  return _then(_ListeningInsightsSummary(
activityByPeriod: null == activityByPeriod ? _self._activityByPeriod : activityByPeriod // ignore: cast_nullable_to_non_nullable
as Map<InsightsPeriod, ListeningActivityRange>,totalListening: null == totalListening ? _self.totalListening : totalListening // ignore: cast_nullable_to_non_nullable
as Duration,completedBooks: null == completedBooks ? _self.completedBooks : completedBooks // ignore: cast_nullable_to_non_nullable
as int,activeDays: null == activeDays ? _self.activeDays : activeDays // ignore: cast_nullable_to_non_nullable
as int,streakDays: null == streakDays ? _self.streakDays : streakDays // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
