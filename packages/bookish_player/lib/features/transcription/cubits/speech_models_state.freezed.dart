// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'speech_models_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SpeechModelsState {

 SpeechModelsStatus get status; List<SpeechModel> get models; String get selectedModel; double? get downloadProgress; AppMessage? get message; int get effectRevision;
/// Create a copy of SpeechModelsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpeechModelsStateCopyWith<SpeechModelsState> get copyWith => _$SpeechModelsStateCopyWithImpl<SpeechModelsState>(this as SpeechModelsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpeechModelsState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.models, models)&&(identical(other.selectedModel, selectedModel) || other.selectedModel == selectedModel)&&(identical(other.downloadProgress, downloadProgress) || other.downloadProgress == downloadProgress)&&(identical(other.message, message) || other.message == message)&&(identical(other.effectRevision, effectRevision) || other.effectRevision == effectRevision));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(models),selectedModel,downloadProgress,message,effectRevision);

@override
String toString() {
  return 'SpeechModelsState(status: $status, models: $models, selectedModel: $selectedModel, downloadProgress: $downloadProgress, message: $message, effectRevision: $effectRevision)';
}


}

/// @nodoc
abstract mixin class $SpeechModelsStateCopyWith<$Res>  {
  factory $SpeechModelsStateCopyWith(SpeechModelsState value, $Res Function(SpeechModelsState) _then) = _$SpeechModelsStateCopyWithImpl;
@useResult
$Res call({
 SpeechModelsStatus status, List<SpeechModel> models, String selectedModel, double? downloadProgress, AppMessage? message, int effectRevision
});




}
/// @nodoc
class _$SpeechModelsStateCopyWithImpl<$Res>
    implements $SpeechModelsStateCopyWith<$Res> {
  _$SpeechModelsStateCopyWithImpl(this._self, this._then);

  final SpeechModelsState _self;
  final $Res Function(SpeechModelsState) _then;

/// Create a copy of SpeechModelsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? models = null,Object? selectedModel = null,Object? downloadProgress = freezed,Object? message = freezed,Object? effectRevision = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SpeechModelsStatus,models: null == models ? _self.models : models // ignore: cast_nullable_to_non_nullable
as List<SpeechModel>,selectedModel: null == selectedModel ? _self.selectedModel : selectedModel // ignore: cast_nullable_to_non_nullable
as String,downloadProgress: freezed == downloadProgress ? _self.downloadProgress : downloadProgress // ignore: cast_nullable_to_non_nullable
as double?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as AppMessage?,effectRevision: null == effectRevision ? _self.effectRevision : effectRevision // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SpeechModelsState].
extension SpeechModelsStatePatterns on SpeechModelsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SpeechModelsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SpeechModelsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SpeechModelsState value)  $default,){
final _that = this;
switch (_that) {
case _SpeechModelsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SpeechModelsState value)?  $default,){
final _that = this;
switch (_that) {
case _SpeechModelsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SpeechModelsStatus status,  List<SpeechModel> models,  String selectedModel,  double? downloadProgress,  AppMessage? message,  int effectRevision)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SpeechModelsState() when $default != null:
return $default(_that.status,_that.models,_that.selectedModel,_that.downloadProgress,_that.message,_that.effectRevision);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SpeechModelsStatus status,  List<SpeechModel> models,  String selectedModel,  double? downloadProgress,  AppMessage? message,  int effectRevision)  $default,) {final _that = this;
switch (_that) {
case _SpeechModelsState():
return $default(_that.status,_that.models,_that.selectedModel,_that.downloadProgress,_that.message,_that.effectRevision);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SpeechModelsStatus status,  List<SpeechModel> models,  String selectedModel,  double? downloadProgress,  AppMessage? message,  int effectRevision)?  $default,) {final _that = this;
switch (_that) {
case _SpeechModelsState() when $default != null:
return $default(_that.status,_that.models,_that.selectedModel,_that.downloadProgress,_that.message,_that.effectRevision);case _:
  return null;

}
}

}

/// @nodoc


class _SpeechModelsState extends SpeechModelsState {
  const _SpeechModelsState({this.status = SpeechModelsStatus.initial, final  List<SpeechModel> models = const <SpeechModel>[], this.selectedModel = 'whisper-tiny', this.downloadProgress, this.message, this.effectRevision = 0}): _models = models,super._();
  

@override@JsonKey() final  SpeechModelsStatus status;
 final  List<SpeechModel> _models;
@override@JsonKey() List<SpeechModel> get models {
  if (_models is EqualUnmodifiableListView) return _models;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_models);
}

@override@JsonKey() final  String selectedModel;
@override final  double? downloadProgress;
@override final  AppMessage? message;
@override@JsonKey() final  int effectRevision;

/// Create a copy of SpeechModelsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SpeechModelsStateCopyWith<_SpeechModelsState> get copyWith => __$SpeechModelsStateCopyWithImpl<_SpeechModelsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SpeechModelsState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._models, _models)&&(identical(other.selectedModel, selectedModel) || other.selectedModel == selectedModel)&&(identical(other.downloadProgress, downloadProgress) || other.downloadProgress == downloadProgress)&&(identical(other.message, message) || other.message == message)&&(identical(other.effectRevision, effectRevision) || other.effectRevision == effectRevision));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_models),selectedModel,downloadProgress,message,effectRevision);

@override
String toString() {
  return 'SpeechModelsState(status: $status, models: $models, selectedModel: $selectedModel, downloadProgress: $downloadProgress, message: $message, effectRevision: $effectRevision)';
}


}

/// @nodoc
abstract mixin class _$SpeechModelsStateCopyWith<$Res> implements $SpeechModelsStateCopyWith<$Res> {
  factory _$SpeechModelsStateCopyWith(_SpeechModelsState value, $Res Function(_SpeechModelsState) _then) = __$SpeechModelsStateCopyWithImpl;
@override @useResult
$Res call({
 SpeechModelsStatus status, List<SpeechModel> models, String selectedModel, double? downloadProgress, AppMessage? message, int effectRevision
});




}
/// @nodoc
class __$SpeechModelsStateCopyWithImpl<$Res>
    implements _$SpeechModelsStateCopyWith<$Res> {
  __$SpeechModelsStateCopyWithImpl(this._self, this._then);

  final _SpeechModelsState _self;
  final $Res Function(_SpeechModelsState) _then;

/// Create a copy of SpeechModelsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? models = null,Object? selectedModel = null,Object? downloadProgress = freezed,Object? message = freezed,Object? effectRevision = null,}) {
  return _then(_SpeechModelsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SpeechModelsStatus,models: null == models ? _self._models : models // ignore: cast_nullable_to_non_nullable
as List<SpeechModel>,selectedModel: null == selectedModel ? _self.selectedModel : selectedModel // ignore: cast_nullable_to_non_nullable
as String,downloadProgress: freezed == downloadProgress ? _self.downloadProgress : downloadProgress // ignore: cast_nullable_to_non_nullable
as double?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as AppMessage?,effectRevision: null == effectRevision ? _self.effectRevision : effectRevision // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
