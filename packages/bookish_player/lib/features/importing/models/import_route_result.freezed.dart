// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'import_route_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ImportRouteResult {

 ImportRouteStatus get status; int get importedCount; ImportFailedItem? get failedItem;
/// Create a copy of ImportRouteResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImportRouteResultCopyWith<ImportRouteResult> get copyWith => _$ImportRouteResultCopyWithImpl<ImportRouteResult>(this as ImportRouteResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImportRouteResult&&(identical(other.status, status) || other.status == status)&&(identical(other.importedCount, importedCount) || other.importedCount == importedCount)&&(identical(other.failedItem, failedItem) || other.failedItem == failedItem));
}


@override
int get hashCode => Object.hash(runtimeType,status,importedCount,failedItem);

@override
String toString() {
  return 'ImportRouteResult(status: $status, importedCount: $importedCount, failedItem: $failedItem)';
}


}

/// @nodoc
abstract mixin class $ImportRouteResultCopyWith<$Res>  {
  factory $ImportRouteResultCopyWith(ImportRouteResult value, $Res Function(ImportRouteResult) _then) = _$ImportRouteResultCopyWithImpl;
@useResult
$Res call({
 ImportRouteStatus status, int importedCount, ImportFailedItem? failedItem
});


$ImportFailedItemCopyWith<$Res>? get failedItem;

}
/// @nodoc
class _$ImportRouteResultCopyWithImpl<$Res>
    implements $ImportRouteResultCopyWith<$Res> {
  _$ImportRouteResultCopyWithImpl(this._self, this._then);

  final ImportRouteResult _self;
  final $Res Function(ImportRouteResult) _then;

/// Create a copy of ImportRouteResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? importedCount = null,Object? failedItem = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ImportRouteStatus,importedCount: null == importedCount ? _self.importedCount : importedCount // ignore: cast_nullable_to_non_nullable
as int,failedItem: freezed == failedItem ? _self.failedItem : failedItem // ignore: cast_nullable_to_non_nullable
as ImportFailedItem?,
  ));
}
/// Create a copy of ImportRouteResult
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


/// Adds pattern-matching-related methods to [ImportRouteResult].
extension ImportRouteResultPatterns on ImportRouteResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ImportRouteResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ImportRouteResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ImportRouteResult value)  $default,){
final _that = this;
switch (_that) {
case _ImportRouteResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ImportRouteResult value)?  $default,){
final _that = this;
switch (_that) {
case _ImportRouteResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ImportRouteStatus status,  int importedCount,  ImportFailedItem? failedItem)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ImportRouteResult() when $default != null:
return $default(_that.status,_that.importedCount,_that.failedItem);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ImportRouteStatus status,  int importedCount,  ImportFailedItem? failedItem)  $default,) {final _that = this;
switch (_that) {
case _ImportRouteResult():
return $default(_that.status,_that.importedCount,_that.failedItem);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ImportRouteStatus status,  int importedCount,  ImportFailedItem? failedItem)?  $default,) {final _that = this;
switch (_that) {
case _ImportRouteResult() when $default != null:
return $default(_that.status,_that.importedCount,_that.failedItem);case _:
  return null;

}
}

}

/// @nodoc


class _ImportRouteResult implements ImportRouteResult {
  const _ImportRouteResult({required this.status, required this.importedCount, this.failedItem});
  

@override final  ImportRouteStatus status;
@override final  int importedCount;
@override final  ImportFailedItem? failedItem;

/// Create a copy of ImportRouteResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ImportRouteResultCopyWith<_ImportRouteResult> get copyWith => __$ImportRouteResultCopyWithImpl<_ImportRouteResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ImportRouteResult&&(identical(other.status, status) || other.status == status)&&(identical(other.importedCount, importedCount) || other.importedCount == importedCount)&&(identical(other.failedItem, failedItem) || other.failedItem == failedItem));
}


@override
int get hashCode => Object.hash(runtimeType,status,importedCount,failedItem);

@override
String toString() {
  return 'ImportRouteResult(status: $status, importedCount: $importedCount, failedItem: $failedItem)';
}


}

/// @nodoc
abstract mixin class _$ImportRouteResultCopyWith<$Res> implements $ImportRouteResultCopyWith<$Res> {
  factory _$ImportRouteResultCopyWith(_ImportRouteResult value, $Res Function(_ImportRouteResult) _then) = __$ImportRouteResultCopyWithImpl;
@override @useResult
$Res call({
 ImportRouteStatus status, int importedCount, ImportFailedItem? failedItem
});


@override $ImportFailedItemCopyWith<$Res>? get failedItem;

}
/// @nodoc
class __$ImportRouteResultCopyWithImpl<$Res>
    implements _$ImportRouteResultCopyWith<$Res> {
  __$ImportRouteResultCopyWithImpl(this._self, this._then);

  final _ImportRouteResult _self;
  final $Res Function(_ImportRouteResult) _then;

/// Create a copy of ImportRouteResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? importedCount = null,Object? failedItem = freezed,}) {
  return _then(_ImportRouteResult(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ImportRouteStatus,importedCount: null == importedCount ? _self.importedCount : importedCount // ignore: cast_nullable_to_non_nullable
as int,failedItem: freezed == failedItem ? _self.failedItem : failedItem // ignore: cast_nullable_to_non_nullable
as ImportFailedItem?,
  ));
}

/// Create a copy of ImportRouteResult
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
