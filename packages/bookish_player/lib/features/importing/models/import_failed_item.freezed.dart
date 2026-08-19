// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'import_failed_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ImportFailedItem {

 String get displayName; ImportStage get stage; ImportFailureKind get kind;
/// Create a copy of ImportFailedItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImportFailedItemCopyWith<ImportFailedItem> get copyWith => _$ImportFailedItemCopyWithImpl<ImportFailedItem>(this as ImportFailedItem, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImportFailedItem&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.stage, stage) || other.stage == stage)&&(identical(other.kind, kind) || other.kind == kind));
}


@override
int get hashCode => Object.hash(runtimeType,displayName,stage,kind);

@override
String toString() {
  return 'ImportFailedItem(displayName: $displayName, stage: $stage, kind: $kind)';
}


}

/// @nodoc
abstract mixin class $ImportFailedItemCopyWith<$Res>  {
  factory $ImportFailedItemCopyWith(ImportFailedItem value, $Res Function(ImportFailedItem) _then) = _$ImportFailedItemCopyWithImpl;
@useResult
$Res call({
 String displayName, ImportStage stage, ImportFailureKind kind
});




}
/// @nodoc
class _$ImportFailedItemCopyWithImpl<$Res>
    implements $ImportFailedItemCopyWith<$Res> {
  _$ImportFailedItemCopyWithImpl(this._self, this._then);

  final ImportFailedItem _self;
  final $Res Function(ImportFailedItem) _then;

/// Create a copy of ImportFailedItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? displayName = null,Object? stage = null,Object? kind = null,}) {
  return _then(_self.copyWith(
displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,stage: null == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as ImportStage,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as ImportFailureKind,
  ));
}

}


/// Adds pattern-matching-related methods to [ImportFailedItem].
extension ImportFailedItemPatterns on ImportFailedItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ImportFailedItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ImportFailedItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ImportFailedItem value)  $default,){
final _that = this;
switch (_that) {
case _ImportFailedItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ImportFailedItem value)?  $default,){
final _that = this;
switch (_that) {
case _ImportFailedItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String displayName,  ImportStage stage,  ImportFailureKind kind)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ImportFailedItem() when $default != null:
return $default(_that.displayName,_that.stage,_that.kind);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String displayName,  ImportStage stage,  ImportFailureKind kind)  $default,) {final _that = this;
switch (_that) {
case _ImportFailedItem():
return $default(_that.displayName,_that.stage,_that.kind);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String displayName,  ImportStage stage,  ImportFailureKind kind)?  $default,) {final _that = this;
switch (_that) {
case _ImportFailedItem() when $default != null:
return $default(_that.displayName,_that.stage,_that.kind);case _:
  return null;

}
}

}

/// @nodoc


class _ImportFailedItem implements ImportFailedItem {
  const _ImportFailedItem({required this.displayName, required this.stage, required this.kind});
  

@override final  String displayName;
@override final  ImportStage stage;
@override final  ImportFailureKind kind;

/// Create a copy of ImportFailedItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ImportFailedItemCopyWith<_ImportFailedItem> get copyWith => __$ImportFailedItemCopyWithImpl<_ImportFailedItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ImportFailedItem&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.stage, stage) || other.stage == stage)&&(identical(other.kind, kind) || other.kind == kind));
}


@override
int get hashCode => Object.hash(runtimeType,displayName,stage,kind);

@override
String toString() {
  return 'ImportFailedItem(displayName: $displayName, stage: $stage, kind: $kind)';
}


}

/// @nodoc
abstract mixin class _$ImportFailedItemCopyWith<$Res> implements $ImportFailedItemCopyWith<$Res> {
  factory _$ImportFailedItemCopyWith(_ImportFailedItem value, $Res Function(_ImportFailedItem) _then) = __$ImportFailedItemCopyWithImpl;
@override @useResult
$Res call({
 String displayName, ImportStage stage, ImportFailureKind kind
});




}
/// @nodoc
class __$ImportFailedItemCopyWithImpl<$Res>
    implements _$ImportFailedItemCopyWith<$Res> {
  __$ImportFailedItemCopyWithImpl(this._self, this._then);

  final _ImportFailedItem _self;
  final $Res Function(_ImportFailedItem) _then;

/// Create a copy of ImportFailedItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? displayName = null,Object? stage = null,Object? kind = null,}) {
  return _then(_ImportFailedItem(
displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,stage: null == stage ? _self.stage : stage // ignore: cast_nullable_to_non_nullable
as ImportStage,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as ImportFailureKind,
  ));
}


}

// dart format on
