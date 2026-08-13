// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transcription_draft.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TranscriptionDraft {

 Audiobook get book; String get text; Duration get start; Duration get end; Duration get chapterStart; Duration get chapterEnd; String? get chapterTitle;
/// Create a copy of TranscriptionDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TranscriptionDraftCopyWith<TranscriptionDraft> get copyWith => _$TranscriptionDraftCopyWithImpl<TranscriptionDraft>(this as TranscriptionDraft, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TranscriptionDraft&&(identical(other.book, book) || other.book == book)&&(identical(other.text, text) || other.text == text)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.chapterStart, chapterStart) || other.chapterStart == chapterStart)&&(identical(other.chapterEnd, chapterEnd) || other.chapterEnd == chapterEnd)&&(identical(other.chapterTitle, chapterTitle) || other.chapterTitle == chapterTitle));
}


@override
int get hashCode => Object.hash(runtimeType,book,text,start,end,chapterStart,chapterEnd,chapterTitle);

@override
String toString() {
  return 'TranscriptionDraft(book: $book, text: $text, start: $start, end: $end, chapterStart: $chapterStart, chapterEnd: $chapterEnd, chapterTitle: $chapterTitle)';
}


}

/// @nodoc
abstract mixin class $TranscriptionDraftCopyWith<$Res>  {
  factory $TranscriptionDraftCopyWith(TranscriptionDraft value, $Res Function(TranscriptionDraft) _then) = _$TranscriptionDraftCopyWithImpl;
@useResult
$Res call({
 Audiobook book, String text, Duration start, Duration end, Duration chapterStart, Duration chapterEnd, String? chapterTitle
});


$AudiobookCopyWith<$Res> get book;

}
/// @nodoc
class _$TranscriptionDraftCopyWithImpl<$Res>
    implements $TranscriptionDraftCopyWith<$Res> {
  _$TranscriptionDraftCopyWithImpl(this._self, this._then);

  final TranscriptionDraft _self;
  final $Res Function(TranscriptionDraft) _then;

/// Create a copy of TranscriptionDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? book = null,Object? text = null,Object? start = null,Object? end = null,Object? chapterStart = null,Object? chapterEnd = null,Object? chapterTitle = freezed,}) {
  return _then(_self.copyWith(
book: null == book ? _self.book : book // ignore: cast_nullable_to_non_nullable
as Audiobook,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as Duration,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as Duration,chapterStart: null == chapterStart ? _self.chapterStart : chapterStart // ignore: cast_nullable_to_non_nullable
as Duration,chapterEnd: null == chapterEnd ? _self.chapterEnd : chapterEnd // ignore: cast_nullable_to_non_nullable
as Duration,chapterTitle: freezed == chapterTitle ? _self.chapterTitle : chapterTitle // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of TranscriptionDraft
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AudiobookCopyWith<$Res> get book {
  
  return $AudiobookCopyWith<$Res>(_self.book, (value) {
    return _then(_self.copyWith(book: value));
  });
}
}


/// Adds pattern-matching-related methods to [TranscriptionDraft].
extension TranscriptionDraftPatterns on TranscriptionDraft {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TranscriptionDraft value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TranscriptionDraft() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TranscriptionDraft value)  $default,){
final _that = this;
switch (_that) {
case _TranscriptionDraft():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TranscriptionDraft value)?  $default,){
final _that = this;
switch (_that) {
case _TranscriptionDraft() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Audiobook book,  String text,  Duration start,  Duration end,  Duration chapterStart,  Duration chapterEnd,  String? chapterTitle)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TranscriptionDraft() when $default != null:
return $default(_that.book,_that.text,_that.start,_that.end,_that.chapterStart,_that.chapterEnd,_that.chapterTitle);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Audiobook book,  String text,  Duration start,  Duration end,  Duration chapterStart,  Duration chapterEnd,  String? chapterTitle)  $default,) {final _that = this;
switch (_that) {
case _TranscriptionDraft():
return $default(_that.book,_that.text,_that.start,_that.end,_that.chapterStart,_that.chapterEnd,_that.chapterTitle);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Audiobook book,  String text,  Duration start,  Duration end,  Duration chapterStart,  Duration chapterEnd,  String? chapterTitle)?  $default,) {final _that = this;
switch (_that) {
case _TranscriptionDraft() when $default != null:
return $default(_that.book,_that.text,_that.start,_that.end,_that.chapterStart,_that.chapterEnd,_that.chapterTitle);case _:
  return null;

}
}

}

/// @nodoc


class _TranscriptionDraft implements TranscriptionDraft {
  const _TranscriptionDraft({required this.book, required this.text, required this.start, required this.end, required this.chapterStart, required this.chapterEnd, required this.chapterTitle});
  

@override final  Audiobook book;
@override final  String text;
@override final  Duration start;
@override final  Duration end;
@override final  Duration chapterStart;
@override final  Duration chapterEnd;
@override final  String? chapterTitle;

/// Create a copy of TranscriptionDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TranscriptionDraftCopyWith<_TranscriptionDraft> get copyWith => __$TranscriptionDraftCopyWithImpl<_TranscriptionDraft>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TranscriptionDraft&&(identical(other.book, book) || other.book == book)&&(identical(other.text, text) || other.text == text)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end)&&(identical(other.chapterStart, chapterStart) || other.chapterStart == chapterStart)&&(identical(other.chapterEnd, chapterEnd) || other.chapterEnd == chapterEnd)&&(identical(other.chapterTitle, chapterTitle) || other.chapterTitle == chapterTitle));
}


@override
int get hashCode => Object.hash(runtimeType,book,text,start,end,chapterStart,chapterEnd,chapterTitle);

@override
String toString() {
  return 'TranscriptionDraft(book: $book, text: $text, start: $start, end: $end, chapterStart: $chapterStart, chapterEnd: $chapterEnd, chapterTitle: $chapterTitle)';
}


}

/// @nodoc
abstract mixin class _$TranscriptionDraftCopyWith<$Res> implements $TranscriptionDraftCopyWith<$Res> {
  factory _$TranscriptionDraftCopyWith(_TranscriptionDraft value, $Res Function(_TranscriptionDraft) _then) = __$TranscriptionDraftCopyWithImpl;
@override @useResult
$Res call({
 Audiobook book, String text, Duration start, Duration end, Duration chapterStart, Duration chapterEnd, String? chapterTitle
});


@override $AudiobookCopyWith<$Res> get book;

}
/// @nodoc
class __$TranscriptionDraftCopyWithImpl<$Res>
    implements _$TranscriptionDraftCopyWith<$Res> {
  __$TranscriptionDraftCopyWithImpl(this._self, this._then);

  final _TranscriptionDraft _self;
  final $Res Function(_TranscriptionDraft) _then;

/// Create a copy of TranscriptionDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? book = null,Object? text = null,Object? start = null,Object? end = null,Object? chapterStart = null,Object? chapterEnd = null,Object? chapterTitle = freezed,}) {
  return _then(_TranscriptionDraft(
book: null == book ? _self.book : book // ignore: cast_nullable_to_non_nullable
as Audiobook,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as Duration,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as Duration,chapterStart: null == chapterStart ? _self.chapterStart : chapterStart // ignore: cast_nullable_to_non_nullable
as Duration,chapterEnd: null == chapterEnd ? _self.chapterEnd : chapterEnd // ignore: cast_nullable_to_non_nullable
as Duration,chapterTitle: freezed == chapterTitle ? _self.chapterTitle : chapterTitle // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of TranscriptionDraft
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
