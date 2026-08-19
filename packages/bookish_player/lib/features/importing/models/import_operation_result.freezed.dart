// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'import_operation_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ImportOperationResult {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImportOperationResult);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ImportOperationResult()';
}


}

/// @nodoc
class $ImportOperationResultCopyWith<$Res>  {
$ImportOperationResultCopyWith(ImportOperationResult _, $Res Function(ImportOperationResult) __);
}


/// Adds pattern-matching-related methods to [ImportOperationResult].
extension ImportOperationResultPatterns on ImportOperationResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ImportOperationCompleted value)?  completed,TResult Function( ImportOperationCancelled value)?  cancelled,TResult Function( ImportOperationFailed value)?  failed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ImportOperationCompleted() when completed != null:
return completed(_that);case ImportOperationCancelled() when cancelled != null:
return cancelled(_that);case ImportOperationFailed() when failed != null:
return failed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ImportOperationCompleted value)  completed,required TResult Function( ImportOperationCancelled value)  cancelled,required TResult Function( ImportOperationFailed value)  failed,}){
final _that = this;
switch (_that) {
case ImportOperationCompleted():
return completed(_that);case ImportOperationCancelled():
return cancelled(_that);case ImportOperationFailed():
return failed(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ImportOperationCompleted value)?  completed,TResult? Function( ImportOperationCancelled value)?  cancelled,TResult? Function( ImportOperationFailed value)?  failed,}){
final _that = this;
switch (_that) {
case ImportOperationCompleted() when completed != null:
return completed(_that);case ImportOperationCancelled() when cancelled != null:
return cancelled(_that);case ImportOperationFailed() when failed != null:
return failed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( ImportResult result)?  completed,TResult Function( ImportWorkflowCancellation cancellation)?  cancelled,TResult Function( ImportWorkflowFailure failure)?  failed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ImportOperationCompleted() when completed != null:
return completed(_that.result);case ImportOperationCancelled() when cancelled != null:
return cancelled(_that.cancellation);case ImportOperationFailed() when failed != null:
return failed(_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( ImportResult result)  completed,required TResult Function( ImportWorkflowCancellation cancellation)  cancelled,required TResult Function( ImportWorkflowFailure failure)  failed,}) {final _that = this;
switch (_that) {
case ImportOperationCompleted():
return completed(_that.result);case ImportOperationCancelled():
return cancelled(_that.cancellation);case ImportOperationFailed():
return failed(_that.failure);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( ImportResult result)?  completed,TResult? Function( ImportWorkflowCancellation cancellation)?  cancelled,TResult? Function( ImportWorkflowFailure failure)?  failed,}) {final _that = this;
switch (_that) {
case ImportOperationCompleted() when completed != null:
return completed(_that.result);case ImportOperationCancelled() when cancelled != null:
return cancelled(_that.cancellation);case ImportOperationFailed() when failed != null:
return failed(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class ImportOperationCompleted implements ImportOperationResult {
  const ImportOperationCompleted(this.result);
  

 final  ImportResult result;

/// Create a copy of ImportOperationResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImportOperationCompletedCopyWith<ImportOperationCompleted> get copyWith => _$ImportOperationCompletedCopyWithImpl<ImportOperationCompleted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImportOperationCompleted&&(identical(other.result, result) || other.result == result));
}


@override
int get hashCode => Object.hash(runtimeType,result);

@override
String toString() {
  return 'ImportOperationResult.completed(result: $result)';
}


}

/// @nodoc
abstract mixin class $ImportOperationCompletedCopyWith<$Res> implements $ImportOperationResultCopyWith<$Res> {
  factory $ImportOperationCompletedCopyWith(ImportOperationCompleted value, $Res Function(ImportOperationCompleted) _then) = _$ImportOperationCompletedCopyWithImpl;
@useResult
$Res call({
 ImportResult result
});


$ImportResultCopyWith<$Res> get result;

}
/// @nodoc
class _$ImportOperationCompletedCopyWithImpl<$Res>
    implements $ImportOperationCompletedCopyWith<$Res> {
  _$ImportOperationCompletedCopyWithImpl(this._self, this._then);

  final ImportOperationCompleted _self;
  final $Res Function(ImportOperationCompleted) _then;

/// Create a copy of ImportOperationResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? result = null,}) {
  return _then(ImportOperationCompleted(
null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as ImportResult,
  ));
}

/// Create a copy of ImportOperationResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ImportResultCopyWith<$Res> get result {
  
  return $ImportResultCopyWith<$Res>(_self.result, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}

/// @nodoc


class ImportOperationCancelled implements ImportOperationResult {
  const ImportOperationCancelled(this.cancellation);
  

 final  ImportWorkflowCancellation cancellation;

/// Create a copy of ImportOperationResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImportOperationCancelledCopyWith<ImportOperationCancelled> get copyWith => _$ImportOperationCancelledCopyWithImpl<ImportOperationCancelled>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImportOperationCancelled&&(identical(other.cancellation, cancellation) || other.cancellation == cancellation));
}


@override
int get hashCode => Object.hash(runtimeType,cancellation);

@override
String toString() {
  return 'ImportOperationResult.cancelled(cancellation: $cancellation)';
}


}

/// @nodoc
abstract mixin class $ImportOperationCancelledCopyWith<$Res> implements $ImportOperationResultCopyWith<$Res> {
  factory $ImportOperationCancelledCopyWith(ImportOperationCancelled value, $Res Function(ImportOperationCancelled) _then) = _$ImportOperationCancelledCopyWithImpl;
@useResult
$Res call({
 ImportWorkflowCancellation cancellation
});


$ImportWorkflowCancellationCopyWith<$Res> get cancellation;

}
/// @nodoc
class _$ImportOperationCancelledCopyWithImpl<$Res>
    implements $ImportOperationCancelledCopyWith<$Res> {
  _$ImportOperationCancelledCopyWithImpl(this._self, this._then);

  final ImportOperationCancelled _self;
  final $Res Function(ImportOperationCancelled) _then;

/// Create a copy of ImportOperationResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? cancellation = null,}) {
  return _then(ImportOperationCancelled(
null == cancellation ? _self.cancellation : cancellation // ignore: cast_nullable_to_non_nullable
as ImportWorkflowCancellation,
  ));
}

/// Create a copy of ImportOperationResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ImportWorkflowCancellationCopyWith<$Res> get cancellation {
  
  return $ImportWorkflowCancellationCopyWith<$Res>(_self.cancellation, (value) {
    return _then(_self.copyWith(cancellation: value));
  });
}
}

/// @nodoc


class ImportOperationFailed implements ImportOperationResult {
  const ImportOperationFailed(this.failure);
  

 final  ImportWorkflowFailure failure;

/// Create a copy of ImportOperationResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImportOperationFailedCopyWith<ImportOperationFailed> get copyWith => _$ImportOperationFailedCopyWithImpl<ImportOperationFailed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImportOperationFailed&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'ImportOperationResult.failed(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $ImportOperationFailedCopyWith<$Res> implements $ImportOperationResultCopyWith<$Res> {
  factory $ImportOperationFailedCopyWith(ImportOperationFailed value, $Res Function(ImportOperationFailed) _then) = _$ImportOperationFailedCopyWithImpl;
@useResult
$Res call({
 ImportWorkflowFailure failure
});


$ImportWorkflowFailureCopyWith<$Res> get failure;

}
/// @nodoc
class _$ImportOperationFailedCopyWithImpl<$Res>
    implements $ImportOperationFailedCopyWith<$Res> {
  _$ImportOperationFailedCopyWithImpl(this._self, this._then);

  final ImportOperationFailed _self;
  final $Res Function(ImportOperationFailed) _then;

/// Create a copy of ImportOperationResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(ImportOperationFailed(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as ImportWorkflowFailure,
  ));
}

/// Create a copy of ImportOperationResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ImportWorkflowFailureCopyWith<$Res> get failure {
  
  return $ImportWorkflowFailureCopyWith<$Res>(_self.failure, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}

// dart format on
