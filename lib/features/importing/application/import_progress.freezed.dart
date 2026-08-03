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

/// @nodoc
mixin _$ImportResult {

 List<SelectedAudioFile> get selectedFiles; int get importedCount;
/// Create a copy of ImportResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImportResultCopyWith<ImportResult> get copyWith => _$ImportResultCopyWithImpl<ImportResult>(this as ImportResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImportResult&&const DeepCollectionEquality().equals(other.selectedFiles, selectedFiles)&&(identical(other.importedCount, importedCount) || other.importedCount == importedCount));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(selectedFiles),importedCount);

@override
String toString() {
  return 'ImportResult(selectedFiles: $selectedFiles, importedCount: $importedCount)';
}


}

/// @nodoc
abstract mixin class $ImportResultCopyWith<$Res>  {
  factory $ImportResultCopyWith(ImportResult value, $Res Function(ImportResult) _then) = _$ImportResultCopyWithImpl;
@useResult
$Res call({
 List<SelectedAudioFile> selectedFiles, int importedCount
});




}
/// @nodoc
class _$ImportResultCopyWithImpl<$Res>
    implements $ImportResultCopyWith<$Res> {
  _$ImportResultCopyWithImpl(this._self, this._then);

  final ImportResult _self;
  final $Res Function(ImportResult) _then;

/// Create a copy of ImportResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? selectedFiles = null,Object? importedCount = null,}) {
  return _then(_self.copyWith(
selectedFiles: null == selectedFiles ? _self.selectedFiles : selectedFiles // ignore: cast_nullable_to_non_nullable
as List<SelectedAudioFile>,importedCount: null == importedCount ? _self.importedCount : importedCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<SelectedAudioFile> selectedFiles,  int importedCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ImportResult() when $default != null:
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
case _ImportResult():
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
case _ImportResult() when $default != null:
return $default(_that.selectedFiles,_that.importedCount);case _:
  return null;

}
}

}

/// @nodoc


class _ImportResult implements ImportResult {
  const _ImportResult({required final  List<SelectedAudioFile> selectedFiles, required this.importedCount}): _selectedFiles = selectedFiles;
  

 final  List<SelectedAudioFile> _selectedFiles;
@override List<SelectedAudioFile> get selectedFiles {
  if (_selectedFiles is EqualUnmodifiableListView) return _selectedFiles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedFiles);
}

@override final  int importedCount;

/// Create a copy of ImportResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ImportResultCopyWith<_ImportResult> get copyWith => __$ImportResultCopyWithImpl<_ImportResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ImportResult&&const DeepCollectionEquality().equals(other._selectedFiles, _selectedFiles)&&(identical(other.importedCount, importedCount) || other.importedCount == importedCount));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_selectedFiles),importedCount);

@override
String toString() {
  return 'ImportResult(selectedFiles: $selectedFiles, importedCount: $importedCount)';
}


}

/// @nodoc
abstract mixin class _$ImportResultCopyWith<$Res> implements $ImportResultCopyWith<$Res> {
  factory _$ImportResultCopyWith(_ImportResult value, $Res Function(_ImportResult) _then) = __$ImportResultCopyWithImpl;
@override @useResult
$Res call({
 List<SelectedAudioFile> selectedFiles, int importedCount
});




}
/// @nodoc
class __$ImportResultCopyWithImpl<$Res>
    implements _$ImportResultCopyWith<$Res> {
  __$ImportResultCopyWithImpl(this._self, this._then);

  final _ImportResult _self;
  final $Res Function(_ImportResult) _then;

/// Create a copy of ImportResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? selectedFiles = null,Object? importedCount = null,}) {
  return _then(_ImportResult(
selectedFiles: null == selectedFiles ? _self._selectedFiles : selectedFiles // ignore: cast_nullable_to_non_nullable
as List<SelectedAudioFile>,importedCount: null == importedCount ? _self.importedCount : importedCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$ImportWorkflowFailure {

 Object get error; StackTrace get stackTrace; ImportStage get stage; List<String> get stageHistory; String? get activeFile; List<String> get parserDiagnostics; bool get originalRemovalOnly;
/// Create a copy of ImportWorkflowFailure
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImportWorkflowFailureCopyWith<ImportWorkflowFailure> get copyWith => _$ImportWorkflowFailureCopyWithImpl<ImportWorkflowFailure>(this as ImportWorkflowFailure, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImportWorkflowFailure&&const DeepCollectionEquality().equals(other.error, error)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace)&&(identical(other.stage, stage) || other.stage == stage)&&const DeepCollectionEquality().equals(other.stageHistory, stageHistory)&&(identical(other.activeFile, activeFile) || other.activeFile == activeFile)&&const DeepCollectionEquality().equals(other.parserDiagnostics, parserDiagnostics)&&(identical(other.originalRemovalOnly, originalRemovalOnly) || other.originalRemovalOnly == originalRemovalOnly));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(error),stackTrace,stage,const DeepCollectionEquality().hash(stageHistory),activeFile,const DeepCollectionEquality().hash(parserDiagnostics),originalRemovalOnly);

@override
String toString() {
  return 'ImportWorkflowFailure(error: $error, stackTrace: $stackTrace, stage: $stage, stageHistory: $stageHistory, activeFile: $activeFile, parserDiagnostics: $parserDiagnostics, originalRemovalOnly: $originalRemovalOnly)';
}


}

/// @nodoc
abstract mixin class $ImportWorkflowFailureCopyWith<$Res>  {
  factory $ImportWorkflowFailureCopyWith(ImportWorkflowFailure value, $Res Function(ImportWorkflowFailure) _then) = _$ImportWorkflowFailureCopyWithImpl;
@useResult
$Res call({
 Object error, StackTrace stackTrace, ImportStage stage, List<String> stageHistory, String? activeFile, List<String> parserDiagnostics, bool originalRemovalOnly
});




}
/// @nodoc
class _$ImportWorkflowFailureCopyWithImpl<$Res>
    implements $ImportWorkflowFailureCopyWith<$Res> {
  _$ImportWorkflowFailureCopyWithImpl(this._self, this._then);

  final ImportWorkflowFailure _self;
  final $Res Function(ImportWorkflowFailure) _then;

/// Create a copy of ImportWorkflowFailure
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? error = null,Object? stackTrace = null,Object? stage = null,Object? stageHistory = null,Object? activeFile = freezed,Object? parserDiagnostics = null,Object? originalRemovalOnly = null,}) {
  return _then(_self.copyWith(
error: null == error ? _self.error : error ,stackTrace: null == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace,stage: null == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as ImportStage,stageHistory: null == stageHistory ? _self.stageHistory : stageHistory // ignore: cast_nullable_to_non_nullable
as List<String>,activeFile: freezed == activeFile ? _self.activeFile : activeFile // ignore: cast_nullable_to_non_nullable
as String?,parserDiagnostics: null == parserDiagnostics ? _self.parserDiagnostics : parserDiagnostics // ignore: cast_nullable_to_non_nullable
as List<String>,originalRemovalOnly: null == originalRemovalOnly ? _self.originalRemovalOnly : originalRemovalOnly // ignore: cast_nullable_to_non_nullable
as bool,
  ));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Object error,  StackTrace stackTrace,  ImportStage stage,  List<String> stageHistory,  String? activeFile,  List<String> parserDiagnostics,  bool originalRemovalOnly)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ImportWorkflowFailure() when $default != null:
return $default(_that.error,_that.stackTrace,_that.stage,_that.stageHistory,_that.activeFile,_that.parserDiagnostics,_that.originalRemovalOnly);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Object error,  StackTrace stackTrace,  ImportStage stage,  List<String> stageHistory,  String? activeFile,  List<String> parserDiagnostics,  bool originalRemovalOnly)  $default,) {final _that = this;
switch (_that) {
case _ImportWorkflowFailure():
return $default(_that.error,_that.stackTrace,_that.stage,_that.stageHistory,_that.activeFile,_that.parserDiagnostics,_that.originalRemovalOnly);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Object error,  StackTrace stackTrace,  ImportStage stage,  List<String> stageHistory,  String? activeFile,  List<String> parserDiagnostics,  bool originalRemovalOnly)?  $default,) {final _that = this;
switch (_that) {
case _ImportWorkflowFailure() when $default != null:
return $default(_that.error,_that.stackTrace,_that.stage,_that.stageHistory,_that.activeFile,_that.parserDiagnostics,_that.originalRemovalOnly);case _:
  return null;

}
}

}

/// @nodoc


class _ImportWorkflowFailure implements ImportWorkflowFailure {
  const _ImportWorkflowFailure({required this.error, required this.stackTrace, required this.stage, required final  List<String> stageHistory, this.activeFile, final  List<String> parserDiagnostics = const <String>[], this.originalRemovalOnly = false}): _stageHistory = stageHistory,_parserDiagnostics = parserDiagnostics;
  

@override final  Object error;
@override final  StackTrace stackTrace;
@override final  ImportStage stage;
 final  List<String> _stageHistory;
@override List<String> get stageHistory {
  if (_stageHistory is EqualUnmodifiableListView) return _stageHistory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_stageHistory);
}

@override final  String? activeFile;
 final  List<String> _parserDiagnostics;
@override@JsonKey() List<String> get parserDiagnostics {
  if (_parserDiagnostics is EqualUnmodifiableListView) return _parserDiagnostics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_parserDiagnostics);
}

@override@JsonKey() final  bool originalRemovalOnly;

/// Create a copy of ImportWorkflowFailure
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ImportWorkflowFailureCopyWith<_ImportWorkflowFailure> get copyWith => __$ImportWorkflowFailureCopyWithImpl<_ImportWorkflowFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ImportWorkflowFailure&&const DeepCollectionEquality().equals(other.error, error)&&(identical(other.stackTrace, stackTrace) || other.stackTrace == stackTrace)&&(identical(other.stage, stage) || other.stage == stage)&&const DeepCollectionEquality().equals(other._stageHistory, _stageHistory)&&(identical(other.activeFile, activeFile) || other.activeFile == activeFile)&&const DeepCollectionEquality().equals(other._parserDiagnostics, _parserDiagnostics)&&(identical(other.originalRemovalOnly, originalRemovalOnly) || other.originalRemovalOnly == originalRemovalOnly));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(error),stackTrace,stage,const DeepCollectionEquality().hash(_stageHistory),activeFile,const DeepCollectionEquality().hash(_parserDiagnostics),originalRemovalOnly);

@override
String toString() {
  return 'ImportWorkflowFailure(error: $error, stackTrace: $stackTrace, stage: $stage, stageHistory: $stageHistory, activeFile: $activeFile, parserDiagnostics: $parserDiagnostics, originalRemovalOnly: $originalRemovalOnly)';
}


}

/// @nodoc
abstract mixin class _$ImportWorkflowFailureCopyWith<$Res> implements $ImportWorkflowFailureCopyWith<$Res> {
  factory _$ImportWorkflowFailureCopyWith(_ImportWorkflowFailure value, $Res Function(_ImportWorkflowFailure) _then) = __$ImportWorkflowFailureCopyWithImpl;
@override @useResult
$Res call({
 Object error, StackTrace stackTrace, ImportStage stage, List<String> stageHistory, String? activeFile, List<String> parserDiagnostics, bool originalRemovalOnly
});




}
/// @nodoc
class __$ImportWorkflowFailureCopyWithImpl<$Res>
    implements _$ImportWorkflowFailureCopyWith<$Res> {
  __$ImportWorkflowFailureCopyWithImpl(this._self, this._then);

  final _ImportWorkflowFailure _self;
  final $Res Function(_ImportWorkflowFailure) _then;

/// Create a copy of ImportWorkflowFailure
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? error = null,Object? stackTrace = null,Object? stage = null,Object? stageHistory = null,Object? activeFile = freezed,Object? parserDiagnostics = null,Object? originalRemovalOnly = null,}) {
  return _then(_ImportWorkflowFailure(
error: null == error ? _self.error : error ,stackTrace: null == stackTrace ? _self.stackTrace : stackTrace // ignore: cast_nullable_to_non_nullable
as StackTrace,stage: null == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as ImportStage,stageHistory: null == stageHistory ? _self._stageHistory : stageHistory // ignore: cast_nullable_to_non_nullable
as List<String>,activeFile: freezed == activeFile ? _self.activeFile : activeFile // ignore: cast_nullable_to_non_nullable
as String?,parserDiagnostics: null == parserDiagnostics ? _self._parserDiagnostics : parserDiagnostics // ignore: cast_nullable_to_non_nullable
as List<String>,originalRemovalOnly: null == originalRemovalOnly ? _self.originalRemovalOnly : originalRemovalOnly // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
