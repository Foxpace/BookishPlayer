// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'import_workflow_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ImportWorkflowFailure {

 ImportFailureKind get kind; ImportStage get stage; List<SelectedAudioFile> get selectedFiles; int get importedCount; List<String> get stageHistory; String get diagnostics; ImportFailedItem? get failedItem; bool get originalRemovalOnly;
/// Create a copy of ImportWorkflowFailure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImportWorkflowFailureCopyWith<ImportWorkflowFailure> get copyWith => _$ImportWorkflowFailureCopyWithImpl<ImportWorkflowFailure>(this as ImportWorkflowFailure, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImportWorkflowFailure&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.stage, stage) || other.stage == stage)&&const DeepCollectionEquality().equals(other.selectedFiles, selectedFiles)&&(identical(other.importedCount, importedCount) || other.importedCount == importedCount)&&const DeepCollectionEquality().equals(other.stageHistory, stageHistory)&&(identical(other.diagnostics, diagnostics) || other.diagnostics == diagnostics)&&(identical(other.failedItem, failedItem) || other.failedItem == failedItem)&&(identical(other.originalRemovalOnly, originalRemovalOnly) || other.originalRemovalOnly == originalRemovalOnly));
}


@override
int get hashCode => Object.hash(runtimeType,kind,stage,const DeepCollectionEquality().hash(selectedFiles),importedCount,const DeepCollectionEquality().hash(stageHistory),diagnostics,failedItem,originalRemovalOnly);

@override
String toString() {
  return 'ImportWorkflowFailure(kind: $kind, stage: $stage, selectedFiles: $selectedFiles, importedCount: $importedCount, stageHistory: $stageHistory, diagnostics: $diagnostics, failedItem: $failedItem, originalRemovalOnly: $originalRemovalOnly)';
}


}

/// @nodoc
abstract mixin class $ImportWorkflowFailureCopyWith<$Res>  {
  factory $ImportWorkflowFailureCopyWith(ImportWorkflowFailure value, $Res Function(ImportWorkflowFailure) _then) = _$ImportWorkflowFailureCopyWithImpl;
@useResult
$Res call({
 ImportFailureKind kind, ImportStage stage, List<SelectedAudioFile> selectedFiles, int importedCount, List<String> stageHistory, String diagnostics, ImportFailedItem? failedItem, bool originalRemovalOnly
});


$ImportFailedItemCopyWith<$Res>? get failedItem;

}
/// @nodoc
class _$ImportWorkflowFailureCopyWithImpl<$Res>
    implements $ImportWorkflowFailureCopyWith<$Res> {
  _$ImportWorkflowFailureCopyWithImpl(this._self, this._then);

  final ImportWorkflowFailure _self;
  final $Res Function(ImportWorkflowFailure) _then;

/// Create a copy of ImportWorkflowFailure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? kind = null,Object? stage = null,Object? selectedFiles = null,Object? importedCount = null,Object? stageHistory = null,Object? diagnostics = null,Object? failedItem = freezed,Object? originalRemovalOnly = null,}) {
  return _then(_self.copyWith(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as ImportFailureKind,stage: null == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as ImportStage,selectedFiles: null == selectedFiles ? _self.selectedFiles : selectedFiles // ignore: cast_nullable_to_non_nullable
as List<SelectedAudioFile>,importedCount: null == importedCount ? _self.importedCount : importedCount // ignore: cast_nullable_to_non_nullable
as int,stageHistory: null == stageHistory ? _self.stageHistory : stageHistory // ignore: cast_nullable_to_non_nullable
as List<String>,diagnostics: null == diagnostics ? _self.diagnostics : diagnostics // ignore: cast_nullable_to_non_nullable
as String,failedItem: freezed == failedItem ? _self.failedItem : failedItem // ignore: cast_nullable_to_non_nullable
as ImportFailedItem?,originalRemovalOnly: null == originalRemovalOnly ? _self.originalRemovalOnly : originalRemovalOnly // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of ImportWorkflowFailure
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ImportFailedItemCopyWith<$Res>? get failedItem {
    if (_self.failedItem == null) {
    return null;
  }

  return $ImportFailedItemCopyWith<$Res>(_self.failedItem!, (value) {
    return _then(_self.copyWith(failedItem: value));
  });
}
}


/// Adds pattern-matching-related methods to [ImportWorkflowFailure].
extension ImportWorkflowFailurePatterns on ImportWorkflowFailure {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ImportWorkflowFailure value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ImportWorkflowFailure() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ImportWorkflowFailure value)  $default,){
final _that = this;
switch (_that) {
case _ImportWorkflowFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ImportWorkflowFailure value)?  $default,){
final _that = this;
switch (_that) {
case _ImportWorkflowFailure() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ImportFailureKind kind,  ImportStage stage,  List<SelectedAudioFile> selectedFiles,  int importedCount,  List<String> stageHistory,  String diagnostics,  ImportFailedItem? failedItem,  bool originalRemovalOnly)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ImportWorkflowFailure() when $default != null:
return $default(_that.kind,_that.stage,_that.selectedFiles,_that.importedCount,_that.stageHistory,_that.diagnostics,_that.failedItem,_that.originalRemovalOnly);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ImportFailureKind kind,  ImportStage stage,  List<SelectedAudioFile> selectedFiles,  int importedCount,  List<String> stageHistory,  String diagnostics,  ImportFailedItem? failedItem,  bool originalRemovalOnly)  $default,) {final _that = this;
switch (_that) {
case _ImportWorkflowFailure():
return $default(_that.kind,_that.stage,_that.selectedFiles,_that.importedCount,_that.stageHistory,_that.diagnostics,_that.failedItem,_that.originalRemovalOnly);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ImportFailureKind kind,  ImportStage stage,  List<SelectedAudioFile> selectedFiles,  int importedCount,  List<String> stageHistory,  String diagnostics,  ImportFailedItem? failedItem,  bool originalRemovalOnly)?  $default,) {final _that = this;
switch (_that) {
case _ImportWorkflowFailure() when $default != null:
return $default(_that.kind,_that.stage,_that.selectedFiles,_that.importedCount,_that.stageHistory,_that.diagnostics,_that.failedItem,_that.originalRemovalOnly);case _:
  return null;

}
}

}

/// @nodoc


class _ImportWorkflowFailure implements ImportWorkflowFailure {
  const _ImportWorkflowFailure({required this.kind, required this.stage, required final  List<SelectedAudioFile> selectedFiles, required this.importedCount, required final  List<String> stageHistory, required this.diagnostics, this.failedItem, this.originalRemovalOnly = false}): _selectedFiles = selectedFiles,_stageHistory = stageHistory;
  

@override final  ImportFailureKind kind;
@override final  ImportStage stage;
 final  List<SelectedAudioFile> _selectedFiles;
@override List<SelectedAudioFile> get selectedFiles {
  if (_selectedFiles is EqualUnmodifiableListView) return _selectedFiles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedFiles);
}

@override final  int importedCount;
 final  List<String> _stageHistory;
@override List<String> get stageHistory {
  if (_stageHistory is EqualUnmodifiableListView) return _stageHistory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stageHistory);
}

@override final  String diagnostics;
@override final  ImportFailedItem? failedItem;
@override@JsonKey() final  bool originalRemovalOnly;

/// Create a copy of ImportWorkflowFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ImportWorkflowFailureCopyWith<_ImportWorkflowFailure> get copyWith => __$ImportWorkflowFailureCopyWithImpl<_ImportWorkflowFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ImportWorkflowFailure&&(identical(other.kind, kind) || other.kind == kind)&&(identical(other.stage, stage) || other.stage == stage)&&const DeepCollectionEquality().equals(other._selectedFiles, _selectedFiles)&&(identical(other.importedCount, importedCount) || other.importedCount == importedCount)&&const DeepCollectionEquality().equals(other._stageHistory, _stageHistory)&&(identical(other.diagnostics, diagnostics) || other.diagnostics == diagnostics)&&(identical(other.failedItem, failedItem) || other.failedItem == failedItem)&&(identical(other.originalRemovalOnly, originalRemovalOnly) || other.originalRemovalOnly == originalRemovalOnly));
}


@override
int get hashCode => Object.hash(runtimeType,kind,stage,const DeepCollectionEquality().hash(_selectedFiles),importedCount,const DeepCollectionEquality().hash(_stageHistory),diagnostics,failedItem,originalRemovalOnly);

@override
String toString() {
  return 'ImportWorkflowFailure(kind: $kind, stage: $stage, selectedFiles: $selectedFiles, importedCount: $importedCount, stageHistory: $stageHistory, diagnostics: $diagnostics, failedItem: $failedItem, originalRemovalOnly: $originalRemovalOnly)';
}


}

/// @nodoc
abstract mixin class _$ImportWorkflowFailureCopyWith<$Res> implements $ImportWorkflowFailureCopyWith<$Res> {
  factory _$ImportWorkflowFailureCopyWith(_ImportWorkflowFailure value, $Res Function(_ImportWorkflowFailure) _then) = __$ImportWorkflowFailureCopyWithImpl;
@override @useResult
$Res call({
 ImportFailureKind kind, ImportStage stage, List<SelectedAudioFile> selectedFiles, int importedCount, List<String> stageHistory, String diagnostics, ImportFailedItem? failedItem, bool originalRemovalOnly
});


@override $ImportFailedItemCopyWith<$Res>? get failedItem;

}
/// @nodoc
class __$ImportWorkflowFailureCopyWithImpl<$Res>
    implements _$ImportWorkflowFailureCopyWith<$Res> {
  __$ImportWorkflowFailureCopyWithImpl(this._self, this._then);

  final _ImportWorkflowFailure _self;
  final $Res Function(_ImportWorkflowFailure) _then;

/// Create a copy of ImportWorkflowFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? kind = null,Object? stage = null,Object? selectedFiles = null,Object? importedCount = null,Object? stageHistory = null,Object? diagnostics = null,Object? failedItem = freezed,Object? originalRemovalOnly = null,}) {
  return _then(_ImportWorkflowFailure(
kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as ImportFailureKind,stage: null == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as ImportStage,selectedFiles: null == selectedFiles ? _self._selectedFiles : selectedFiles // ignore: cast_nullable_to_non_nullable
as List<SelectedAudioFile>,importedCount: null == importedCount ? _self.importedCount : importedCount // ignore: cast_nullable_to_non_nullable
as int,stageHistory: null == stageHistory ? _self._stageHistory : stageHistory // ignore: cast_nullable_to_non_nullable
as List<String>,diagnostics: null == diagnostics ? _self.diagnostics : diagnostics // ignore: cast_nullable_to_non_nullable
as String,failedItem: freezed == failedItem ? _self.failedItem : failedItem // ignore: cast_nullable_to_non_nullable
as ImportFailedItem?,originalRemovalOnly: null == originalRemovalOnly ? _self.originalRemovalOnly : originalRemovalOnly // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of ImportWorkflowFailure
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ImportFailedItemCopyWith<$Res>? get failedItem {
    if (_self.failedItem == null) {
    return null;
  }

  return $ImportFailedItemCopyWith<$Res>(_self.failedItem!, (value) {
    return _then(_self.copyWith(failedItem: value));
  });
}
}

// dart format on
