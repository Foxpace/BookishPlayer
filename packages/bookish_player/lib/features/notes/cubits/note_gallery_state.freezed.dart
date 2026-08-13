// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'note_gallery_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NoteGalleryState {

 NoteGalleryStatus get status; List<BookMetadata> get metadata; List<BookNote> get notes; AppMessage? get message; int get effectRevision;
/// Create a copy of NoteGalleryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NoteGalleryStateCopyWith<NoteGalleryState> get copyWith => _$NoteGalleryStateCopyWithImpl<NoteGalleryState>(this as NoteGalleryState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NoteGalleryState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&const DeepCollectionEquality().equals(other.notes, notes)&&(identical(other.message, message) || other.message == message)&&(identical(other.effectRevision, effectRevision) || other.effectRevision == effectRevision));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(metadata),const DeepCollectionEquality().hash(notes),message,effectRevision);

@override
String toString() {
  return 'NoteGalleryState(status: $status, metadata: $metadata, notes: $notes, message: $message, effectRevision: $effectRevision)';
}


}

/// @nodoc
abstract mixin class $NoteGalleryStateCopyWith<$Res>  {
  factory $NoteGalleryStateCopyWith(NoteGalleryState value, $Res Function(NoteGalleryState) _then) = _$NoteGalleryStateCopyWithImpl;
@useResult
$Res call({
 NoteGalleryStatus status, List<BookMetadata> metadata, List<BookNote> notes, AppMessage? message, int effectRevision
});




}
/// @nodoc
class _$NoteGalleryStateCopyWithImpl<$Res>
    implements $NoteGalleryStateCopyWith<$Res> {
  _$NoteGalleryStateCopyWithImpl(this._self, this._then);

  final NoteGalleryState _self;
  final $Res Function(NoteGalleryState) _then;

/// Create a copy of NoteGalleryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? metadata = null,Object? notes = null,Object? message = freezed,Object? effectRevision = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as NoteGalleryStatus,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as List<BookMetadata>,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as List<BookNote>,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as AppMessage?,effectRevision: null == effectRevision ? _self.effectRevision : effectRevision // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [NoteGalleryState].
extension NoteGalleryStatePatterns on NoteGalleryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NoteGalleryState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NoteGalleryState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NoteGalleryState value)  $default,){
final _that = this;
switch (_that) {
case _NoteGalleryState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NoteGalleryState value)?  $default,){
final _that = this;
switch (_that) {
case _NoteGalleryState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( NoteGalleryStatus status,  List<BookMetadata> metadata,  List<BookNote> notes,  AppMessage? message,  int effectRevision)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NoteGalleryState() when $default != null:
return $default(_that.status,_that.metadata,_that.notes,_that.message,_that.effectRevision);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( NoteGalleryStatus status,  List<BookMetadata> metadata,  List<BookNote> notes,  AppMessage? message,  int effectRevision)  $default,) {final _that = this;
switch (_that) {
case _NoteGalleryState():
return $default(_that.status,_that.metadata,_that.notes,_that.message,_that.effectRevision);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( NoteGalleryStatus status,  List<BookMetadata> metadata,  List<BookNote> notes,  AppMessage? message,  int effectRevision)?  $default,) {final _that = this;
switch (_that) {
case _NoteGalleryState() when $default != null:
return $default(_that.status,_that.metadata,_that.notes,_that.message,_that.effectRevision);case _:
  return null;

}
}

}

/// @nodoc


class _NoteGalleryState implements NoteGalleryState {
  const _NoteGalleryState({this.status = NoteGalleryStatus.loading, final  List<BookMetadata> metadata = const <BookMetadata>[], final  List<BookNote> notes = const <BookNote>[], this.message, this.effectRevision = 0}): _metadata = metadata,_notes = notes;
  

@override@JsonKey() final  NoteGalleryStatus status;
 final  List<BookMetadata> _metadata;
@override@JsonKey() List<BookMetadata> get metadata {
  if (_metadata is EqualUnmodifiableListView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_metadata);
}

 final  List<BookNote> _notes;
@override@JsonKey() List<BookNote> get notes {
  if (_notes is EqualUnmodifiableListView) return _notes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_notes);
}

@override final  AppMessage? message;
@override@JsonKey() final  int effectRevision;

/// Create a copy of NoteGalleryState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NoteGalleryStateCopyWith<_NoteGalleryState> get copyWith => __$NoteGalleryStateCopyWithImpl<_NoteGalleryState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NoteGalleryState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&const DeepCollectionEquality().equals(other._notes, _notes)&&(identical(other.message, message) || other.message == message)&&(identical(other.effectRevision, effectRevision) || other.effectRevision == effectRevision));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_metadata),const DeepCollectionEquality().hash(_notes),message,effectRevision);

@override
String toString() {
  return 'NoteGalleryState(status: $status, metadata: $metadata, notes: $notes, message: $message, effectRevision: $effectRevision)';
}


}

/// @nodoc
abstract mixin class _$NoteGalleryStateCopyWith<$Res> implements $NoteGalleryStateCopyWith<$Res> {
  factory _$NoteGalleryStateCopyWith(_NoteGalleryState value, $Res Function(_NoteGalleryState) _then) = __$NoteGalleryStateCopyWithImpl;
@override @useResult
$Res call({
 NoteGalleryStatus status, List<BookMetadata> metadata, List<BookNote> notes, AppMessage? message, int effectRevision
});




}
/// @nodoc
class __$NoteGalleryStateCopyWithImpl<$Res>
    implements _$NoteGalleryStateCopyWith<$Res> {
  __$NoteGalleryStateCopyWithImpl(this._self, this._then);

  final _NoteGalleryState _self;
  final $Res Function(_NoteGalleryState) _then;

/// Create a copy of NoteGalleryState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? metadata = null,Object? notes = null,Object? message = freezed,Object? effectRevision = null,}) {
  return _then(_NoteGalleryState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as NoteGalleryStatus,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as List<BookMetadata>,notes: null == notes ? _self._notes : notes // ignore: cast_nullable_to_non_nullable
as List<BookNote>,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as AppMessage?,effectRevision: null == effectRevision ? _self.effectRevision : effectRevision // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
