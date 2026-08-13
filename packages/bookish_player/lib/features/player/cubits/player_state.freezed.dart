// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PlayerState {

 PlayerStatus get status; Audiobook? get book; Duration get position; Duration get bufferedPosition; Duration get duration; AudioChapter? get currentChapter; int get currentChapterIndex; int get chapterCount; Duration get chapterStart; Duration get chapterPosition; Duration get chapterBufferedPosition; Duration get chapterDuration; List<PlayerChapter> get chapterTimeline; bool get isPlaying; double get speed; PlaybackPreferences get playback; SleepTimerType? get sleepTimerType; int? get sleepRemainingMinutes; int? get sleepChapterEndMs; List<BookNote> get notes; AppMessage? get message; int get effectRevision;
/// Create a copy of PlayerState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerStateCopyWith<PlayerState> get copyWith => _$PlayerStateCopyWithImpl<PlayerState>(this as PlayerState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerState&&(identical(other.status, status) || other.status == status)&&(identical(other.book, book) || other.book == book)&&(identical(other.position, position) || other.position == position)&&(identical(other.bufferedPosition, bufferedPosition) || other.bufferedPosition == bufferedPosition)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.currentChapter, currentChapter) || other.currentChapter == currentChapter)&&(identical(other.currentChapterIndex, currentChapterIndex) || other.currentChapterIndex == currentChapterIndex)&&(identical(other.chapterCount, chapterCount) || other.chapterCount == chapterCount)&&(identical(other.chapterStart, chapterStart) || other.chapterStart == chapterStart)&&(identical(other.chapterPosition, chapterPosition) || other.chapterPosition == chapterPosition)&&(identical(other.chapterBufferedPosition, chapterBufferedPosition) || other.chapterBufferedPosition == chapterBufferedPosition)&&(identical(other.chapterDuration, chapterDuration) || other.chapterDuration == chapterDuration)&&const DeepCollectionEquality().equals(other.chapterTimeline, chapterTimeline)&&(identical(other.isPlaying, isPlaying) || other.isPlaying == isPlaying)&&(identical(other.speed, speed) || other.speed == speed)&&(identical(other.playback, playback) || other.playback == playback)&&(identical(other.sleepTimerType, sleepTimerType) || other.sleepTimerType == sleepTimerType)&&(identical(other.sleepRemainingMinutes, sleepRemainingMinutes) || other.sleepRemainingMinutes == sleepRemainingMinutes)&&(identical(other.sleepChapterEndMs, sleepChapterEndMs) || other.sleepChapterEndMs == sleepChapterEndMs)&&const DeepCollectionEquality().equals(other.notes, notes)&&(identical(other.message, message) || other.message == message)&&(identical(other.effectRevision, effectRevision) || other.effectRevision == effectRevision));
}


@override
int get hashCode => Object.hashAll([runtimeType,status,book,position,bufferedPosition,duration,currentChapter,currentChapterIndex,chapterCount,chapterStart,chapterPosition,chapterBufferedPosition,chapterDuration,const DeepCollectionEquality().hash(chapterTimeline),isPlaying,speed,playback,sleepTimerType,sleepRemainingMinutes,sleepChapterEndMs,const DeepCollectionEquality().hash(notes),message,effectRevision]);

@override
String toString() {
  return 'PlayerState(status: $status, book: $book, position: $position, bufferedPosition: $bufferedPosition, duration: $duration, currentChapter: $currentChapter, currentChapterIndex: $currentChapterIndex, chapterCount: $chapterCount, chapterStart: $chapterStart, chapterPosition: $chapterPosition, chapterBufferedPosition: $chapterBufferedPosition, chapterDuration: $chapterDuration, chapterTimeline: $chapterTimeline, isPlaying: $isPlaying, speed: $speed, playback: $playback, sleepTimerType: $sleepTimerType, sleepRemainingMinutes: $sleepRemainingMinutes, sleepChapterEndMs: $sleepChapterEndMs, notes: $notes, message: $message, effectRevision: $effectRevision)';
}


}

/// @nodoc
abstract mixin class $PlayerStateCopyWith<$Res>  {
  factory $PlayerStateCopyWith(PlayerState value, $Res Function(PlayerState) _then) = _$PlayerStateCopyWithImpl;
@useResult
$Res call({
 PlayerStatus status, Audiobook? book, Duration position, Duration bufferedPosition, Duration duration, AudioChapter? currentChapter, int currentChapterIndex, int chapterCount, Duration chapterStart, Duration chapterPosition, Duration chapterBufferedPosition, Duration chapterDuration, List<PlayerChapter> chapterTimeline, bool isPlaying, double speed, PlaybackPreferences playback, SleepTimerType? sleepTimerType, int? sleepRemainingMinutes, int? sleepChapterEndMs, List<BookNote> notes, AppMessage? message, int effectRevision
});


$AudiobookCopyWith<$Res>? get book;$AudioChapterCopyWith<$Res>? get currentChapter;$PlaybackPreferencesCopyWith<$Res> get playback;

}
/// @nodoc
class _$PlayerStateCopyWithImpl<$Res>
    implements $PlayerStateCopyWith<$Res> {
  _$PlayerStateCopyWithImpl(this._self, this._then);

  final PlayerState _self;
  final $Res Function(PlayerState) _then;

/// Create a copy of PlayerState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? book = freezed,Object? position = null,Object? bufferedPosition = null,Object? duration = null,Object? currentChapter = freezed,Object? currentChapterIndex = null,Object? chapterCount = null,Object? chapterStart = null,Object? chapterPosition = null,Object? chapterBufferedPosition = null,Object? chapterDuration = null,Object? chapterTimeline = null,Object? isPlaying = null,Object? speed = null,Object? playback = null,Object? sleepTimerType = freezed,Object? sleepRemainingMinutes = freezed,Object? sleepChapterEndMs = freezed,Object? notes = null,Object? message = freezed,Object? effectRevision = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PlayerStatus,book: freezed == book ? _self.book : book // ignore: cast_nullable_to_non_nullable
as Audiobook?,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as Duration,bufferedPosition: null == bufferedPosition ? _self.bufferedPosition : bufferedPosition // ignore: cast_nullable_to_non_nullable
as Duration,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration,currentChapter: freezed == currentChapter ? _self.currentChapter : currentChapter // ignore: cast_nullable_to_non_nullable
as AudioChapter?,currentChapterIndex: null == currentChapterIndex ? _self.currentChapterIndex : currentChapterIndex // ignore: cast_nullable_to_non_nullable
as int,chapterCount: null == chapterCount ? _self.chapterCount : chapterCount // ignore: cast_nullable_to_non_nullable
as int,chapterStart: null == chapterStart ? _self.chapterStart : chapterStart // ignore: cast_nullable_to_non_nullable
as Duration,chapterPosition: null == chapterPosition ? _self.chapterPosition : chapterPosition // ignore: cast_nullable_to_non_nullable
as Duration,chapterBufferedPosition: null == chapterBufferedPosition ? _self.chapterBufferedPosition : chapterBufferedPosition // ignore: cast_nullable_to_non_nullable
as Duration,chapterDuration: null == chapterDuration ? _self.chapterDuration : chapterDuration // ignore: cast_nullable_to_non_nullable
as Duration,chapterTimeline: null == chapterTimeline ? _self.chapterTimeline : chapterTimeline // ignore: cast_nullable_to_non_nullable
as List<PlayerChapter>,isPlaying: null == isPlaying ? _self.isPlaying : isPlaying // ignore: cast_nullable_to_non_nullable
as bool,speed: null == speed ? _self.speed : speed // ignore: cast_nullable_to_non_nullable
as double,playback: null == playback ? _self.playback : playback // ignore: cast_nullable_to_non_nullable
as PlaybackPreferences,sleepTimerType: freezed == sleepTimerType ? _self.sleepTimerType : sleepTimerType // ignore: cast_nullable_to_non_nullable
as SleepTimerType?,sleepRemainingMinutes: freezed == sleepRemainingMinutes ? _self.sleepRemainingMinutes : sleepRemainingMinutes // ignore: cast_nullable_to_non_nullable
as int?,sleepChapterEndMs: freezed == sleepChapterEndMs ? _self.sleepChapterEndMs : sleepChapterEndMs // ignore: cast_nullable_to_non_nullable
as int?,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as List<BookNote>,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as AppMessage?,effectRevision: null == effectRevision ? _self.effectRevision : effectRevision // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of PlayerState
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
}/// Create a copy of PlayerState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AudioChapterCopyWith<$Res>? get currentChapter {
    if (_self.currentChapter == null) {
    return null;
  }

  return $AudioChapterCopyWith<$Res>(_self.currentChapter!, (value) {
    return _then(_self.copyWith(currentChapter: value));
  });
}/// Create a copy of PlayerState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlaybackPreferencesCopyWith<$Res> get playback {
  
  return $PlaybackPreferencesCopyWith<$Res>(_self.playback, (value) {
    return _then(_self.copyWith(playback: value));
  });
}
}


/// Adds pattern-matching-related methods to [PlayerState].
extension PlayerStatePatterns on PlayerState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlayerState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlayerState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlayerState value)  $default,){
final _that = this;
switch (_that) {
case _PlayerState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlayerState value)?  $default,){
final _that = this;
switch (_that) {
case _PlayerState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PlayerStatus status,  Audiobook? book,  Duration position,  Duration bufferedPosition,  Duration duration,  AudioChapter? currentChapter,  int currentChapterIndex,  int chapterCount,  Duration chapterStart,  Duration chapterPosition,  Duration chapterBufferedPosition,  Duration chapterDuration,  List<PlayerChapter> chapterTimeline,  bool isPlaying,  double speed,  PlaybackPreferences playback,  SleepTimerType? sleepTimerType,  int? sleepRemainingMinutes,  int? sleepChapterEndMs,  List<BookNote> notes,  AppMessage? message,  int effectRevision)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlayerState() when $default != null:
return $default(_that.status,_that.book,_that.position,_that.bufferedPosition,_that.duration,_that.currentChapter,_that.currentChapterIndex,_that.chapterCount,_that.chapterStart,_that.chapterPosition,_that.chapterBufferedPosition,_that.chapterDuration,_that.chapterTimeline,_that.isPlaying,_that.speed,_that.playback,_that.sleepTimerType,_that.sleepRemainingMinutes,_that.sleepChapterEndMs,_that.notes,_that.message,_that.effectRevision);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PlayerStatus status,  Audiobook? book,  Duration position,  Duration bufferedPosition,  Duration duration,  AudioChapter? currentChapter,  int currentChapterIndex,  int chapterCount,  Duration chapterStart,  Duration chapterPosition,  Duration chapterBufferedPosition,  Duration chapterDuration,  List<PlayerChapter> chapterTimeline,  bool isPlaying,  double speed,  PlaybackPreferences playback,  SleepTimerType? sleepTimerType,  int? sleepRemainingMinutes,  int? sleepChapterEndMs,  List<BookNote> notes,  AppMessage? message,  int effectRevision)  $default,) {final _that = this;
switch (_that) {
case _PlayerState():
return $default(_that.status,_that.book,_that.position,_that.bufferedPosition,_that.duration,_that.currentChapter,_that.currentChapterIndex,_that.chapterCount,_that.chapterStart,_that.chapterPosition,_that.chapterBufferedPosition,_that.chapterDuration,_that.chapterTimeline,_that.isPlaying,_that.speed,_that.playback,_that.sleepTimerType,_that.sleepRemainingMinutes,_that.sleepChapterEndMs,_that.notes,_that.message,_that.effectRevision);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PlayerStatus status,  Audiobook? book,  Duration position,  Duration bufferedPosition,  Duration duration,  AudioChapter? currentChapter,  int currentChapterIndex,  int chapterCount,  Duration chapterStart,  Duration chapterPosition,  Duration chapterBufferedPosition,  Duration chapterDuration,  List<PlayerChapter> chapterTimeline,  bool isPlaying,  double speed,  PlaybackPreferences playback,  SleepTimerType? sleepTimerType,  int? sleepRemainingMinutes,  int? sleepChapterEndMs,  List<BookNote> notes,  AppMessage? message,  int effectRevision)?  $default,) {final _that = this;
switch (_that) {
case _PlayerState() when $default != null:
return $default(_that.status,_that.book,_that.position,_that.bufferedPosition,_that.duration,_that.currentChapter,_that.currentChapterIndex,_that.chapterCount,_that.chapterStart,_that.chapterPosition,_that.chapterBufferedPosition,_that.chapterDuration,_that.chapterTimeline,_that.isPlaying,_that.speed,_that.playback,_that.sleepTimerType,_that.sleepRemainingMinutes,_that.sleepChapterEndMs,_that.notes,_that.message,_that.effectRevision);case _:
  return null;

}
}

}

/// @nodoc


class _PlayerState implements PlayerState {
  const _PlayerState({this.status = PlayerStatus.idle, this.book, this.position = Duration.zero, this.bufferedPosition = Duration.zero, this.duration = Duration.zero, this.currentChapter, this.currentChapterIndex = 0, this.chapterCount = 0, this.chapterStart = Duration.zero, this.chapterPosition = Duration.zero, this.chapterBufferedPosition = Duration.zero, this.chapterDuration = Duration.zero, final  List<PlayerChapter> chapterTimeline = const <PlayerChapter>[], this.isPlaying = false, this.speed = 1.0, this.playback = const PlaybackPreferences(), this.sleepTimerType, this.sleepRemainingMinutes, this.sleepChapterEndMs, final  List<BookNote> notes = const <BookNote>[], this.message, this.effectRevision = 0}): _chapterTimeline = chapterTimeline,_notes = notes;
  

@override@JsonKey() final  PlayerStatus status;
@override final  Audiobook? book;
@override@JsonKey() final  Duration position;
@override@JsonKey() final  Duration bufferedPosition;
@override@JsonKey() final  Duration duration;
@override final  AudioChapter? currentChapter;
@override@JsonKey() final  int currentChapterIndex;
@override@JsonKey() final  int chapterCount;
@override@JsonKey() final  Duration chapterStart;
@override@JsonKey() final  Duration chapterPosition;
@override@JsonKey() final  Duration chapterBufferedPosition;
@override@JsonKey() final  Duration chapterDuration;
 final  List<PlayerChapter> _chapterTimeline;
@override@JsonKey() List<PlayerChapter> get chapterTimeline {
  if (_chapterTimeline is EqualUnmodifiableListView) return _chapterTimeline;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_chapterTimeline);
}

@override@JsonKey() final  bool isPlaying;
@override@JsonKey() final  double speed;
@override@JsonKey() final  PlaybackPreferences playback;
@override final  SleepTimerType? sleepTimerType;
@override final  int? sleepRemainingMinutes;
@override final  int? sleepChapterEndMs;
 final  List<BookNote> _notes;
@override@JsonKey() List<BookNote> get notes {
  if (_notes is EqualUnmodifiableListView) return _notes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_notes);
}

@override final  AppMessage? message;
@override@JsonKey() final  int effectRevision;

/// Create a copy of PlayerState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlayerStateCopyWith<_PlayerState> get copyWith => __$PlayerStateCopyWithImpl<_PlayerState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlayerState&&(identical(other.status, status) || other.status == status)&&(identical(other.book, book) || other.book == book)&&(identical(other.position, position) || other.position == position)&&(identical(other.bufferedPosition, bufferedPosition) || other.bufferedPosition == bufferedPosition)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.currentChapter, currentChapter) || other.currentChapter == currentChapter)&&(identical(other.currentChapterIndex, currentChapterIndex) || other.currentChapterIndex == currentChapterIndex)&&(identical(other.chapterCount, chapterCount) || other.chapterCount == chapterCount)&&(identical(other.chapterStart, chapterStart) || other.chapterStart == chapterStart)&&(identical(other.chapterPosition, chapterPosition) || other.chapterPosition == chapterPosition)&&(identical(other.chapterBufferedPosition, chapterBufferedPosition) || other.chapterBufferedPosition == chapterBufferedPosition)&&(identical(other.chapterDuration, chapterDuration) || other.chapterDuration == chapterDuration)&&const DeepCollectionEquality().equals(other._chapterTimeline, _chapterTimeline)&&(identical(other.isPlaying, isPlaying) || other.isPlaying == isPlaying)&&(identical(other.speed, speed) || other.speed == speed)&&(identical(other.playback, playback) || other.playback == playback)&&(identical(other.sleepTimerType, sleepTimerType) || other.sleepTimerType == sleepTimerType)&&(identical(other.sleepRemainingMinutes, sleepRemainingMinutes) || other.sleepRemainingMinutes == sleepRemainingMinutes)&&(identical(other.sleepChapterEndMs, sleepChapterEndMs) || other.sleepChapterEndMs == sleepChapterEndMs)&&const DeepCollectionEquality().equals(other._notes, _notes)&&(identical(other.message, message) || other.message == message)&&(identical(other.effectRevision, effectRevision) || other.effectRevision == effectRevision));
}


@override
int get hashCode => Object.hashAll([runtimeType,status,book,position,bufferedPosition,duration,currentChapter,currentChapterIndex,chapterCount,chapterStart,chapterPosition,chapterBufferedPosition,chapterDuration,const DeepCollectionEquality().hash(_chapterTimeline),isPlaying,speed,playback,sleepTimerType,sleepRemainingMinutes,sleepChapterEndMs,const DeepCollectionEquality().hash(_notes),message,effectRevision]);

@override
String toString() {
  return 'PlayerState(status: $status, book: $book, position: $position, bufferedPosition: $bufferedPosition, duration: $duration, currentChapter: $currentChapter, currentChapterIndex: $currentChapterIndex, chapterCount: $chapterCount, chapterStart: $chapterStart, chapterPosition: $chapterPosition, chapterBufferedPosition: $chapterBufferedPosition, chapterDuration: $chapterDuration, chapterTimeline: $chapterTimeline, isPlaying: $isPlaying, speed: $speed, playback: $playback, sleepTimerType: $sleepTimerType, sleepRemainingMinutes: $sleepRemainingMinutes, sleepChapterEndMs: $sleepChapterEndMs, notes: $notes, message: $message, effectRevision: $effectRevision)';
}


}

/// @nodoc
abstract mixin class _$PlayerStateCopyWith<$Res> implements $PlayerStateCopyWith<$Res> {
  factory _$PlayerStateCopyWith(_PlayerState value, $Res Function(_PlayerState) _then) = __$PlayerStateCopyWithImpl;
@override @useResult
$Res call({
 PlayerStatus status, Audiobook? book, Duration position, Duration bufferedPosition, Duration duration, AudioChapter? currentChapter, int currentChapterIndex, int chapterCount, Duration chapterStart, Duration chapterPosition, Duration chapterBufferedPosition, Duration chapterDuration, List<PlayerChapter> chapterTimeline, bool isPlaying, double speed, PlaybackPreferences playback, SleepTimerType? sleepTimerType, int? sleepRemainingMinutes, int? sleepChapterEndMs, List<BookNote> notes, AppMessage? message, int effectRevision
});


@override $AudiobookCopyWith<$Res>? get book;@override $AudioChapterCopyWith<$Res>? get currentChapter;@override $PlaybackPreferencesCopyWith<$Res> get playback;

}
/// @nodoc
class __$PlayerStateCopyWithImpl<$Res>
    implements _$PlayerStateCopyWith<$Res> {
  __$PlayerStateCopyWithImpl(this._self, this._then);

  final _PlayerState _self;
  final $Res Function(_PlayerState) _then;

/// Create a copy of PlayerState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? book = freezed,Object? position = null,Object? bufferedPosition = null,Object? duration = null,Object? currentChapter = freezed,Object? currentChapterIndex = null,Object? chapterCount = null,Object? chapterStart = null,Object? chapterPosition = null,Object? chapterBufferedPosition = null,Object? chapterDuration = null,Object? chapterTimeline = null,Object? isPlaying = null,Object? speed = null,Object? playback = null,Object? sleepTimerType = freezed,Object? sleepRemainingMinutes = freezed,Object? sleepChapterEndMs = freezed,Object? notes = null,Object? message = freezed,Object? effectRevision = null,}) {
  return _then(_PlayerState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PlayerStatus,book: freezed == book ? _self.book : book // ignore: cast_nullable_to_non_nullable
as Audiobook?,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as Duration,bufferedPosition: null == bufferedPosition ? _self.bufferedPosition : bufferedPosition // ignore: cast_nullable_to_non_nullable
as Duration,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as Duration,currentChapter: freezed == currentChapter ? _self.currentChapter : currentChapter // ignore: cast_nullable_to_non_nullable
as AudioChapter?,currentChapterIndex: null == currentChapterIndex ? _self.currentChapterIndex : currentChapterIndex // ignore: cast_nullable_to_non_nullable
as int,chapterCount: null == chapterCount ? _self.chapterCount : chapterCount // ignore: cast_nullable_to_non_nullable
as int,chapterStart: null == chapterStart ? _self.chapterStart : chapterStart // ignore: cast_nullable_to_non_nullable
as Duration,chapterPosition: null == chapterPosition ? _self.chapterPosition : chapterPosition // ignore: cast_nullable_to_non_nullable
as Duration,chapterBufferedPosition: null == chapterBufferedPosition ? _self.chapterBufferedPosition : chapterBufferedPosition // ignore: cast_nullable_to_non_nullable
as Duration,chapterDuration: null == chapterDuration ? _self.chapterDuration : chapterDuration // ignore: cast_nullable_to_non_nullable
as Duration,chapterTimeline: null == chapterTimeline ? _self._chapterTimeline : chapterTimeline // ignore: cast_nullable_to_non_nullable
as List<PlayerChapter>,isPlaying: null == isPlaying ? _self.isPlaying : isPlaying // ignore: cast_nullable_to_non_nullable
as bool,speed: null == speed ? _self.speed : speed // ignore: cast_nullable_to_non_nullable
as double,playback: null == playback ? _self.playback : playback // ignore: cast_nullable_to_non_nullable
as PlaybackPreferences,sleepTimerType: freezed == sleepTimerType ? _self.sleepTimerType : sleepTimerType // ignore: cast_nullable_to_non_nullable
as SleepTimerType?,sleepRemainingMinutes: freezed == sleepRemainingMinutes ? _self.sleepRemainingMinutes : sleepRemainingMinutes // ignore: cast_nullable_to_non_nullable
as int?,sleepChapterEndMs: freezed == sleepChapterEndMs ? _self.sleepChapterEndMs : sleepChapterEndMs // ignore: cast_nullable_to_non_nullable
as int?,notes: null == notes ? _self._notes : notes // ignore: cast_nullable_to_non_nullable
as List<BookNote>,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as AppMessage?,effectRevision: null == effectRevision ? _self.effectRevision : effectRevision // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of PlayerState
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
}/// Create a copy of PlayerState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AudioChapterCopyWith<$Res>? get currentChapter {
    if (_self.currentChapter == null) {
    return null;
  }

  return $AudioChapterCopyWith<$Res>(_self.currentChapter!, (value) {
    return _then(_self.copyWith(currentChapter: value));
  });
}/// Create a copy of PlayerState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlaybackPreferencesCopyWith<$Res> get playback {
  
  return $PlaybackPreferencesCopyWith<$Res>(_self.playback, (value) {
    return _then(_self.copyWith(playback: value));
  });
}
}

// dart format on
