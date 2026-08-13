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

 ListeningInsightsStatus get status; Map<InsightsPeriod, ListeningActivityRange> get activityByPeriod; InsightsPeriod get selectedPeriod; Duration get totalListening; int get completedBooks; int get activeDays; AppMessage? get message; int get effectRevision;
/// Create a copy of ListeningInsightsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ListeningInsightsStateCopyWith<ListeningInsightsState> get copyWith => _$ListeningInsightsStateCopyWithImpl<ListeningInsightsState>(this as ListeningInsightsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ListeningInsightsState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.activityByPeriod, activityByPeriod)&&(identical(other.selectedPeriod, selectedPeriod) || other.selectedPeriod == selectedPeriod)&&(identical(other.totalListening, totalListening) || other.totalListening == totalListening)&&(identical(other.completedBooks, completedBooks) || other.completedBooks == completedBooks)&&(identical(other.activeDays, activeDays) || other.activeDays == activeDays)&&(identical(other.message, message) || other.message == message)&&(identical(other.effectRevision, effectRevision) || other.effectRevision == effectRevision));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(activityByPeriod),selectedPeriod,totalListening,completedBooks,activeDays,message,effectRevision);

@override
String toString() {
  return 'ListeningInsightsState(status: $status, activityByPeriod: $activityByPeriod, selectedPeriod: $selectedPeriod, totalListening: $totalListening, completedBooks: $completedBooks, activeDays: $activeDays, message: $message, effectRevision: $effectRevision)';
}


}

/// @nodoc
abstract mixin class $ListeningInsightsStateCopyWith<$Res>  {
  factory $ListeningInsightsStateCopyWith(ListeningInsightsState value, $Res Function(ListeningInsightsState) _then) = _$ListeningInsightsStateCopyWithImpl;
@useResult
$Res call({
 ListeningInsightsStatus status, Map<InsightsPeriod, ListeningActivityRange> activityByPeriod, InsightsPeriod selectedPeriod, Duration totalListening, int completedBooks, int activeDays, AppMessage? message, int effectRevision
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
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? activityByPeriod = null,Object? selectedPeriod = null,Object? totalListening = null,Object? completedBooks = null,Object? activeDays = null,Object? message = freezed,Object? effectRevision = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ListeningInsightsStatus,activityByPeriod: null == activityByPeriod ? _self.activityByPeriod : activityByPeriod // ignore: cast_nullable_to_non_nullable
as Map<InsightsPeriod, ListeningActivityRange>,selectedPeriod: null == selectedPeriod ? _self.selectedPeriod : selectedPeriod // ignore: cast_nullable_to_non_nullable
as InsightsPeriod,totalListening: null == totalListening ? _self.totalListening : totalListening // ignore: cast_nullable_to_non_nullable
as Duration,completedBooks: null == completedBooks ? _self.completedBooks : completedBooks // ignore: cast_nullable_to_non_nullable
as int,activeDays: null == activeDays ? _self.activeDays : activeDays // ignore: cast_nullable_to_non_nullable
as int,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as AppMessage?,effectRevision: null == effectRevision ? _self.effectRevision : effectRevision // ignore: cast_nullable_to_non_nullable
as int,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ListeningInsightsStatus status,  Map<InsightsPeriod, ListeningActivityRange> activityByPeriod,  InsightsPeriod selectedPeriod,  Duration totalListening,  int completedBooks,  int activeDays,  AppMessage? message,  int effectRevision)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ListeningInsightsState() when $default != null:
return $default(_that.status,_that.activityByPeriod,_that.selectedPeriod,_that.totalListening,_that.completedBooks,_that.activeDays,_that.message,_that.effectRevision);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ListeningInsightsStatus status,  Map<InsightsPeriod, ListeningActivityRange> activityByPeriod,  InsightsPeriod selectedPeriod,  Duration totalListening,  int completedBooks,  int activeDays,  AppMessage? message,  int effectRevision)  $default,) {final _that = this;
switch (_that) {
case _ListeningInsightsState():
return $default(_that.status,_that.activityByPeriod,_that.selectedPeriod,_that.totalListening,_that.completedBooks,_that.activeDays,_that.message,_that.effectRevision);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ListeningInsightsStatus status,  Map<InsightsPeriod, ListeningActivityRange> activityByPeriod,  InsightsPeriod selectedPeriod,  Duration totalListening,  int completedBooks,  int activeDays,  AppMessage? message,  int effectRevision)?  $default,) {final _that = this;
switch (_that) {
case _ListeningInsightsState() when $default != null:
return $default(_that.status,_that.activityByPeriod,_that.selectedPeriod,_that.totalListening,_that.completedBooks,_that.activeDays,_that.message,_that.effectRevision);case _:
  return null;

}
}

}

/// @nodoc


class _ListeningInsightsState implements ListeningInsightsState {
  const _ListeningInsightsState({this.status = ListeningInsightsStatus.loading, final  Map<InsightsPeriod, ListeningActivityRange> activityByPeriod = const <InsightsPeriod, ListeningActivityRange>{}, this.selectedPeriod = InsightsPeriod.week, this.totalListening = Duration.zero, this.completedBooks = 0, this.activeDays = 0, this.message, this.effectRevision = 0}): _activityByPeriod = activityByPeriod;
  

@override@JsonKey() final  ListeningInsightsStatus status;
 final  Map<InsightsPeriod, ListeningActivityRange> _activityByPeriod;
@override@JsonKey() Map<InsightsPeriod, ListeningActivityRange> get activityByPeriod {
  if (_activityByPeriod is EqualUnmodifiableMapView) return _activityByPeriod;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_activityByPeriod);
}

@override@JsonKey() final  InsightsPeriod selectedPeriod;
@override@JsonKey() final  Duration totalListening;
@override@JsonKey() final  int completedBooks;
@override@JsonKey() final  int activeDays;
@override final  AppMessage? message;
@override@JsonKey() final  int effectRevision;

/// Create a copy of ListeningInsightsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ListeningInsightsStateCopyWith<_ListeningInsightsState> get copyWith => __$ListeningInsightsStateCopyWithImpl<_ListeningInsightsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ListeningInsightsState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._activityByPeriod, _activityByPeriod)&&(identical(other.selectedPeriod, selectedPeriod) || other.selectedPeriod == selectedPeriod)&&(identical(other.totalListening, totalListening) || other.totalListening == totalListening)&&(identical(other.completedBooks, completedBooks) || other.completedBooks == completedBooks)&&(identical(other.activeDays, activeDays) || other.activeDays == activeDays)&&(identical(other.message, message) || other.message == message)&&(identical(other.effectRevision, effectRevision) || other.effectRevision == effectRevision));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_activityByPeriod),selectedPeriod,totalListening,completedBooks,activeDays,message,effectRevision);

@override
String toString() {
  return 'ListeningInsightsState(status: $status, activityByPeriod: $activityByPeriod, selectedPeriod: $selectedPeriod, totalListening: $totalListening, completedBooks: $completedBooks, activeDays: $activeDays, message: $message, effectRevision: $effectRevision)';
}


}

/// @nodoc
abstract mixin class _$ListeningInsightsStateCopyWith<$Res> implements $ListeningInsightsStateCopyWith<$Res> {
  factory _$ListeningInsightsStateCopyWith(_ListeningInsightsState value, $Res Function(_ListeningInsightsState) _then) = __$ListeningInsightsStateCopyWithImpl;
@override @useResult
$Res call({
 ListeningInsightsStatus status, Map<InsightsPeriod, ListeningActivityRange> activityByPeriod, InsightsPeriod selectedPeriod, Duration totalListening, int completedBooks, int activeDays, AppMessage? message, int effectRevision
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
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? activityByPeriod = null,Object? selectedPeriod = null,Object? totalListening = null,Object? completedBooks = null,Object? activeDays = null,Object? message = freezed,Object? effectRevision = null,}) {
  return _then(_ListeningInsightsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ListeningInsightsStatus,activityByPeriod: null == activityByPeriod ? _self._activityByPeriod : activityByPeriod // ignore: cast_nullable_to_non_nullable
as Map<InsightsPeriod, ListeningActivityRange>,selectedPeriod: null == selectedPeriod ? _self.selectedPeriod : selectedPeriod // ignore: cast_nullable_to_non_nullable
as InsightsPeriod,totalListening: null == totalListening ? _self.totalListening : totalListening // ignore: cast_nullable_to_non_nullable
as Duration,completedBooks: null == completedBooks ? _self.completedBooks : completedBooks // ignore: cast_nullable_to_non_nullable
as int,activeDays: null == activeDays ? _self.activeDays : activeDays // ignore: cast_nullable_to_non_nullable
as int,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as AppMessage?,effectRevision: null == effectRevision ? _self.effectRevision : effectRevision // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
