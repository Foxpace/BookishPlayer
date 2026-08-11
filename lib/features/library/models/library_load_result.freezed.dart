// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'library_load_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LibraryLoadResult {

 List<Audiobook> get books; String get layout;
/// Create a copy of LibraryLoadResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LibraryLoadResultCopyWith<LibraryLoadResult> get copyWith => _$LibraryLoadResultCopyWithImpl<LibraryLoadResult>(this as LibraryLoadResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LibraryLoadResult&&const DeepCollectionEquality().equals(other.books, books)&&(identical(other.layout, layout) || other.layout == layout));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(books),layout);

@override
String toString() {
  return 'LibraryLoadResult(books: $books, layout: $layout)';
}


}

/// @nodoc
abstract mixin class $LibraryLoadResultCopyWith<$Res>  {
  factory $LibraryLoadResultCopyWith(LibraryLoadResult value, $Res Function(LibraryLoadResult) _then) = _$LibraryLoadResultCopyWithImpl;
@useResult
$Res call({
 List<Audiobook> books, String layout
});




}
/// @nodoc
class _$LibraryLoadResultCopyWithImpl<$Res>
    implements $LibraryLoadResultCopyWith<$Res> {
  _$LibraryLoadResultCopyWithImpl(this._self, this._then);

  final LibraryLoadResult _self;
  final $Res Function(LibraryLoadResult) _then;

/// Create a copy of LibraryLoadResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? books = null,Object? layout = null,}) {
  return _then(_self.copyWith(
books: null == books ? _self.books : books // ignore: cast_nullable_to_non_nullable
as List<Audiobook>,layout: null == layout ? _self.layout : layout // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LibraryLoadResult].
extension LibraryLoadResultPatterns on LibraryLoadResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LibraryLoadResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LibraryLoadResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LibraryLoadResult value)  $default,){
final _that = this;
switch (_that) {
case _LibraryLoadResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LibraryLoadResult value)?  $default,){
final _that = this;
switch (_that) {
case _LibraryLoadResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Audiobook> books,  String layout)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LibraryLoadResult() when $default != null:
return $default(_that.books,_that.layout);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Audiobook> books,  String layout)  $default,) {final _that = this;
switch (_that) {
case _LibraryLoadResult():
return $default(_that.books,_that.layout);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Audiobook> books,  String layout)?  $default,) {final _that = this;
switch (_that) {
case _LibraryLoadResult() when $default != null:
return $default(_that.books,_that.layout);case _:
  return null;

}
}

}

/// @nodoc


class _LibraryLoadResult implements LibraryLoadResult {
  const _LibraryLoadResult({required final  List<Audiobook> books, required this.layout}): _books = books;
  

 final  List<Audiobook> _books;
@override List<Audiobook> get books {
  if (_books is EqualUnmodifiableListView) return _books;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_books);
}

@override final  String layout;

/// Create a copy of LibraryLoadResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LibraryLoadResultCopyWith<_LibraryLoadResult> get copyWith => __$LibraryLoadResultCopyWithImpl<_LibraryLoadResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LibraryLoadResult&&const DeepCollectionEquality().equals(other._books, _books)&&(identical(other.layout, layout) || other.layout == layout));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_books),layout);

@override
String toString() {
  return 'LibraryLoadResult(books: $books, layout: $layout)';
}


}

/// @nodoc
abstract mixin class _$LibraryLoadResultCopyWith<$Res> implements $LibraryLoadResultCopyWith<$Res> {
  factory _$LibraryLoadResultCopyWith(_LibraryLoadResult value, $Res Function(_LibraryLoadResult) _then) = __$LibraryLoadResultCopyWithImpl;
@override @useResult
$Res call({
 List<Audiobook> books, String layout
});




}
/// @nodoc
class __$LibraryLoadResultCopyWithImpl<$Res>
    implements _$LibraryLoadResultCopyWith<$Res> {
  __$LibraryLoadResultCopyWithImpl(this._self, this._then);

  final _LibraryLoadResult _self;
  final $Res Function(_LibraryLoadResult) _then;

/// Create a copy of LibraryLoadResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? books = null,Object? layout = null,}) {
  return _then(_LibraryLoadResult(
books: null == books ? _self._books : books // ignore: cast_nullable_to_non_nullable
as List<Audiobook>,layout: null == layout ? _self.layout : layout // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
