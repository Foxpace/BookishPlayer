// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'storage_assistant_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StorageAssistantState {

 bool get loading; List<Audiobook> get books; StorageReport get report; AppMessage? get message; int get effectRevision;
/// Create a copy of StorageAssistantState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StorageAssistantStateCopyWith<StorageAssistantState> get copyWith => _$StorageAssistantStateCopyWithImpl<StorageAssistantState>(this as StorageAssistantState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StorageAssistantState&&(identical(other.loading, loading) || other.loading == loading)&&const DeepCollectionEquality().equals(other.books, books)&&(identical(other.report, report) || other.report == report)&&(identical(other.message, message) || other.message == message)&&(identical(other.effectRevision, effectRevision) || other.effectRevision == effectRevision));
}


@override
int get hashCode => Object.hash(runtimeType,loading,const DeepCollectionEquality().hash(books),report,message,effectRevision);

@override
String toString() {
  return 'StorageAssistantState(loading: $loading, books: $books, report: $report, message: $message, effectRevision: $effectRevision)';
}


}

/// @nodoc
abstract mixin class $StorageAssistantStateCopyWith<$Res>  {
  factory $StorageAssistantStateCopyWith(StorageAssistantState value, $Res Function(StorageAssistantState) _then) = _$StorageAssistantStateCopyWithImpl;
@useResult
$Res call({
 bool loading, List<Audiobook> books, StorageReport report, AppMessage? message, int effectRevision
});


$StorageReportCopyWith<$Res> get report;

}
/// @nodoc
class _$StorageAssistantStateCopyWithImpl<$Res>
    implements $StorageAssistantStateCopyWith<$Res> {
  _$StorageAssistantStateCopyWithImpl(this._self, this._then);

  final StorageAssistantState _self;
  final $Res Function(StorageAssistantState) _then;

/// Create a copy of StorageAssistantState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? loading = null,Object? books = null,Object? report = null,Object? message = freezed,Object? effectRevision = null,}) {
  return _then(_self.copyWith(
loading: null == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as bool,books: null == books ? _self.books : books // ignore: cast_nullable_to_non_nullable
as List<Audiobook>,report: null == report ? _self.report : report // ignore: cast_nullable_to_non_nullable
as StorageReport,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as AppMessage?,effectRevision: null == effectRevision ? _self.effectRevision : effectRevision // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of StorageAssistantState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StorageReportCopyWith<$Res> get report {
  
  return $StorageReportCopyWith<$Res>(_self.report, (value) {
    return _then(_self.copyWith(report: value));
  });
}
}


/// Adds pattern-matching-related methods to [StorageAssistantState].
extension StorageAssistantStatePatterns on StorageAssistantState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StorageAssistantState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StorageAssistantState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StorageAssistantState value)  $default,){
final _that = this;
switch (_that) {
case _StorageAssistantState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StorageAssistantState value)?  $default,){
final _that = this;
switch (_that) {
case _StorageAssistantState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool loading,  List<Audiobook> books,  StorageReport report,  AppMessage? message,  int effectRevision)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StorageAssistantState() when $default != null:
return $default(_that.loading,_that.books,_that.report,_that.message,_that.effectRevision);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool loading,  List<Audiobook> books,  StorageReport report,  AppMessage? message,  int effectRevision)  $default,) {final _that = this;
switch (_that) {
case _StorageAssistantState():
return $default(_that.loading,_that.books,_that.report,_that.message,_that.effectRevision);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool loading,  List<Audiobook> books,  StorageReport report,  AppMessage? message,  int effectRevision)?  $default,) {final _that = this;
switch (_that) {
case _StorageAssistantState() when $default != null:
return $default(_that.loading,_that.books,_that.report,_that.message,_that.effectRevision);case _:
  return null;

}
}

}

/// @nodoc


class _StorageAssistantState implements StorageAssistantState {
  const _StorageAssistantState({this.loading = true, final  List<Audiobook> books = const <Audiobook>[], this.report = const StorageReport(), this.message, this.effectRevision = 0}): _books = books;
  

@override@JsonKey() final  bool loading;
 final  List<Audiobook> _books;
@override@JsonKey() List<Audiobook> get books {
  if (_books is EqualUnmodifiableListView) return _books;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_books);
}

@override@JsonKey() final  StorageReport report;
@override final  AppMessage? message;
@override@JsonKey() final  int effectRevision;

/// Create a copy of StorageAssistantState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StorageAssistantStateCopyWith<_StorageAssistantState> get copyWith => __$StorageAssistantStateCopyWithImpl<_StorageAssistantState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StorageAssistantState&&(identical(other.loading, loading) || other.loading == loading)&&const DeepCollectionEquality().equals(other._books, _books)&&(identical(other.report, report) || other.report == report)&&(identical(other.message, message) || other.message == message)&&(identical(other.effectRevision, effectRevision) || other.effectRevision == effectRevision));
}


@override
int get hashCode => Object.hash(runtimeType,loading,const DeepCollectionEquality().hash(_books),report,message,effectRevision);

@override
String toString() {
  return 'StorageAssistantState(loading: $loading, books: $books, report: $report, message: $message, effectRevision: $effectRevision)';
}


}

/// @nodoc
abstract mixin class _$StorageAssistantStateCopyWith<$Res> implements $StorageAssistantStateCopyWith<$Res> {
  factory _$StorageAssistantStateCopyWith(_StorageAssistantState value, $Res Function(_StorageAssistantState) _then) = __$StorageAssistantStateCopyWithImpl;
@override @useResult
$Res call({
 bool loading, List<Audiobook> books, StorageReport report, AppMessage? message, int effectRevision
});


@override $StorageReportCopyWith<$Res> get report;

}
/// @nodoc
class __$StorageAssistantStateCopyWithImpl<$Res>
    implements _$StorageAssistantStateCopyWith<$Res> {
  __$StorageAssistantStateCopyWithImpl(this._self, this._then);

  final _StorageAssistantState _self;
  final $Res Function(_StorageAssistantState) _then;

/// Create a copy of StorageAssistantState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? loading = null,Object? books = null,Object? report = null,Object? message = freezed,Object? effectRevision = null,}) {
  return _then(_StorageAssistantState(
loading: null == loading ? _self.loading : loading // ignore: cast_nullable_to_non_nullable
as bool,books: null == books ? _self._books : books // ignore: cast_nullable_to_non_nullable
as List<Audiobook>,report: null == report ? _self.report : report // ignore: cast_nullable_to_non_nullable
as StorageReport,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as AppMessage?,effectRevision: null == effectRevision ? _self.effectRevision : effectRevision // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of StorageAssistantState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$StorageReportCopyWith<$Res> get report {
  
  return $StorageReportCopyWith<$Res>(_self.report, (value) {
    return _then(_self.copyWith(report: value));
  });
}
}

// dart format on
