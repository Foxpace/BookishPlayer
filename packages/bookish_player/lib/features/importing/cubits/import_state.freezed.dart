// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'import_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ImportState {

 ImportStatus get status; bool get cancellationRequested; bool get finderTransfer; List<SelectedAudioFile> get selectedFiles; ImportResult? get failureResult; ImportStage get stage; int get importedCount; int get totalFiles; String? get currentTitle; ImportHeading get heading; ImportDetail get detail; ImportStage? get failureStage; int? get copiedBytes; int? get totalBytes; double? get progress; String? get diagnostics;
/// Create a copy of ImportState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImportStateCopyWith<ImportState> get copyWith => _$ImportStateCopyWithImpl<ImportState>(this as ImportState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ImportState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImportState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.cancellationRequested, _this.cancellationRequested) || other.cancellationRequested == _this.cancellationRequested)&&(identical(other.finderTransfer, _this.finderTransfer) || other.finderTransfer == _this.finderTransfer)&&const DeepCollectionEquality().equals(other.selectedFiles, _this.selectedFiles)&&(identical(other.failureResult, _this.failureResult) || other.failureResult == _this.failureResult)&&(identical(other.stage, _this.stage) || other.stage == _this.stage)&&(identical(other.importedCount, _this.importedCount) || other.importedCount == _this.importedCount)&&(identical(other.totalFiles, _this.totalFiles) || other.totalFiles == _this.totalFiles)&&(identical(other.currentTitle, _this.currentTitle) || other.currentTitle == _this.currentTitle)&&(identical(other.heading, _this.heading) || other.heading == _this.heading)&&(identical(other.detail, _this.detail) || other.detail == _this.detail)&&(identical(other.failureStage, _this.failureStage) || other.failureStage == _this.failureStage)&&(identical(other.copiedBytes, _this.copiedBytes) || other.copiedBytes == _this.copiedBytes)&&(identical(other.totalBytes, _this.totalBytes) || other.totalBytes == _this.totalBytes)&&(identical(other.progress, _this.progress) || other.progress == _this.progress)&&(identical(other.diagnostics, _this.diagnostics) || other.diagnostics == _this.diagnostics));
}


@override
int get hashCode {
  final _this = this as ImportState;
  return Object.hash(runtimeType,_this.status,_this.cancellationRequested,_this.finderTransfer,const DeepCollectionEquality().hash(_this.selectedFiles),_this.failureResult,_this.stage,_this.importedCount,_this.totalFiles,_this.currentTitle,_this.heading,_this.detail,_this.failureStage,_this.copiedBytes,_this.totalBytes,_this.progress,_this.diagnostics);
}

@override
String toString() {
  final _this = this as ImportState;
  return 'ImportState(status: ${_this.status}, cancellationRequested: ${_this.cancellationRequested}, finderTransfer: ${_this.finderTransfer}, selectedFiles: ${_this.selectedFiles}, failureResult: ${_this.failureResult}, stage: ${_this.stage}, importedCount: ${_this.importedCount}, totalFiles: ${_this.totalFiles}, currentTitle: ${_this.currentTitle}, heading: ${_this.heading}, detail: ${_this.detail}, failureStage: ${_this.failureStage}, copiedBytes: ${_this.copiedBytes}, totalBytes: ${_this.totalBytes}, progress: ${_this.progress}, diagnostics: ${_this.diagnostics})';
}


}

/// @nodoc
abstract mixin class $ImportStateCopyWith<$Res>  {
  factory $ImportStateCopyWith(ImportState value, $Res Function(ImportState) _then) = _$ImportStateCopyWithImpl;
@useResult
$Res call({
 ImportStatus status, bool cancellationRequested, bool finderTransfer, List<SelectedAudioFile> selectedFiles, ImportResult? failureResult, ImportStage stage, int importedCount, int totalFiles, String? currentTitle, ImportHeading heading, ImportDetail detail, ImportStage? failureStage, int? copiedBytes, int? totalBytes, double? progress, String? diagnostics
});


$ImportResultCopyWith<$Res>? get failureResult;

}
/// @nodoc
class _$ImportStateCopyWithImpl<$Res>
    implements $ImportStateCopyWith<$Res> {
  _$ImportStateCopyWithImpl(this._self, this._then);

  final ImportState _self;
  final $Res Function(ImportState) _then;

/// Create a copy of ImportState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? cancellationRequested = null,Object? finderTransfer = null,Object? selectedFiles = null,Object? failureResult = freezed,Object? stage = null,Object? importedCount = null,Object? totalFiles = null,Object? currentTitle = freezed,Object? heading = null,Object? detail = null,Object? failureStage = freezed,Object? copiedBytes = freezed,Object? totalBytes = freezed,Object? progress = freezed,Object? diagnostics = freezed,}) {
  return _then(ImportState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ImportStatus,cancellationRequested: null == cancellationRequested ? _self.cancellationRequested : cancellationRequested // ignore: cast_nullable_to_non_nullable
as bool,finderTransfer: null == finderTransfer ? _self.finderTransfer : finderTransfer // ignore: cast_nullable_to_non_nullable
as bool,selectedFiles: null == selectedFiles ? _self.selectedFiles : selectedFiles // ignore: cast_nullable_to_non_nullable
as List<SelectedAudioFile>,failureResult: freezed == failureResult ? _self.failureResult : failureResult // ignore: cast_nullable_to_non_nullable
as ImportResult?,stage: null == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as ImportStage,importedCount: null == importedCount ? _self.importedCount : importedCount // ignore: cast_nullable_to_non_nullable
as int,totalFiles: null == totalFiles ? _self.totalFiles : totalFiles // ignore: cast_nullable_to_non_nullable
as int,currentTitle: freezed == currentTitle ? _self.currentTitle : currentTitle // ignore: cast_nullable_to_non_nullable
as String?,heading: null == heading ? _self.heading : heading // ignore: cast_nullable_to_non_nullable
as ImportHeading,detail: null == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as ImportDetail,failureStage: freezed == failureStage ? _self.failureStage : failureStage // ignore: cast_nullable_to_non_nullable
as ImportStage?,copiedBytes: freezed == copiedBytes ? _self.copiedBytes : copiedBytes // ignore: cast_nullable_to_non_nullable
as int?,totalBytes: freezed == totalBytes ? _self.totalBytes : totalBytes // ignore: cast_nullable_to_non_nullable
as int?,progress: freezed == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double?,diagnostics: freezed == diagnostics ? _self.diagnostics : diagnostics // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ImportState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ImportResultCopyWith<$Res>? get failureResult {
    if (_self.failureResult == null) {
    return null;
  }

  return $ImportResultCopyWith<$Res>(_self.failureResult!, (value) {
    return _then(_self.copyWith(failureResult: value));
  });
}
}


/// Adds pattern-matching-related methods to [ImportState].
extension ImportStatePatterns on ImportState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ImportState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ImportState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ImportState value)  $default,){
final _that = this;
switch (_that) {
case _ImportState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ImportState value)?  $default,){
final _that = this;
switch (_that) {
case _ImportState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ImportStatus status,  bool cancellationRequested,  bool finderTransfer,  List<SelectedAudioFile> selectedFiles,  ImportResult? failureResult,  ImportStage stage,  int importedCount,  int totalFiles,  String? currentTitle,  ImportHeading heading,  ImportDetail detail,  ImportStage? failureStage,  int? copiedBytes,  int? totalBytes,  double? progress,  String? diagnostics)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ImportState() when $default != null:
return $default(_that.status,_that.cancellationRequested,_that.finderTransfer,_that.selectedFiles,_that.failureResult,_that.stage,_that.importedCount,_that.totalFiles,_that.currentTitle,_that.heading,_that.detail,_that.failureStage,_that.copiedBytes,_that.totalBytes,_that.progress,_that.diagnostics);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ImportStatus status,  bool cancellationRequested,  bool finderTransfer,  List<SelectedAudioFile> selectedFiles,  ImportResult? failureResult,  ImportStage stage,  int importedCount,  int totalFiles,  String? currentTitle,  ImportHeading heading,  ImportDetail detail,  ImportStage? failureStage,  int? copiedBytes,  int? totalBytes,  double? progress,  String? diagnostics)  $default,) {final _that = this;
switch (_that) {
case _ImportState():
return $default(_that.status,_that.cancellationRequested,_that.finderTransfer,_that.selectedFiles,_that.failureResult,_that.stage,_that.importedCount,_that.totalFiles,_that.currentTitle,_that.heading,_that.detail,_that.failureStage,_that.copiedBytes,_that.totalBytes,_that.progress,_that.diagnostics);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ImportStatus status,  bool cancellationRequested,  bool finderTransfer,  List<SelectedAudioFile> selectedFiles,  ImportResult? failureResult,  ImportStage stage,  int importedCount,  int totalFiles,  String? currentTitle,  ImportHeading heading,  ImportDetail detail,  ImportStage? failureStage,  int? copiedBytes,  int? totalBytes,  double? progress,  String? diagnostics)?  $default,) {final _that = this;
switch (_that) {
case _ImportState() when $default != null:
return $default(_that.status,_that.cancellationRequested,_that.finderTransfer,_that.selectedFiles,_that.failureResult,_that.stage,_that.importedCount,_that.totalFiles,_that.currentTitle,_that.heading,_that.detail,_that.failureStage,_that.copiedBytes,_that.totalBytes,_that.progress,_that.diagnostics);case _:
  return null;

}
}

}

/// @nodoc


class _ImportState implements ImportState {
  const _ImportState({this.status = ImportStatus.idle, this.cancellationRequested = false, this.finderTransfer = false,  List<SelectedAudioFile> selectedFiles = const <SelectedAudioFile>[], this.failureResult, this.stage = ImportStage.selectingFiles, this.importedCount = 0, this.totalFiles = 0, this.currentTitle, this.heading = ImportHeading.openingFileBrowser, this.detail = ImportDetail.chooseFiles, this.failureStage, this.copiedBytes, this.totalBytes, this.progress, this.diagnostics}): _selectedFiles = selectedFiles;
  

@override@JsonKey() final  ImportStatus status;
@override@JsonKey() final  bool cancellationRequested;
@override@JsonKey() final  bool finderTransfer;
 final  List<SelectedAudioFile> _selectedFiles;
@override@JsonKey() List<SelectedAudioFile> get selectedFiles {
  if (_selectedFiles is EqualUnmodifiableListView) return _selectedFiles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_selectedFiles);
}

@override final  ImportResult? failureResult;
@override@JsonKey() final  ImportStage stage;
@override@JsonKey() final  int importedCount;
@override@JsonKey() final  int totalFiles;
@override final  String? currentTitle;
@override@JsonKey() final  ImportHeading heading;
@override@JsonKey() final  ImportDetail detail;
@override final  ImportStage? failureStage;
@override final  int? copiedBytes;
@override final  int? totalBytes;
@override final  double? progress;
@override final  String? diagnostics;

/// Create a copy of ImportState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ImportStateCopyWith<_ImportState> get copyWith => __$ImportStateCopyWithImpl<_ImportState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ImportState&&(identical(other.status, status) || other.status == status)&&(identical(other.cancellationRequested, cancellationRequested) || other.cancellationRequested == cancellationRequested)&&(identical(other.finderTransfer, finderTransfer) || other.finderTransfer == finderTransfer)&&const DeepCollectionEquality().equals(other.selectedFiles, _selectedFiles)&&(identical(other.failureResult, failureResult) || other.failureResult == failureResult)&&(identical(other.stage, stage) || other.stage == stage)&&(identical(other.importedCount, importedCount) || other.importedCount == importedCount)&&(identical(other.totalFiles, totalFiles) || other.totalFiles == totalFiles)&&(identical(other.currentTitle, currentTitle) || other.currentTitle == currentTitle)&&(identical(other.heading, heading) || other.heading == heading)&&(identical(other.detail, detail) || other.detail == detail)&&(identical(other.failureStage, failureStage) || other.failureStage == failureStage)&&(identical(other.copiedBytes, copiedBytes) || other.copiedBytes == copiedBytes)&&(identical(other.totalBytes, totalBytes) || other.totalBytes == totalBytes)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.diagnostics, diagnostics) || other.diagnostics == diagnostics));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,cancellationRequested,finderTransfer,const DeepCollectionEquality().hash(_selectedFiles),failureResult,stage,importedCount,totalFiles,currentTitle,heading,detail,failureStage,copiedBytes,totalBytes,progress,diagnostics);
}

@override
String toString() {
    return 'ImportState(status: $status, cancellationRequested: $cancellationRequested, finderTransfer: $finderTransfer, selectedFiles: $selectedFiles, failureResult: $failureResult, stage: $stage, importedCount: $importedCount, totalFiles: $totalFiles, currentTitle: $currentTitle, heading: $heading, detail: $detail, failureStage: $failureStage, copiedBytes: $copiedBytes, totalBytes: $totalBytes, progress: $progress, diagnostics: $diagnostics)';
}


}

/// @nodoc
abstract mixin class _$ImportStateCopyWith<$Res> implements $ImportStateCopyWith<$Res> {
  factory _$ImportStateCopyWith(_ImportState value, $Res Function(_ImportState) _then) = __$ImportStateCopyWithImpl;
@override @useResult
$Res call({
 ImportStatus status, bool cancellationRequested, bool finderTransfer, List<SelectedAudioFile> selectedFiles, ImportResult? failureResult, ImportStage stage, int importedCount, int totalFiles, String? currentTitle, ImportHeading heading, ImportDetail detail, ImportStage? failureStage, int? copiedBytes, int? totalBytes, double? progress, String? diagnostics
});


@override $ImportResultCopyWith<$Res>? get failureResult;

}
/// @nodoc
class __$ImportStateCopyWithImpl<$Res>
    implements _$ImportStateCopyWith<$Res> {
  __$ImportStateCopyWithImpl(this._self, this._then);

  final _ImportState _self;
  final $Res Function(_ImportState) _then;

/// Create a copy of ImportState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? cancellationRequested = null,Object? finderTransfer = null,Object? selectedFiles = null,Object? failureResult = freezed,Object? stage = null,Object? importedCount = null,Object? totalFiles = null,Object? currentTitle = freezed,Object? heading = null,Object? detail = null,Object? failureStage = freezed,Object? copiedBytes = freezed,Object? totalBytes = freezed,Object? progress = freezed,Object? diagnostics = freezed,}) {
  return _then(_ImportState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ImportStatus,cancellationRequested: null == cancellationRequested ? _self.cancellationRequested : cancellationRequested // ignore: cast_nullable_to_non_nullable
as bool,finderTransfer: null == finderTransfer ? _self.finderTransfer : finderTransfer // ignore: cast_nullable_to_non_nullable
as bool,selectedFiles: null == selectedFiles ? _self._selectedFiles : selectedFiles // ignore: cast_nullable_to_non_nullable
as List<SelectedAudioFile>,failureResult: freezed == failureResult ? _self.failureResult : failureResult // ignore: cast_nullable_to_non_nullable
as ImportResult?,stage: null == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as ImportStage,importedCount: null == importedCount ? _self.importedCount : importedCount // ignore: cast_nullable_to_non_nullable
as int,totalFiles: null == totalFiles ? _self.totalFiles : totalFiles // ignore: cast_nullable_to_non_nullable
as int,currentTitle: freezed == currentTitle ? _self.currentTitle : currentTitle // ignore: cast_nullable_to_non_nullable
as String?,heading: null == heading ? _self.heading : heading // ignore: cast_nullable_to_non_nullable
as ImportHeading,detail: null == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as ImportDetail,failureStage: freezed == failureStage ? _self.failureStage : failureStage // ignore: cast_nullable_to_non_nullable
as ImportStage?,copiedBytes: freezed == copiedBytes ? _self.copiedBytes : copiedBytes // ignore: cast_nullable_to_non_nullable
as int?,totalBytes: freezed == totalBytes ? _self.totalBytes : totalBytes // ignore: cast_nullable_to_non_nullable
as int?,progress: freezed == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double?,diagnostics: freezed == diagnostics ? _self.diagnostics : diagnostics // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ImportState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ImportResultCopyWith<$Res>? get failureResult {
    if (_self.failureResult == null) {
    return null;
  }

  return $ImportResultCopyWith<$Res>(_self.failureResult!, (value) {
    return _then(_self.copyWith(failureResult: value));
  });
}
}

// dart format on
