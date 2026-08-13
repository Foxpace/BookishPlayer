// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quote_transcription_context.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QuoteTranscriptionContext {

 Audiobook get book; String? get chapterTitle; Duration get chapterStart;
/// Create a copy of QuoteTranscriptionContext
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuoteTranscriptionContextCopyWith<QuoteTranscriptionContext> get copyWith => _$QuoteTranscriptionContextCopyWithImpl<QuoteTranscriptionContext>(this as QuoteTranscriptionContext, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuoteTranscriptionContext&&(identical(other.book, book) || other.book == book)&&(identical(other.chapterTitle, chapterTitle) || other.chapterTitle == chapterTitle)&&(identical(other.chapterStart, chapterStart) || other.chapterStart == chapterStart));
}


@override
int get hashCode => Object.hash(runtimeType,book,chapterTitle,chapterStart);

@override
String toString() {
  return 'QuoteTranscriptionContext(book: $book, chapterTitle: $chapterTitle, chapterStart: $chapterStart)';
}


}

/// @nodoc
abstract mixin class $QuoteTranscriptionContextCopyWith<$Res>  {
  factory $QuoteTranscriptionContextCopyWith(QuoteTranscriptionContext value, $Res Function(QuoteTranscriptionContext) _then) = _$QuoteTranscriptionContextCopyWithImpl;
@useResult
$Res call({
 Audiobook book, String? chapterTitle, Duration chapterStart
});


$AudiobookCopyWith<$Res> get book;

}
/// @nodoc
class _$QuoteTranscriptionContextCopyWithImpl<$Res>
    implements $QuoteTranscriptionContextCopyWith<$Res> {
  _$QuoteTranscriptionContextCopyWithImpl(this._self, this._then);

  final QuoteTranscriptionContext _self;
  final $Res Function(QuoteTranscriptionContext) _then;

/// Create a copy of QuoteTranscriptionContext
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? book = null,Object? chapterTitle = freezed,Object? chapterStart = null,}) {
  return _then(_self.copyWith(
book: null == book ? _self.book : book // ignore: cast_nullable_to_non_nullable
as Audiobook,chapterTitle: freezed == chapterTitle ? _self.chapterTitle : chapterTitle // ignore: cast_nullable_to_non_nullable
as String?,chapterStart: null == chapterStart ? _self.chapterStart : chapterStart // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}
/// Create a copy of QuoteTranscriptionContext
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AudiobookCopyWith<$Res> get book {
  
  return $AudiobookCopyWith<$Res>(_self.book, (value) {
    return _then(_self.copyWith(book: value));
  });
}
}


/// Adds pattern-matching-related methods to [QuoteTranscriptionContext].
extension QuoteTranscriptionContextPatterns on QuoteTranscriptionContext {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuoteTranscriptionContext value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuoteTranscriptionContext() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuoteTranscriptionContext value)  $default,){
final _that = this;
switch (_that) {
case _QuoteTranscriptionContext():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuoteTranscriptionContext value)?  $default,){
final _that = this;
switch (_that) {
case _QuoteTranscriptionContext() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Audiobook book,  String? chapterTitle,  Duration chapterStart)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuoteTranscriptionContext() when $default != null:
return $default(_that.book,_that.chapterTitle,_that.chapterStart);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Audiobook book,  String? chapterTitle,  Duration chapterStart)  $default,) {final _that = this;
switch (_that) {
case _QuoteTranscriptionContext():
return $default(_that.book,_that.chapterTitle,_that.chapterStart);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Audiobook book,  String? chapterTitle,  Duration chapterStart)?  $default,) {final _that = this;
switch (_that) {
case _QuoteTranscriptionContext() when $default != null:
return $default(_that.book,_that.chapterTitle,_that.chapterStart);case _:
  return null;

}
}

}

/// @nodoc


class _QuoteTranscriptionContext implements QuoteTranscriptionContext {
  const _QuoteTranscriptionContext({required this.book, required this.chapterTitle, required this.chapterStart});
  

@override final  Audiobook book;
@override final  String? chapterTitle;
@override final  Duration chapterStart;

/// Create a copy of QuoteTranscriptionContext
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuoteTranscriptionContextCopyWith<_QuoteTranscriptionContext> get copyWith => __$QuoteTranscriptionContextCopyWithImpl<_QuoteTranscriptionContext>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuoteTranscriptionContext&&(identical(other.book, book) || other.book == book)&&(identical(other.chapterTitle, chapterTitle) || other.chapterTitle == chapterTitle)&&(identical(other.chapterStart, chapterStart) || other.chapterStart == chapterStart));
}


@override
int get hashCode => Object.hash(runtimeType,book,chapterTitle,chapterStart);

@override
String toString() {
  return 'QuoteTranscriptionContext(book: $book, chapterTitle: $chapterTitle, chapterStart: $chapterStart)';
}


}

/// @nodoc
abstract mixin class _$QuoteTranscriptionContextCopyWith<$Res> implements $QuoteTranscriptionContextCopyWith<$Res> {
  factory _$QuoteTranscriptionContextCopyWith(_QuoteTranscriptionContext value, $Res Function(_QuoteTranscriptionContext) _then) = __$QuoteTranscriptionContextCopyWithImpl;
@override @useResult
$Res call({
 Audiobook book, String? chapterTitle, Duration chapterStart
});


@override $AudiobookCopyWith<$Res> get book;

}
/// @nodoc
class __$QuoteTranscriptionContextCopyWithImpl<$Res>
    implements _$QuoteTranscriptionContextCopyWith<$Res> {
  __$QuoteTranscriptionContextCopyWithImpl(this._self, this._then);

  final _QuoteTranscriptionContext _self;
  final $Res Function(_QuoteTranscriptionContext) _then;

/// Create a copy of QuoteTranscriptionContext
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? book = null,Object? chapterTitle = freezed,Object? chapterStart = null,}) {
  return _then(_QuoteTranscriptionContext(
book: null == book ? _self.book : book // ignore: cast_nullable_to_non_nullable
as Audiobook,chapterTitle: freezed == chapterTitle ? _self.chapterTitle : chapterTitle // ignore: cast_nullable_to_non_nullable
as String?,chapterStart: null == chapterStart ? _self.chapterStart : chapterStart // ignore: cast_nullable_to_non_nullable
as Duration,
  ));
}

/// Create a copy of QuoteTranscriptionContext
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
