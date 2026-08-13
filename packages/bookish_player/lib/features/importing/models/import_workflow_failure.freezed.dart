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
