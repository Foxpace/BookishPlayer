// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'storage_report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StorageReport {

 int get managedBytes; int get reclaimableBytes; List<String> get missingBookIds; List<List<String>> get duplicateBookIds; List<String> get orphanPaths;
/// Create a copy of StorageReport
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StorageReportCopyWith<StorageReport> get copyWith => _$StorageReportCopyWithImpl<StorageReport>(this as StorageReport, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StorageReport&&(identical(other.managedBytes, managedBytes) || other.managedBytes == managedBytes)&&(identical(other.reclaimableBytes, reclaimableBytes) || other.reclaimableBytes == reclaimableBytes)&&const DeepCollectionEquality().equals(other.missingBookIds, missingBookIds)&&const DeepCollectionEquality().equals(other.duplicateBookIds, duplicateBookIds)&&const DeepCollectionEquality().equals(other.orphanPaths, orphanPaths));
}


@override
int get hashCode => Object.hash(runtimeType,managedBytes,reclaimableBytes,const DeepCollectionEquality().hash(missingBookIds),const DeepCollectionEquality().hash(duplicateBookIds),const DeepCollectionEquality().hash(orphanPaths));

@override
String toString() {
  return 'StorageReport(managedBytes: $managedBytes, reclaimableBytes: $reclaimableBytes, missingBookIds: $missingBookIds, duplicateBookIds: $duplicateBookIds, orphanPaths: $orphanPaths)';
}


}

/// @nodoc
abstract mixin class $StorageReportCopyWith<$Res>  {
  factory $StorageReportCopyWith(StorageReport value, $Res Function(StorageReport) _then) = _$StorageReportCopyWithImpl;
@useResult
$Res call({
 int managedBytes, int reclaimableBytes, List<String> missingBookIds, List<List<String>> duplicateBookIds, List<String> orphanPaths
});




}
/// @nodoc
class _$StorageReportCopyWithImpl<$Res>
    implements $StorageReportCopyWith<$Res> {
  _$StorageReportCopyWithImpl(this._self, this._then);

  final StorageReport _self;
  final $Res Function(StorageReport) _then;

/// Create a copy of StorageReport
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? managedBytes = null,Object? reclaimableBytes = null,Object? missingBookIds = null,Object? duplicateBookIds = null,Object? orphanPaths = null,}) {
  return _then(_self.copyWith(
managedBytes: null == managedBytes ? _self.managedBytes : managedBytes // ignore: cast_nullable_to_non_nullable
as int,reclaimableBytes: null == reclaimableBytes ? _self.reclaimableBytes : reclaimableBytes // ignore: cast_nullable_to_non_nullable
as int,missingBookIds: null == missingBookIds ? _self.missingBookIds : missingBookIds // ignore: cast_nullable_to_non_nullable
as List<String>,duplicateBookIds: null == duplicateBookIds ? _self.duplicateBookIds : duplicateBookIds // ignore: cast_nullable_to_non_nullable
as List<List<String>>,orphanPaths: null == orphanPaths ? _self.orphanPaths : orphanPaths // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [StorageReport].
extension StorageReportPatterns on StorageReport {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StorageReport value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StorageReport() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StorageReport value)  $default,){
final _that = this;
switch (_that) {
case _StorageReport():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StorageReport value)?  $default,){
final _that = this;
switch (_that) {
case _StorageReport() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int managedBytes,  int reclaimableBytes,  List<String> missingBookIds,  List<List<String>> duplicateBookIds,  List<String> orphanPaths)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StorageReport() when $default != null:
return $default(_that.managedBytes,_that.reclaimableBytes,_that.missingBookIds,_that.duplicateBookIds,_that.orphanPaths);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int managedBytes,  int reclaimableBytes,  List<String> missingBookIds,  List<List<String>> duplicateBookIds,  List<String> orphanPaths)  $default,) {final _that = this;
switch (_that) {
case _StorageReport():
return $default(_that.managedBytes,_that.reclaimableBytes,_that.missingBookIds,_that.duplicateBookIds,_that.orphanPaths);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int managedBytes,  int reclaimableBytes,  List<String> missingBookIds,  List<List<String>> duplicateBookIds,  List<String> orphanPaths)?  $default,) {final _that = this;
switch (_that) {
case _StorageReport() when $default != null:
return $default(_that.managedBytes,_that.reclaimableBytes,_that.missingBookIds,_that.duplicateBookIds,_that.orphanPaths);case _:
  return null;

}
}

}

/// @nodoc


class _StorageReport implements StorageReport {
  const _StorageReport({this.managedBytes = 0, this.reclaimableBytes = 0, final  List<String> missingBookIds = const <String>[], final  List<List<String>> duplicateBookIds = const <List<String>>[], final  List<String> orphanPaths = const <String>[]}): _missingBookIds = missingBookIds,_duplicateBookIds = duplicateBookIds,_orphanPaths = orphanPaths;
  

@override@JsonKey() final  int managedBytes;
@override@JsonKey() final  int reclaimableBytes;
 final  List<String> _missingBookIds;
@override@JsonKey() List<String> get missingBookIds {
  if (_missingBookIds is EqualUnmodifiableListView) return _missingBookIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_missingBookIds);
}

 final  List<List<String>> _duplicateBookIds;
@override@JsonKey() List<List<String>> get duplicateBookIds {
  if (_duplicateBookIds is EqualUnmodifiableListView) return _duplicateBookIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_duplicateBookIds);
}

 final  List<String> _orphanPaths;
@override@JsonKey() List<String> get orphanPaths {
  if (_orphanPaths is EqualUnmodifiableListView) return _orphanPaths;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_orphanPaths);
}


/// Create a copy of StorageReport
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StorageReportCopyWith<_StorageReport> get copyWith => __$StorageReportCopyWithImpl<_StorageReport>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StorageReport&&(identical(other.managedBytes, managedBytes) || other.managedBytes == managedBytes)&&(identical(other.reclaimableBytes, reclaimableBytes) || other.reclaimableBytes == reclaimableBytes)&&const DeepCollectionEquality().equals(other._missingBookIds, _missingBookIds)&&const DeepCollectionEquality().equals(other._duplicateBookIds, _duplicateBookIds)&&const DeepCollectionEquality().equals(other._orphanPaths, _orphanPaths));
}


@override
int get hashCode => Object.hash(runtimeType,managedBytes,reclaimableBytes,const DeepCollectionEquality().hash(_missingBookIds),const DeepCollectionEquality().hash(_duplicateBookIds),const DeepCollectionEquality().hash(_orphanPaths));

@override
String toString() {
  return 'StorageReport(managedBytes: $managedBytes, reclaimableBytes: $reclaimableBytes, missingBookIds: $missingBookIds, duplicateBookIds: $duplicateBookIds, orphanPaths: $orphanPaths)';
}


}

/// @nodoc
abstract mixin class _$StorageReportCopyWith<$Res> implements $StorageReportCopyWith<$Res> {
  factory _$StorageReportCopyWith(_StorageReport value, $Res Function(_StorageReport) _then) = __$StorageReportCopyWithImpl;
@override @useResult
$Res call({
 int managedBytes, int reclaimableBytes, List<String> missingBookIds, List<List<String>> duplicateBookIds, List<String> orphanPaths
});




}
/// @nodoc
class __$StorageReportCopyWithImpl<$Res>
    implements _$StorageReportCopyWith<$Res> {
  __$StorageReportCopyWithImpl(this._self, this._then);

  final _StorageReport _self;
  final $Res Function(_StorageReport) _then;

/// Create a copy of StorageReport
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? managedBytes = null,Object? reclaimableBytes = null,Object? missingBookIds = null,Object? duplicateBookIds = null,Object? orphanPaths = null,}) {
  return _then(_StorageReport(
managedBytes: null == managedBytes ? _self.managedBytes : managedBytes // ignore: cast_nullable_to_non_nullable
as int,reclaimableBytes: null == reclaimableBytes ? _self.reclaimableBytes : reclaimableBytes // ignore: cast_nullable_to_non_nullable
as int,missingBookIds: null == missingBookIds ? _self._missingBookIds : missingBookIds // ignore: cast_nullable_to_non_nullable
as List<String>,duplicateBookIds: null == duplicateBookIds ? _self._duplicateBookIds : duplicateBookIds // ignore: cast_nullable_to_non_nullable
as List<List<String>>,orphanPaths: null == orphanPaths ? _self._orphanPaths : orphanPaths // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
