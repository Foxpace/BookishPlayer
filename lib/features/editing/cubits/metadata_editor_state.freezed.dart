// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'metadata_editor_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MetadataEditorState {

 MetadataEditorStatus get status; String? get bookId; Audiobook? get book; AppMessage? get message; int get effectRevision;
/// Create a copy of MetadataEditorState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MetadataEditorStateCopyWith<MetadataEditorState> get copyWith => _$MetadataEditorStateCopyWithImpl<MetadataEditorState>(this as MetadataEditorState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MetadataEditorState&&(identical(other.status, status) || other.status == status)&&(identical(other.bookId, bookId) || other.bookId == bookId)&&(identical(other.book, book) || other.book == book)&&(identical(other.message, message) || other.message == message)&&(identical(other.effectRevision, effectRevision) || other.effectRevision == effectRevision));
}


@override
int get hashCode => Object.hash(runtimeType,status,bookId,book,message,effectRevision);

@override
String toString() {
  return 'MetadataEditorState(status: $status, bookId: $bookId, book: $book, message: $message, effectRevision: $effectRevision)';
}


}

/// @nodoc
abstract mixin class $MetadataEditorStateCopyWith<$Res>  {
  factory $MetadataEditorStateCopyWith(MetadataEditorState value, $Res Function(MetadataEditorState) _then) = _$MetadataEditorStateCopyWithImpl;
@useResult
$Res call({
 MetadataEditorStatus status, String? bookId, Audiobook? book, AppMessage? message, int effectRevision
});


$AudiobookCopyWith<$Res>? get book;

}
/// @nodoc
class _$MetadataEditorStateCopyWithImpl<$Res>
    implements $MetadataEditorStateCopyWith<$Res> {
  _$MetadataEditorStateCopyWithImpl(this._self, this._then);

  final MetadataEditorState _self;
  final $Res Function(MetadataEditorState) _then;

/// Create a copy of MetadataEditorState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? bookId = freezed,Object? book = freezed,Object? message = freezed,Object? effectRevision = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MetadataEditorStatus,bookId: freezed == bookId ? _self.bookId : bookId // ignore: cast_nullable_to_non_nullable
as String?,book: freezed == book ? _self.book : book // ignore: cast_nullable_to_non_nullable
as Audiobook?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as AppMessage?,effectRevision: null == effectRevision ? _self.effectRevision : effectRevision // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of MetadataEditorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AudiobookCopyWith<$Res>? get book {
    if (_self.book == null) {
    return null;
  }

  return $AudiobookCopyWith<$Res>(_self.book!, (value) {
    return _then(_self.copyWith(book: value));
  });
}
}


/// Adds pattern-matching-related methods to [MetadataEditorState].
extension MetadataEditorStatePatterns on MetadataEditorState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MetadataEditorState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MetadataEditorState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MetadataEditorState value)  $default,){
final _that = this;
switch (_that) {
case _MetadataEditorState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MetadataEditorState value)?  $default,){
final _that = this;
switch (_that) {
case _MetadataEditorState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( MetadataEditorStatus status,  String? bookId,  Audiobook? book,  AppMessage? message,  int effectRevision)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MetadataEditorState() when $default != null:
return $default(_that.status,_that.bookId,_that.book,_that.message,_that.effectRevision);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( MetadataEditorStatus status,  String? bookId,  Audiobook? book,  AppMessage? message,  int effectRevision)  $default,) {final _that = this;
switch (_that) {
case _MetadataEditorState():
return $default(_that.status,_that.bookId,_that.book,_that.message,_that.effectRevision);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( MetadataEditorStatus status,  String? bookId,  Audiobook? book,  AppMessage? message,  int effectRevision)?  $default,) {final _that = this;
switch (_that) {
case _MetadataEditorState() when $default != null:
return $default(_that.status,_that.bookId,_that.book,_that.message,_that.effectRevision);case _:
  return null;

}
}

}

/// @nodoc


class _MetadataEditorState implements MetadataEditorState {
  const _MetadataEditorState({this.status = MetadataEditorStatus.loading, this.bookId, this.book, this.message, this.effectRevision = 0});
  

@override@JsonKey() final  MetadataEditorStatus status;
@override final  String? bookId;
@override final  Audiobook? book;
@override final  AppMessage? message;
@override@JsonKey() final  int effectRevision;

/// Create a copy of MetadataEditorState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MetadataEditorStateCopyWith<_MetadataEditorState> get copyWith => __$MetadataEditorStateCopyWithImpl<_MetadataEditorState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MetadataEditorState&&(identical(other.status, status) || other.status == status)&&(identical(other.bookId, bookId) || other.bookId == bookId)&&(identical(other.book, book) || other.book == book)&&(identical(other.message, message) || other.message == message)&&(identical(other.effectRevision, effectRevision) || other.effectRevision == effectRevision));
}


@override
int get hashCode => Object.hash(runtimeType,status,bookId,book,message,effectRevision);

@override
String toString() {
  return 'MetadataEditorState(status: $status, bookId: $bookId, book: $book, message: $message, effectRevision: $effectRevision)';
}


}

/// @nodoc
abstract mixin class _$MetadataEditorStateCopyWith<$Res> implements $MetadataEditorStateCopyWith<$Res> {
  factory _$MetadataEditorStateCopyWith(_MetadataEditorState value, $Res Function(_MetadataEditorState) _then) = __$MetadataEditorStateCopyWithImpl;
@override @useResult
$Res call({
 MetadataEditorStatus status, String? bookId, Audiobook? book, AppMessage? message, int effectRevision
});


@override $AudiobookCopyWith<$Res>? get book;

}
/// @nodoc
class __$MetadataEditorStateCopyWithImpl<$Res>
    implements _$MetadataEditorStateCopyWith<$Res> {
  __$MetadataEditorStateCopyWithImpl(this._self, this._then);

  final _MetadataEditorState _self;
  final $Res Function(_MetadataEditorState) _then;

/// Create a copy of MetadataEditorState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? bookId = freezed,Object? book = freezed,Object? message = freezed,Object? effectRevision = null,}) {
  return _then(_MetadataEditorState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MetadataEditorStatus,bookId: freezed == bookId ? _self.bookId : bookId // ignore: cast_nullable_to_non_nullable
as String?,book: freezed == book ? _self.book : book // ignore: cast_nullable_to_non_nullable
as Audiobook?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as AppMessage?,effectRevision: null == effectRevision ? _self.effectRevision : effectRevision // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of MetadataEditorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AudiobookCopyWith<$Res>? get book {
    if (_self.book == null) {
    return null;
  }

  return $AudiobookCopyWith<$Res>(_self.book!, (value) {
    return _then(_self.copyWith(book: value));
  });
}
}

// dart format on
