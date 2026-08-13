// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'import_progress.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ImportProgress {

 ImportStage get stage; SelectedAudioFile? get selected; int get index; int get total; String? get title; int? get copiedBytes; int? get totalBytes;
/// Create a copy of ImportProgress
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImportProgressCopyWith<ImportProgress> get copyWith => _$ImportProgressCopyWithImpl<ImportProgress>(this as ImportProgress, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImportProgress&&(identical(other.stage, stage) || other.stage == stage)&&(identical(other.selected, selected) || other.selected == selected)&&(identical(other.index, index) || other.index == index)&&(identical(other.total, total) || other.total == total)&&(identical(other.title, title) || other.title == title)&&(identical(other.copiedBytes, copiedBytes) || other.copiedBytes == copiedBytes)&&(identical(other.totalBytes, totalBytes) || other.totalBytes == totalBytes));
}


@override
int get hashCode => Object.hash(runtimeType,stage,selected,index,total,title,copiedBytes,totalBytes);

@override
String toString() {
  return 'ImportProgress(stage: $stage, selected: $selected, index: $index, total: $total, title: $title, copiedBytes: $copiedBytes, totalBytes: $totalBytes)';
}


}

/// @nodoc
abstract mixin class $ImportProgressCopyWith<$Res>  {
  factory $ImportProgressCopyWith(ImportProgress value, $Res Function(ImportProgress) _then) = _$ImportProgressCopyWithImpl;
@useResult
$Res call({
 ImportStage stage, SelectedAudioFile? selected, int index, int total, String? title, int? copiedBytes, int? totalBytes
});


$SelectedAudioFileCopyWith<$Res>? get selected;

}
/// @nodoc
class _$ImportProgressCopyWithImpl<$Res>
    implements $ImportProgressCopyWith<$Res> {
  _$ImportProgressCopyWithImpl(this._self, this._then);

  final ImportProgress _self;
  final $Res Function(ImportProgress) _then;

/// Create a copy of ImportProgress
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? stage = null,Object? selected = freezed,Object? index = null,Object? total = null,Object? title = freezed,Object? copiedBytes = freezed,Object? totalBytes = freezed,}) {
  return _then(_self.copyWith(
stage: null == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as ImportStage,selected: freezed == selected ? _self.selected : selected // ignore: cast_nullable_to_non_nullable
as SelectedAudioFile?,index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,copiedBytes: freezed == copiedBytes ? _self.copiedBytes : copiedBytes // ignore: cast_nullable_to_non_nullable
as int?,totalBytes: freezed == totalBytes ? _self.totalBytes : totalBytes // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}
/// Create a copy of ImportProgress
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SelectedAudioFileCopyWith<$Res>? get selected {
    if (_self.selected == null) {
    return null;
  }

  return $SelectedAudioFileCopyWith<$Res>(_self.selected!, (value) {
    return _then(_self.copyWith(selected: value));
  });
}
}


/// Adds pattern-matching-related methods to [ImportProgress].
extension ImportProgressPatterns on ImportProgress {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ImportProgress value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ImportProgress() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ImportProgress value)  $default,){
final _that = this;
switch (_that) {
case _ImportProgress():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ImportProgress value)?  $default,){
final _that = this;
switch (_that) {
case _ImportProgress() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ImportStage stage,  SelectedAudioFile? selected,  int index,  int total,  String? title,  int? copiedBytes,  int? totalBytes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ImportProgress() when $default != null:
return $default(_that.stage,_that.selected,_that.index,_that.total,_that.title,_that.copiedBytes,_that.totalBytes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ImportStage stage,  SelectedAudioFile? selected,  int index,  int total,  String? title,  int? copiedBytes,  int? totalBytes)  $default,) {final _that = this;
switch (_that) {
case _ImportProgress():
return $default(_that.stage,_that.selected,_that.index,_that.total,_that.title,_that.copiedBytes,_that.totalBytes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ImportStage stage,  SelectedAudioFile? selected,  int index,  int total,  String? title,  int? copiedBytes,  int? totalBytes)?  $default,) {final _that = this;
switch (_that) {
case _ImportProgress() when $default != null:
return $default(_that.stage,_that.selected,_that.index,_that.total,_that.title,_that.copiedBytes,_that.totalBytes);case _:
  return null;

}
}

}

/// @nodoc


class _ImportProgress implements ImportProgress {
  const _ImportProgress({required this.stage, this.selected, this.index = 0, this.total = 0, this.title, this.copiedBytes, this.totalBytes});
  

@override final  ImportStage stage;
@override final  SelectedAudioFile? selected;
@override@JsonKey() final  int index;
@override@JsonKey() final  int total;
@override final  String? title;
@override final  int? copiedBytes;
@override final  int? totalBytes;

/// Create a copy of ImportProgress
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ImportProgressCopyWith<_ImportProgress> get copyWith => __$ImportProgressCopyWithImpl<_ImportProgress>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ImportProgress&&(identical(other.stage, stage) || other.stage == stage)&&(identical(other.selected, selected) || other.selected == selected)&&(identical(other.index, index) || other.index == index)&&(identical(other.total, total) || other.total == total)&&(identical(other.title, title) || other.title == title)&&(identical(other.copiedBytes, copiedBytes) || other.copiedBytes == copiedBytes)&&(identical(other.totalBytes, totalBytes) || other.totalBytes == totalBytes));
}


@override
int get hashCode => Object.hash(runtimeType,stage,selected,index,total,title,copiedBytes,totalBytes);

@override
String toString() {
  return 'ImportProgress(stage: $stage, selected: $selected, index: $index, total: $total, title: $title, copiedBytes: $copiedBytes, totalBytes: $totalBytes)';
}


}

/// @nodoc
abstract mixin class _$ImportProgressCopyWith<$Res> implements $ImportProgressCopyWith<$Res> {
  factory _$ImportProgressCopyWith(_ImportProgress value, $Res Function(_ImportProgress) _then) = __$ImportProgressCopyWithImpl;
@override @useResult
$Res call({
 ImportStage stage, SelectedAudioFile? selected, int index, int total, String? title, int? copiedBytes, int? totalBytes
});


@override $SelectedAudioFileCopyWith<$Res>? get selected;

}
/// @nodoc
class __$ImportProgressCopyWithImpl<$Res>
    implements _$ImportProgressCopyWith<$Res> {
  __$ImportProgressCopyWithImpl(this._self, this._then);

  final _ImportProgress _self;
  final $Res Function(_ImportProgress) _then;

/// Create a copy of ImportProgress
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? stage = null,Object? selected = freezed,Object? index = null,Object? total = null,Object? title = freezed,Object? copiedBytes = freezed,Object? totalBytes = freezed,}) {
  return _then(_ImportProgress(
stage: null == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as ImportStage,selected: freezed == selected ? _self.selected : selected // ignore: cast_nullable_to_non_nullable
as SelectedAudioFile?,index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,copiedBytes: freezed == copiedBytes ? _self.copiedBytes : copiedBytes // ignore: cast_nullable_to_non_nullable
as int?,totalBytes: freezed == totalBytes ? _self.totalBytes : totalBytes // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

/// Create a copy of ImportProgress
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SelectedAudioFileCopyWith<$Res>? get selected {
    if (_self.selected == null) {
    return null;
  }

  return $SelectedAudioFileCopyWith<$Res>(_self.selected!, (value) {
    return _then(_self.copyWith(selected: value));
  });
}
}

// dart format on
