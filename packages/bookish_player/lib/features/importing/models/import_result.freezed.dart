// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'import_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ImportResult {

 List<SelectedAudioFile> get selectedFiles; int get importedCount; List<String> get stageHistory; String? get diagnostics; ImportFailedItem? get failedItem; ImportFailureKind? get failureKind; ImportStage? get failureStage; bool get originalRemovalOnly;
/// Create a copy of ImportResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImportResultCopyWith<ImportResult> get copyWith => _$ImportResultCopyWithImpl<ImportResult>(this as ImportResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImportResult&&const DeepCollectionEquality().equals(other.selectedFiles, selectedFiles)&&(identical(other.importedCount, importedCount) || other.importedCount == importedCount)&&const DeepCollectionEquality().equals(other.stageHistory, stageHistory)&&(identical(other.diagnostics, diagnostics) || other.diagnostics == diagnostics)&&(identical(other.failedItem, failedItem) || other.failedItem == failedItem)&&(identical(other.failureKind, failureKind) || other.failureKind == failureKind)&&(identical(other.failureStage, failureStage) || other.failureStage == failureStage)&&(identical(other.originalRemovalOnly, originalRemovalOnly) || other.originalRemovalOnly == originalRemovalOnly));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(selectedFiles),importedCount,const DeepCollectionEquality().hash(stageHistory),diagnostics,failedItem,failureKind,failureStage,originalRemovalOnly);

@override
String toString() {
  return 'ImportResult(selectedFiles: $selectedFiles, importedCount: $importedCount, stageHistory: $stageHistory, diagnostics: $diagnostics, failedItem: $failedItem, failureKind: $failureKind, failureStage: $failureStage, originalRemovalOnly: $originalRemovalOnly)';
}


}

/// @nodoc
abstract mixin class $ImportResultCopyWith<$Res>  {
  factory $ImportResultCopyWith(ImportResult value, $Res Function(ImportResult) _then) = _$ImportResultCopyWithImpl;
@useResult
$Res call({
 List<SelectedAudioFile> selectedFiles, int importedCount, List<String> stageHistory, String? diagnostics, ImportFailedItem? failedItem, ImportFailureKind? failureKind, ImportStage? failureStage, bool originalRemovalOnly
});


$ImportFailedItemCopyWith<$Res>? get failedItem;

}
/// @nodoc
class _$ImportResultCopyWithImpl<$Res>
    implements $ImportResultCopyWith<$Res> {
  _$ImportResultCopyWithImpl(this._self, this._then);

  final ImportResult _self;
  final $Res Function(ImportResult) _then;

/// Create a copy of ImportResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? selectedFiles = null,Object? importedCount = null,Object? stageHistory = null,Object? diagnostics = freezed,Object? failedItem = freezed,Object? failureKind = freezed,Object? failureStage = freezed,Object? originalRemovalOnly = null,}) {
  return _then(_self.copyWith(
selectedFiles: null == selectedFiles ? _self.selectedFiles : selectedFiles // ignore: cast_nullable_to_non_nullable
as List<SelectedAudioFile>,importedCount: null == importedCount ? _self.importedCount : importedCount // ignore: cast_nullable_to_non_nullable
as int,stageHistory: null == stageHistory ? _self.stageHistory : stageHistory // ignore: cast_nullable_to_non_nullable
as List<String>,diagnostics: freezed == diagnostics ? _self.diagnostics : diagnostics // ignore: cast_nullable_to_non_nullable
as String?,failedItem: freezed == failedItem ? _self.failedItem : failedItem // ignore: cast_nullable_to_non_nullable
as ImportFailedItem?,failureKind: freezed == failureKind ? _self.failureKind : failureKind // ignore: cast_nullable_to_non_nullable
as ImportFailureKind?,failureStage: freezed == failureStage ? _self.failureStage : failureStage // ignore: cast_nullable_to_non_nullable
as ImportStage?,originalRemovalOnly: null == originalRemovalOnly ? _self.originalRemovalOnly : originalRemovalOnly // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of ImportResult
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


/// Adds pattern-matching-related methods to [ImportResult].
extension ImportResultPatterns on ImportResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ImportResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ImportResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ImportResult value)  $default,){
final _that = this;
switch (_that) {
case _ImportResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ImportResult value)?  $default,){
final _that = this;
switch (_that) {
case _ImportResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<SelectedAudioFile> selectedFiles,  int importedCount,  List<String> stageHistory,  String? diagnostics,  ImportFailedItem? failedItem,  ImportFailureKind? failureKind,  ImportStage? failureStage,  bool originalRemovalOnly)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ImportResult() when $default != null:
return $default(_that.selectedFiles,_that.importedCount,_that.stageHistory,_that.diagnostics,_that.failedItem,_that.failureKind,_that.failureStage,_that.originalRemovalOnly);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<SelectedAudioFile> selectedFiles,  int importedCount,  List<String> stageHistory,  String? diagnostics,  ImportFailedItem? failedItem,  ImportFailureKind? failureKind,  ImportStage? failureStage,  bool originalRemovalOnly)  $default,) {final _that = this;
switch (_that) {
case _ImportResult():
return $default(_that.selectedFiles,_that.importedCount,_that.stageHistory,_that.diagnostics,_that.failedItem,_that.failureKind,_that.failureStage,_that.originalRemovalOnly);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<SelectedAudioFile> selectedFiles,  int importedCount,  List<String> stageHistory,  String? diagnostics,  ImportFailedItem? failedItem,  ImportFailureKind? failureKind,  ImportStage? failureStage,  bool originalRemovalOnly)?  $default,) {final _that = this;
switch (_that) {
case _ImportResult() when $default != null:
return $default(_that.selectedFiles,_that.importedCount,_that.stageHistory,_that.diagnostics,_that.failedItem,_that.failureKind,_that.failureStage,_that.originalRemovalOnly);case _:
  return null;

}
}

}

/// @nodoc


class _ImportResult implements ImportResult {
  const _ImportResult({required final  List<SelectedAudioFile> selectedFiles, required this.importedCount, final  List<String> stageHistory = const <String>[], this.diagnostics, this.failedItem, this.failureKind, this.failureStage, this.originalRemovalOnly = false}): _selectedFiles = selectedFiles,_stageHistory = stageHistory;
  

 final  List<SelectedAudioFile> _selectedFiles;
@override List<SelectedAudioFile> get selectedFiles {
  if (_selectedFiles is EqualUnmodifiableListView) return _selectedFiles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedFiles);
}

@override final  int importedCount;
 final  List<String> _stageHistory;
@override@JsonKey() List<String> get stageHistory {
  if (_stageHistory is EqualUnmodifiableListView) return _stageHistory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stageHistory);
}

@override final  String? diagnostics;
@override final  ImportFailedItem? failedItem;
@override final  ImportFailureKind? failureKind;
@override final  ImportStage? failureStage;
@override@JsonKey() final  bool originalRemovalOnly;

/// Create a copy of ImportResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ImportResultCopyWith<_ImportResult> get copyWith => __$ImportResultCopyWithImpl<_ImportResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ImportResult&&const DeepCollectionEquality().equals(other._selectedFiles, _selectedFiles)&&(identical(other.importedCount, importedCount) || other.importedCount == importedCount)&&const DeepCollectionEquality().equals(other._stageHistory, _stageHistory)&&(identical(other.diagnostics, diagnostics) || other.diagnostics == diagnostics)&&(identical(other.failedItem, failedItem) || other.failedItem == failedItem)&&(identical(other.failureKind, failureKind) || other.failureKind == failureKind)&&(identical(other.failureStage, failureStage) || other.failureStage == failureStage)&&(identical(other.originalRemovalOnly, originalRemovalOnly) || other.originalRemovalOnly == originalRemovalOnly));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_selectedFiles),importedCount,const DeepCollectionEquality().hash(_stageHistory),diagnostics,failedItem,failureKind,failureStage,originalRemovalOnly);

@override
String toString() {
  return 'ImportResult(selectedFiles: $selectedFiles, importedCount: $importedCount, stageHistory: $stageHistory, diagnostics: $diagnostics, failedItem: $failedItem, failureKind: $failureKind, failureStage: $failureStage, originalRemovalOnly: $originalRemovalOnly)';
}


}

/// @nodoc
abstract mixin class _$ImportResultCopyWith<$Res> implements $ImportResultCopyWith<$Res> {
  factory _$ImportResultCopyWith(_ImportResult value, $Res Function(_ImportResult) _then) = __$ImportResultCopyWithImpl;
@override @useResult
$Res call({
 List<SelectedAudioFile> selectedFiles, int importedCount, List<String> stageHistory, String? diagnostics, ImportFailedItem? failedItem, ImportFailureKind? failureKind, ImportStage? failureStage, bool originalRemovalOnly
});


@override $ImportFailedItemCopyWith<$Res>? get failedItem;

}
/// @nodoc
class __$ImportResultCopyWithImpl<$Res>
    implements _$ImportResultCopyWith<$Res> {
  __$ImportResultCopyWithImpl(this._self, this._then);

  final _ImportResult _self;
  final $Res Function(_ImportResult) _then;

/// Create a copy of ImportResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? selectedFiles = null,Object? importedCount = null,Object? stageHistory = null,Object? diagnostics = freezed,Object? failedItem = freezed,Object? failureKind = freezed,Object? failureStage = freezed,Object? originalRemovalOnly = null,}) {
  return _then(_ImportResult(
selectedFiles: null == selectedFiles ? _self._selectedFiles : selectedFiles // ignore: cast_nullable_to_non_nullable
as List<SelectedAudioFile>,importedCount: null == importedCount ? _self.importedCount : importedCount // ignore: cast_nullable_to_non_nullable
as int,stageHistory: null == stageHistory ? _self._stageHistory : stageHistory // ignore: cast_nullable_to_non_nullable
as List<String>,diagnostics: freezed == diagnostics ? _self.diagnostics : diagnostics // ignore: cast_nullable_to_non_nullable
as String?,failedItem: freezed == failedItem ? _self.failedItem : failedItem // ignore: cast_nullable_to_non_nullable
as ImportFailedItem?,failureKind: freezed == failureKind ? _self.failureKind : failureKind // ignore: cast_nullable_to_non_nullable
as ImportFailureKind?,failureStage: freezed == failureStage ? _self.failureStage : failureStage // ignore: cast_nullable_to_non_nullable
as ImportStage?,originalRemovalOnly: null == originalRemovalOnly ? _self.originalRemovalOnly : originalRemovalOnly // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of ImportResult
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
