// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'import_workflow_cancellation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ImportWorkflowCancellation {

 List<SelectedAudioFile> get selectedFiles; int get importedCount;
/// Create a copy of ImportWorkflowCancellation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImportWorkflowCancellationCopyWith<ImportWorkflowCancellation> get copyWith => _$ImportWorkflowCancellationCopyWithImpl<ImportWorkflowCancellation>(this as ImportWorkflowCancellation, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImportWorkflowCancellation&&const DeepCollectionEquality().equals(other.selectedFiles, selectedFiles)&&(identical(other.importedCount, importedCount) || other.importedCount == importedCount));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(selectedFiles),importedCount);

@override
String toString() {
  return 'ImportWorkflowCancellation(selectedFiles: $selectedFiles, importedCount: $importedCount)';
}


}

/// @nodoc
abstract mixin class $ImportWorkflowCancellationCopyWith<$Res>  {
  factory $ImportWorkflowCancellationCopyWith(ImportWorkflowCancellation value, $Res Function(ImportWorkflowCancellation) _then) = _$ImportWorkflowCancellationCopyWithImpl;
@useResult
$Res call({
 List<SelectedAudioFile> selectedFiles, int importedCount
});




}
/// @nodoc
class _$ImportWorkflowCancellationCopyWithImpl<$Res>
    implements $ImportWorkflowCancellationCopyWith<$Res> {
  _$ImportWorkflowCancellationCopyWithImpl(this._self, this._then);

  final ImportWorkflowCancellation _self;
  final $Res Function(ImportWorkflowCancellation) _then;

/// Create a copy of ImportWorkflowCancellation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? selectedFiles = null,Object? importedCount = null,}) {
  return _then(_self.copyWith(
selectedFiles: null == selectedFiles ? _self.selectedFiles : selectedFiles // ignore: cast_nullable_to_non_nullable
as List<SelectedAudioFile>,importedCount: null == importedCount ? _self.importedCount : importedCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ImportWorkflowCancellation].
extension ImportWorkflowCancellationPatterns on ImportWorkflowCancellation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ImportWorkflowCancellation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ImportWorkflowCancellation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ImportWorkflowCancellation value)  $default,){
final _that = this;
switch (_that) {
case _ImportWorkflowCancellation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ImportWorkflowCancellation value)?  $default,){
final _that = this;
switch (_that) {
case _ImportWorkflowCancellation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<SelectedAudioFile> selectedFiles,  int importedCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ImportWorkflowCancellation() when $default != null:
return $default(_that.selectedFiles,_that.importedCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<SelectedAudioFile> selectedFiles,  int importedCount)  $default,) {final _that = this;
switch (_that) {
case _ImportWorkflowCancellation():
return $default(_that.selectedFiles,_that.importedCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<SelectedAudioFile> selectedFiles,  int importedCount)?  $default,) {final _that = this;
switch (_that) {
case _ImportWorkflowCancellation() when $default != null:
return $default(_that.selectedFiles,_that.importedCount);case _:
  return null;

}
}

}

/// @nodoc


class _ImportWorkflowCancellation implements ImportWorkflowCancellation {
  const _ImportWorkflowCancellation({required final  List<SelectedAudioFile> selectedFiles, required this.importedCount}): _selectedFiles = selectedFiles;
  

 final  List<SelectedAudioFile> _selectedFiles;
@override List<SelectedAudioFile> get selectedFiles {
  if (_selectedFiles is EqualUnmodifiableListView) return _selectedFiles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedFiles);
}

@override final  int importedCount;

/// Create a copy of ImportWorkflowCancellation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ImportWorkflowCancellationCopyWith<_ImportWorkflowCancellation> get copyWith => __$ImportWorkflowCancellationCopyWithImpl<_ImportWorkflowCancellation>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ImportWorkflowCancellation&&const DeepCollectionEquality().equals(other._selectedFiles, _selectedFiles)&&(identical(other.importedCount, importedCount) || other.importedCount == importedCount));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_selectedFiles),importedCount);

@override
String toString() {
  return 'ImportWorkflowCancellation(selectedFiles: $selectedFiles, importedCount: $importedCount)';
}


}

/// @nodoc
abstract mixin class _$ImportWorkflowCancellationCopyWith<$Res> implements $ImportWorkflowCancellationCopyWith<$Res> {
  factory _$ImportWorkflowCancellationCopyWith(_ImportWorkflowCancellation value, $Res Function(_ImportWorkflowCancellation) _then) = __$ImportWorkflowCancellationCopyWithImpl;
@override @useResult
$Res call({
 List<SelectedAudioFile> selectedFiles, int importedCount
});




}
/// @nodoc
class __$ImportWorkflowCancellationCopyWithImpl<$Res>
    implements _$ImportWorkflowCancellationCopyWith<$Res> {
  __$ImportWorkflowCancellationCopyWithImpl(this._self, this._then);

  final _ImportWorkflowCancellation _self;
  final $Res Function(_ImportWorkflowCancellation) _then;

/// Create a copy of ImportWorkflowCancellation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? selectedFiles = null,Object? importedCount = null,}) {
  return _then(_ImportWorkflowCancellation(
selectedFiles: null == selectedFiles ? _self._selectedFiles : selectedFiles // ignore: cast_nullable_to_non_nullable
as List<SelectedAudioFile>,importedCount: null == importedCount ? _self.importedCount : importedCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
