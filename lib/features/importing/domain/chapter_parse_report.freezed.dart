// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chapter_parse_report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChapterParseReport {

 List<AudioChapter> get chapters; List<String> get diagnostics; List<String> get warnings;
/// Create a copy of ChapterParseReport
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChapterParseReportCopyWith<ChapterParseReport> get copyWith => _$ChapterParseReportCopyWithImpl<ChapterParseReport>(this as ChapterParseReport, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChapterParseReport&&const DeepCollectionEquality().equals(other.chapters, chapters)&&const DeepCollectionEquality().equals(other.diagnostics, diagnostics)&&const DeepCollectionEquality().equals(other.warnings, warnings));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(chapters),const DeepCollectionEquality().hash(diagnostics),const DeepCollectionEquality().hash(warnings));

@override
String toString() {
  return 'ChapterParseReport(chapters: $chapters, diagnostics: $diagnostics, warnings: $warnings)';
}


}

/// @nodoc
abstract mixin class $ChapterParseReportCopyWith<$Res>  {
  factory $ChapterParseReportCopyWith(ChapterParseReport value, $Res Function(ChapterParseReport) _then) = _$ChapterParseReportCopyWithImpl;
@useResult
$Res call({
 List<AudioChapter> chapters, List<String> diagnostics, List<String> warnings
});




}
/// @nodoc
class _$ChapterParseReportCopyWithImpl<$Res>
    implements $ChapterParseReportCopyWith<$Res> {
  _$ChapterParseReportCopyWithImpl(this._self, this._then);

  final ChapterParseReport _self;
  final $Res Function(ChapterParseReport) _then;

/// Create a copy of ChapterParseReport
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? chapters = null,Object? diagnostics = null,Object? warnings = null,}) {
  return _then(_self.copyWith(
chapters: null == chapters ? _self.chapters : chapters // ignore: cast_nullable_to_non_nullable
as List<AudioChapter>,diagnostics: null == diagnostics ? _self.diagnostics : diagnostics // ignore: cast_nullable_to_non_nullable
as List<String>,warnings: null == warnings ? _self.warnings : warnings // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [ChapterParseReport].
extension ChapterParseReportPatterns on ChapterParseReport {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChapterParseReport value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChapterParseReport() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChapterParseReport value)  $default,){
final _that = this;
switch (_that) {
case _ChapterParseReport():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChapterParseReport value)?  $default,){
final _that = this;
switch (_that) {
case _ChapterParseReport() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<AudioChapter> chapters,  List<String> diagnostics,  List<String> warnings)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChapterParseReport() when $default != null:
return $default(_that.chapters,_that.diagnostics,_that.warnings);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<AudioChapter> chapters,  List<String> diagnostics,  List<String> warnings)  $default,) {final _that = this;
switch (_that) {
case _ChapterParseReport():
return $default(_that.chapters,_that.diagnostics,_that.warnings);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<AudioChapter> chapters,  List<String> diagnostics,  List<String> warnings)?  $default,) {final _that = this;
switch (_that) {
case _ChapterParseReport() when $default != null:
return $default(_that.chapters,_that.diagnostics,_that.warnings);case _:
  return null;

}
}

}

/// @nodoc


class _ChapterParseReport implements ChapterParseReport {
  const _ChapterParseReport({final  List<AudioChapter> chapters = const <AudioChapter>[], final  List<String> diagnostics = const <String>[], final  List<String> warnings = const <String>[]}): _chapters = chapters,_diagnostics = diagnostics,_warnings = warnings;
  

 final  List<AudioChapter> _chapters;
@override@JsonKey() List<AudioChapter> get chapters {
  if (_chapters is EqualUnmodifiableListView) return _chapters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_chapters);
}

 final  List<String> _diagnostics;
@override@JsonKey() List<String> get diagnostics {
  if (_diagnostics is EqualUnmodifiableListView) return _diagnostics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_diagnostics);
}

 final  List<String> _warnings;
@override@JsonKey() List<String> get warnings {
  if (_warnings is EqualUnmodifiableListView) return _warnings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_warnings);
}


/// Create a copy of ChapterParseReport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChapterParseReportCopyWith<_ChapterParseReport> get copyWith => __$ChapterParseReportCopyWithImpl<_ChapterParseReport>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChapterParseReport&&const DeepCollectionEquality().equals(other._chapters, _chapters)&&const DeepCollectionEquality().equals(other._diagnostics, _diagnostics)&&const DeepCollectionEquality().equals(other._warnings, _warnings));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_chapters),const DeepCollectionEquality().hash(_diagnostics),const DeepCollectionEquality().hash(_warnings));

@override
String toString() {
  return 'ChapterParseReport(chapters: $chapters, diagnostics: $diagnostics, warnings: $warnings)';
}


}

/// @nodoc
abstract mixin class _$ChapterParseReportCopyWith<$Res> implements $ChapterParseReportCopyWith<$Res> {
  factory _$ChapterParseReportCopyWith(_ChapterParseReport value, $Res Function(_ChapterParseReport) _then) = __$ChapterParseReportCopyWithImpl;
@override @useResult
$Res call({
 List<AudioChapter> chapters, List<String> diagnostics, List<String> warnings
});




}
/// @nodoc
class __$ChapterParseReportCopyWithImpl<$Res>
    implements _$ChapterParseReportCopyWith<$Res> {
  __$ChapterParseReportCopyWithImpl(this._self, this._then);

  final _ChapterParseReport _self;
  final $Res Function(_ChapterParseReport) _then;

/// Create a copy of ChapterParseReport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? chapters = null,Object? diagnostics = null,Object? warnings = null,}) {
  return _then(_ChapterParseReport(
chapters: null == chapters ? _self._chapters : chapters // ignore: cast_nullable_to_non_nullable
as List<AudioChapter>,diagnostics: null == diagnostics ? _self._diagnostics : diagnostics // ignore: cast_nullable_to_non_nullable
as List<String>,warnings: null == warnings ? _self._warnings : warnings // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
