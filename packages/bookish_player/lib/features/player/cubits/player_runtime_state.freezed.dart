// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player_runtime_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PlayerRuntimeState {

 DateTime? get pausedAt; DateTime? get listeningStartedAt; Duration? get listeningStartPosition; bool get wasPlaying; DateTime? get lastProgressSavedAt; bool get progressWriteInFlight; PlayerProgressSnapshot? get pendingProgress; bool get suppressingPlaybackEvents;
/// Create a copy of PlayerRuntimeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerRuntimeStateCopyWith<PlayerRuntimeState> get copyWith => _$PlayerRuntimeStateCopyWithImpl<PlayerRuntimeState>(this as PlayerRuntimeState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerRuntimeState&&(identical(other.pausedAt, pausedAt) || other.pausedAt == pausedAt)&&(identical(other.listeningStartedAt, listeningStartedAt) || other.listeningStartedAt == listeningStartedAt)&&(identical(other.listeningStartPosition, listeningStartPosition) || other.listeningStartPosition == listeningStartPosition)&&(identical(other.wasPlaying, wasPlaying) || other.wasPlaying == wasPlaying)&&(identical(other.lastProgressSavedAt, lastProgressSavedAt) || other.lastProgressSavedAt == lastProgressSavedAt)&&(identical(other.progressWriteInFlight, progressWriteInFlight) || other.progressWriteInFlight == progressWriteInFlight)&&(identical(other.pendingProgress, pendingProgress) || other.pendingProgress == pendingProgress)&&(identical(other.suppressingPlaybackEvents, suppressingPlaybackEvents) || other.suppressingPlaybackEvents == suppressingPlaybackEvents));
}


@override
int get hashCode => Object.hash(runtimeType,pausedAt,listeningStartedAt,listeningStartPosition,wasPlaying,lastProgressSavedAt,progressWriteInFlight,pendingProgress,suppressingPlaybackEvents);

@override
String toString() {
  return 'PlayerRuntimeState(pausedAt: $pausedAt, listeningStartedAt: $listeningStartedAt, listeningStartPosition: $listeningStartPosition, wasPlaying: $wasPlaying, lastProgressSavedAt: $lastProgressSavedAt, progressWriteInFlight: $progressWriteInFlight, pendingProgress: $pendingProgress, suppressingPlaybackEvents: $suppressingPlaybackEvents)';
}


}

/// @nodoc
abstract mixin class $PlayerRuntimeStateCopyWith<$Res>  {
  factory $PlayerRuntimeStateCopyWith(PlayerRuntimeState value, $Res Function(PlayerRuntimeState) _then) = _$PlayerRuntimeStateCopyWithImpl;
@useResult
$Res call({
 DateTime? pausedAt, DateTime? listeningStartedAt, Duration? listeningStartPosition, bool wasPlaying, DateTime? lastProgressSavedAt, bool progressWriteInFlight, PlayerProgressSnapshot? pendingProgress, bool suppressingPlaybackEvents
});


$PlayerProgressSnapshotCopyWith<$Res>? get pendingProgress;

}
/// @nodoc
class _$PlayerRuntimeStateCopyWithImpl<$Res>
    implements $PlayerRuntimeStateCopyWith<$Res> {
  _$PlayerRuntimeStateCopyWithImpl(this._self, this._then);

  final PlayerRuntimeState _self;
  final $Res Function(PlayerRuntimeState) _then;

/// Create a copy of PlayerRuntimeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pausedAt = freezed,Object? listeningStartedAt = freezed,Object? listeningStartPosition = freezed,Object? wasPlaying = null,Object? lastProgressSavedAt = freezed,Object? progressWriteInFlight = null,Object? pendingProgress = freezed,Object? suppressingPlaybackEvents = null,}) {
  return _then(_self.copyWith(
pausedAt: freezed == pausedAt ? _self.pausedAt : pausedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,listeningStartedAt: freezed == listeningStartedAt ? _self.listeningStartedAt : listeningStartedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,listeningStartPosition: freezed == listeningStartPosition ? _self.listeningStartPosition : listeningStartPosition // ignore: cast_nullable_to_non_nullable
as Duration?,wasPlaying: null == wasPlaying ? _self.wasPlaying : wasPlaying // ignore: cast_nullable_to_non_nullable
as bool,lastProgressSavedAt: freezed == lastProgressSavedAt ? _self.lastProgressSavedAt : lastProgressSavedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,progressWriteInFlight: null == progressWriteInFlight ? _self.progressWriteInFlight : progressWriteInFlight // ignore: cast_nullable_to_non_nullable
as bool,pendingProgress: freezed == pendingProgress ? _self.pendingProgress : pendingProgress // ignore: cast_nullable_to_non_nullable
as PlayerProgressSnapshot?,suppressingPlaybackEvents: null == suppressingPlaybackEvents ? _self.suppressingPlaybackEvents : suppressingPlaybackEvents // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of PlayerRuntimeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlayerProgressSnapshotCopyWith<$Res>? get pendingProgress {
    if (_self.pendingProgress == null) {
    return null;
  }

  return $PlayerProgressSnapshotCopyWith<$Res>(_self.pendingProgress!, (value) {
    return _then(_self.copyWith(pendingProgress: value));
  });
}
}


/// Adds pattern-matching-related methods to [PlayerRuntimeState].
extension PlayerRuntimeStatePatterns on PlayerRuntimeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlayerRuntimeState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlayerRuntimeState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlayerRuntimeState value)  $default,){
final _that = this;
switch (_that) {
case _PlayerRuntimeState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlayerRuntimeState value)?  $default,){
final _that = this;
switch (_that) {
case _PlayerRuntimeState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime? pausedAt,  DateTime? listeningStartedAt,  Duration? listeningStartPosition,  bool wasPlaying,  DateTime? lastProgressSavedAt,  bool progressWriteInFlight,  PlayerProgressSnapshot? pendingProgress,  bool suppressingPlaybackEvents)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlayerRuntimeState() when $default != null:
return $default(_that.pausedAt,_that.listeningStartedAt,_that.listeningStartPosition,_that.wasPlaying,_that.lastProgressSavedAt,_that.progressWriteInFlight,_that.pendingProgress,_that.suppressingPlaybackEvents);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime? pausedAt,  DateTime? listeningStartedAt,  Duration? listeningStartPosition,  bool wasPlaying,  DateTime? lastProgressSavedAt,  bool progressWriteInFlight,  PlayerProgressSnapshot? pendingProgress,  bool suppressingPlaybackEvents)  $default,) {final _that = this;
switch (_that) {
case _PlayerRuntimeState():
return $default(_that.pausedAt,_that.listeningStartedAt,_that.listeningStartPosition,_that.wasPlaying,_that.lastProgressSavedAt,_that.progressWriteInFlight,_that.pendingProgress,_that.suppressingPlaybackEvents);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime? pausedAt,  DateTime? listeningStartedAt,  Duration? listeningStartPosition,  bool wasPlaying,  DateTime? lastProgressSavedAt,  bool progressWriteInFlight,  PlayerProgressSnapshot? pendingProgress,  bool suppressingPlaybackEvents)?  $default,) {final _that = this;
switch (_that) {
case _PlayerRuntimeState() when $default != null:
return $default(_that.pausedAt,_that.listeningStartedAt,_that.listeningStartPosition,_that.wasPlaying,_that.lastProgressSavedAt,_that.progressWriteInFlight,_that.pendingProgress,_that.suppressingPlaybackEvents);case _:
  return null;

}
}

}

/// @nodoc


class _PlayerRuntimeState extends PlayerRuntimeState {
  const _PlayerRuntimeState({this.pausedAt, this.listeningStartedAt, this.listeningStartPosition, this.wasPlaying = false, this.lastProgressSavedAt, this.progressWriteInFlight = false, this.pendingProgress, this.suppressingPlaybackEvents = false}): super._();
  

@override final  DateTime? pausedAt;
@override final  DateTime? listeningStartedAt;
@override final  Duration? listeningStartPosition;
@override@JsonKey() final  bool wasPlaying;
@override final  DateTime? lastProgressSavedAt;
@override@JsonKey() final  bool progressWriteInFlight;
@override final  PlayerProgressSnapshot? pendingProgress;
@override@JsonKey() final  bool suppressingPlaybackEvents;

/// Create a copy of PlayerRuntimeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlayerRuntimeStateCopyWith<_PlayerRuntimeState> get copyWith => __$PlayerRuntimeStateCopyWithImpl<_PlayerRuntimeState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlayerRuntimeState&&(identical(other.pausedAt, pausedAt) || other.pausedAt == pausedAt)&&(identical(other.listeningStartedAt, listeningStartedAt) || other.listeningStartedAt == listeningStartedAt)&&(identical(other.listeningStartPosition, listeningStartPosition) || other.listeningStartPosition == listeningStartPosition)&&(identical(other.wasPlaying, wasPlaying) || other.wasPlaying == wasPlaying)&&(identical(other.lastProgressSavedAt, lastProgressSavedAt) || other.lastProgressSavedAt == lastProgressSavedAt)&&(identical(other.progressWriteInFlight, progressWriteInFlight) || other.progressWriteInFlight == progressWriteInFlight)&&(identical(other.pendingProgress, pendingProgress) || other.pendingProgress == pendingProgress)&&(identical(other.suppressingPlaybackEvents, suppressingPlaybackEvents) || other.suppressingPlaybackEvents == suppressingPlaybackEvents));
}


@override
int get hashCode => Object.hash(runtimeType,pausedAt,listeningStartedAt,listeningStartPosition,wasPlaying,lastProgressSavedAt,progressWriteInFlight,pendingProgress,suppressingPlaybackEvents);

@override
String toString() {
  return 'PlayerRuntimeState(pausedAt: $pausedAt, listeningStartedAt: $listeningStartedAt, listeningStartPosition: $listeningStartPosition, wasPlaying: $wasPlaying, lastProgressSavedAt: $lastProgressSavedAt, progressWriteInFlight: $progressWriteInFlight, pendingProgress: $pendingProgress, suppressingPlaybackEvents: $suppressingPlaybackEvents)';
}


}

/// @nodoc
abstract mixin class _$PlayerRuntimeStateCopyWith<$Res> implements $PlayerRuntimeStateCopyWith<$Res> {
  factory _$PlayerRuntimeStateCopyWith(_PlayerRuntimeState value, $Res Function(_PlayerRuntimeState) _then) = __$PlayerRuntimeStateCopyWithImpl;
@override @useResult
$Res call({
 DateTime? pausedAt, DateTime? listeningStartedAt, Duration? listeningStartPosition, bool wasPlaying, DateTime? lastProgressSavedAt, bool progressWriteInFlight, PlayerProgressSnapshot? pendingProgress, bool suppressingPlaybackEvents
});


@override $PlayerProgressSnapshotCopyWith<$Res>? get pendingProgress;

}
/// @nodoc
class __$PlayerRuntimeStateCopyWithImpl<$Res>
    implements _$PlayerRuntimeStateCopyWith<$Res> {
  __$PlayerRuntimeStateCopyWithImpl(this._self, this._then);

  final _PlayerRuntimeState _self;
  final $Res Function(_PlayerRuntimeState) _then;

/// Create a copy of PlayerRuntimeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pausedAt = freezed,Object? listeningStartedAt = freezed,Object? listeningStartPosition = freezed,Object? wasPlaying = null,Object? lastProgressSavedAt = freezed,Object? progressWriteInFlight = null,Object? pendingProgress = freezed,Object? suppressingPlaybackEvents = null,}) {
  return _then(_PlayerRuntimeState(
pausedAt: freezed == pausedAt ? _self.pausedAt : pausedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,listeningStartedAt: freezed == listeningStartedAt ? _self.listeningStartedAt : listeningStartedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,listeningStartPosition: freezed == listeningStartPosition ? _self.listeningStartPosition : listeningStartPosition // ignore: cast_nullable_to_non_nullable
as Duration?,wasPlaying: null == wasPlaying ? _self.wasPlaying : wasPlaying // ignore: cast_nullable_to_non_nullable
as bool,lastProgressSavedAt: freezed == lastProgressSavedAt ? _self.lastProgressSavedAt : lastProgressSavedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,progressWriteInFlight: null == progressWriteInFlight ? _self.progressWriteInFlight : progressWriteInFlight // ignore: cast_nullable_to_non_nullable
as bool,pendingProgress: freezed == pendingProgress ? _self.pendingProgress : pendingProgress // ignore: cast_nullable_to_non_nullable
as PlayerProgressSnapshot?,suppressingPlaybackEvents: null == suppressingPlaybackEvents ? _self.suppressingPlaybackEvents : suppressingPlaybackEvents // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of PlayerRuntimeState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlayerProgressSnapshotCopyWith<$Res>? get pendingProgress {
    if (_self.pendingProgress == null) {
    return null;
  }

  return $PlayerProgressSnapshotCopyWith<$Res>(_self.pendingProgress!, (value) {
    return _then(_self.copyWith(pendingProgress: value));
  });
}
}

/// @nodoc
mixin _$PlayerProgressSnapshot {

 Audiobook get book; Duration get position;
/// Create a copy of PlayerProgressSnapshot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerProgressSnapshotCopyWith<PlayerProgressSnapshot> get copyWith => _$PlayerProgressSnapshotCopyWithImpl<PlayerProgressSnapshot>(this as PlayerProgressSnapshot, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerProgressSnapshot&&(identical(other.book, book) || other.book == book)&&(identical(other.position, position) || other.position == position));
}


@override
int get hashCode => Object.hash(runtimeType,book,position);

@override
String toString() {
  return 'PlayerProgressSnapshot(book: $book, position: $position)';
}


}

/// @nodoc
abstract mixin class $PlayerProgressSnapshotCopyWith<$Res>  {
  factory $PlayerProgressSnapshotCopyWith(PlayerProgressSnapshot value, $Res Function(PlayerProgressSnapshot) _then) = _$PlayerProgressSnapshotCopyWithImpl;
@useResult
$Res call({
 Audiobook book, Duration position
});


$AudiobookCopyWith<$Res> get book;

}
/// @nodoc
class _$PlayerProgressSnapshotCopyWithImpl<$Res>
    implements $PlayerProgressSnapshotCopyWith<$Res> {
  _$PlayerProgressSnapshotCopyWithImpl(this._self, this._then);

  final PlayerProgressSnapshot _self;
  final $Res Function(PlayerProgressSnapshot) _then;

/// Create a copy of PlayerProgressSnapshot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? book = null,Object? position = null,}) {
  return _then(_self.copyWith(
book: null == book ? _self.book : book // ignore: cast_nullable_to_non_nullable
as Audiobook,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}
/// Create a copy of PlayerProgressSnapshot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AudiobookCopyWith<$Res> get book {
  
  return $AudiobookCopyWith<$Res>(_self.book, (value) {
    return _then(_self.copyWith(book: value));
  });
}
}


/// Adds pattern-matching-related methods to [PlayerProgressSnapshot].
extension PlayerProgressSnapshotPatterns on PlayerProgressSnapshot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlayerProgressSnapshot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlayerProgressSnapshot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlayerProgressSnapshot value)  $default,){
final _that = this;
switch (_that) {
case _PlayerProgressSnapshot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlayerProgressSnapshot value)?  $default,){
final _that = this;
switch (_that) {
case _PlayerProgressSnapshot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Audiobook book,  Duration position)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlayerProgressSnapshot() when $default != null:
return $default(_that.book,_that.position);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Audiobook book,  Duration position)  $default,) {final _that = this;
switch (_that) {
case _PlayerProgressSnapshot():
return $default(_that.book,_that.position);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Audiobook book,  Duration position)?  $default,) {final _that = this;
switch (_that) {
case _PlayerProgressSnapshot() when $default != null:
return $default(_that.book,_that.position);case _:
  return null;

}
}

}

/// @nodoc


class _PlayerProgressSnapshot implements PlayerProgressSnapshot {
  const _PlayerProgressSnapshot({required this.book, required this.position});
  

@override final  Audiobook book;
@override final  Duration position;

/// Create a copy of PlayerProgressSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlayerProgressSnapshotCopyWith<_PlayerProgressSnapshot> get copyWith => __$PlayerProgressSnapshotCopyWithImpl<_PlayerProgressSnapshot>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlayerProgressSnapshot&&(identical(other.book, book) || other.book == book)&&(identical(other.position, position) || other.position == position));
}


@override
int get hashCode => Object.hash(runtimeType,book,position);

@override
String toString() {
  return 'PlayerProgressSnapshot(book: $book, position: $position)';
}


}

/// @nodoc
abstract mixin class _$PlayerProgressSnapshotCopyWith<$Res> implements $PlayerProgressSnapshotCopyWith<$Res> {
  factory _$PlayerProgressSnapshotCopyWith(_PlayerProgressSnapshot value, $Res Function(_PlayerProgressSnapshot) _then) = __$PlayerProgressSnapshotCopyWithImpl;
@override @useResult
$Res call({
 Audiobook book, Duration position
});


@override $AudiobookCopyWith<$Res> get book;

}
/// @nodoc
class __$PlayerProgressSnapshotCopyWithImpl<$Res>
    implements _$PlayerProgressSnapshotCopyWith<$Res> {
  __$PlayerProgressSnapshotCopyWithImpl(this._self, this._then);

  final _PlayerProgressSnapshot _self;
  final $Res Function(_PlayerProgressSnapshot) _then;

/// Create a copy of PlayerProgressSnapshot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? book = null,Object? position = null,}) {
  return _then(_PlayerProgressSnapshot(
book: null == book ? _self.book : book // ignore: cast_nullable_to_non_nullable
as Audiobook,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}

/// Create a copy of PlayerProgressSnapshot
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AudiobookCopyWith<$Res> get book {
  
  return $AudiobookCopyWith<$Res>(_self.book, (value) {
    return _then(_self.copyWith(book: value));
  });
}
}

// dart format on
