// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'library_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LibraryState {

 LibraryStatus get status; List<Audiobook> get books; LibraryGrouping get grouping; LibraryLayout get layout; String get query; LibraryFilter get filter; LibrarySort get sort; List<LibrarySection> get sections; AppMessage? get message; int get effectRevision;
/// Create a copy of LibraryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LibraryStateCopyWith<LibraryState> get copyWith => _$LibraryStateCopyWithImpl<LibraryState>(this as LibraryState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LibraryState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.books, books)&&(identical(other.grouping, grouping) || other.grouping == grouping)&&(identical(other.layout, layout) || other.layout == layout)&&(identical(other.query, query) || other.query == query)&&(identical(other.filter, filter) || other.filter == filter)&&(identical(other.sort, sort) || other.sort == sort)&&const DeepCollectionEquality().equals(other.sections, sections)&&(identical(other.message, message) || other.message == message)&&(identical(other.effectRevision, effectRevision) || other.effectRevision == effectRevision));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(books),grouping,layout,query,filter,sort,const DeepCollectionEquality().hash(sections),message,effectRevision);

@override
String toString() {
  return 'LibraryState(status: $status, books: $books, grouping: $grouping, layout: $layout, query: $query, filter: $filter, sort: $sort, sections: $sections, message: $message, effectRevision: $effectRevision)';
}


}

/// @nodoc
abstract mixin class $LibraryStateCopyWith<$Res>  {
  factory $LibraryStateCopyWith(LibraryState value, $Res Function(LibraryState) _then) = _$LibraryStateCopyWithImpl;
@useResult
$Res call({
 LibraryStatus status, List<Audiobook> books, LibraryGrouping grouping, LibraryLayout layout, String query, LibraryFilter filter, LibrarySort sort, List<LibrarySection> sections, AppMessage? message, int effectRevision
});




}
/// @nodoc
class _$LibraryStateCopyWithImpl<$Res>
    implements $LibraryStateCopyWith<$Res> {
  _$LibraryStateCopyWithImpl(this._self, this._then);

  final LibraryState _self;
  final $Res Function(LibraryState) _then;

/// Create a copy of LibraryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? books = null,Object? grouping = null,Object? layout = null,Object? query = null,Object? filter = null,Object? sort = null,Object? sections = null,Object? message = freezed,Object? effectRevision = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LibraryStatus,books: null == books ? _self.books : books // ignore: cast_nullable_to_non_nullable
as List<Audiobook>,grouping: null == grouping ? _self.grouping : grouping // ignore: cast_nullable_to_non_nullable
as LibraryGrouping,layout: null == layout ? _self.layout : layout // ignore: cast_nullable_to_non_nullable
as LibraryLayout,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as LibraryFilter,sort: null == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as LibrarySort,sections: null == sections ? _self.sections : sections // ignore: cast_nullable_to_non_nullable
as List<LibrarySection>,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as AppMessage?,effectRevision: null == effectRevision ? _self.effectRevision : effectRevision // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [LibraryState].
extension LibraryStatePatterns on LibraryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LibraryState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LibraryState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LibraryState value)  $default,){
final _that = this;
switch (_that) {
case _LibraryState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LibraryState value)?  $default,){
final _that = this;
switch (_that) {
case _LibraryState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( LibraryStatus status,  List<Audiobook> books,  LibraryGrouping grouping,  LibraryLayout layout,  String query,  LibraryFilter filter,  LibrarySort sort,  List<LibrarySection> sections,  AppMessage? message,  int effectRevision)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LibraryState() when $default != null:
return $default(_that.status,_that.books,_that.grouping,_that.layout,_that.query,_that.filter,_that.sort,_that.sections,_that.message,_that.effectRevision);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( LibraryStatus status,  List<Audiobook> books,  LibraryGrouping grouping,  LibraryLayout layout,  String query,  LibraryFilter filter,  LibrarySort sort,  List<LibrarySection> sections,  AppMessage? message,  int effectRevision)  $default,) {final _that = this;
switch (_that) {
case _LibraryState():
return $default(_that.status,_that.books,_that.grouping,_that.layout,_that.query,_that.filter,_that.sort,_that.sections,_that.message,_that.effectRevision);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( LibraryStatus status,  List<Audiobook> books,  LibraryGrouping grouping,  LibraryLayout layout,  String query,  LibraryFilter filter,  LibrarySort sort,  List<LibrarySection> sections,  AppMessage? message,  int effectRevision)?  $default,) {final _that = this;
switch (_that) {
case _LibraryState() when $default != null:
return $default(_that.status,_that.books,_that.grouping,_that.layout,_that.query,_that.filter,_that.sort,_that.sections,_that.message,_that.effectRevision);case _:
  return null;

}
}

}

/// @nodoc


class _LibraryState implements LibraryState {
  const _LibraryState({this.status = LibraryStatus.initial, final  List<Audiobook> books = const <Audiobook>[], this.grouping = LibraryGrouping.none, this.layout = LibraryLayout.list, this.query = '', this.filter = LibraryFilter.all, this.sort = LibrarySort.recent, final  List<LibrarySection> sections = const <LibrarySection>[], this.message, this.effectRevision = 0}): _books = books,_sections = sections;
  

@override@JsonKey() final  LibraryStatus status;
 final  List<Audiobook> _books;
@override@JsonKey() List<Audiobook> get books {
  if (_books is EqualUnmodifiableListView) return _books;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_books);
}

@override@JsonKey() final  LibraryGrouping grouping;
@override@JsonKey() final  LibraryLayout layout;
@override@JsonKey() final  String query;
@override@JsonKey() final  LibraryFilter filter;
@override@JsonKey() final  LibrarySort sort;
 final  List<LibrarySection> _sections;
@override@JsonKey() List<LibrarySection> get sections {
  if (_sections is EqualUnmodifiableListView) return _sections;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sections);
}

@override final  AppMessage? message;
@override@JsonKey() final  int effectRevision;

/// Create a copy of LibraryState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LibraryStateCopyWith<_LibraryState> get copyWith => __$LibraryStateCopyWithImpl<_LibraryState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LibraryState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._books, _books)&&(identical(other.grouping, grouping) || other.grouping == grouping)&&(identical(other.layout, layout) || other.layout == layout)&&(identical(other.query, query) || other.query == query)&&(identical(other.filter, filter) || other.filter == filter)&&(identical(other.sort, sort) || other.sort == sort)&&const DeepCollectionEquality().equals(other._sections, _sections)&&(identical(other.message, message) || other.message == message)&&(identical(other.effectRevision, effectRevision) || other.effectRevision == effectRevision));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_books),grouping,layout,query,filter,sort,const DeepCollectionEquality().hash(_sections),message,effectRevision);

@override
String toString() {
  return 'LibraryState(status: $status, books: $books, grouping: $grouping, layout: $layout, query: $query, filter: $filter, sort: $sort, sections: $sections, message: $message, effectRevision: $effectRevision)';
}


}

/// @nodoc
abstract mixin class _$LibraryStateCopyWith<$Res> implements $LibraryStateCopyWith<$Res> {
  factory _$LibraryStateCopyWith(_LibraryState value, $Res Function(_LibraryState) _then) = __$LibraryStateCopyWithImpl;
@override @useResult
$Res call({
 LibraryStatus status, List<Audiobook> books, LibraryGrouping grouping, LibraryLayout layout, String query, LibraryFilter filter, LibrarySort sort, List<LibrarySection> sections, AppMessage? message, int effectRevision
});




}
/// @nodoc
class __$LibraryStateCopyWithImpl<$Res>
    implements _$LibraryStateCopyWith<$Res> {
  __$LibraryStateCopyWithImpl(this._self, this._then);

  final _LibraryState _self;
  final $Res Function(_LibraryState) _then;

/// Create a copy of LibraryState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? books = null,Object? grouping = null,Object? layout = null,Object? query = null,Object? filter = null,Object? sort = null,Object? sections = null,Object? message = freezed,Object? effectRevision = null,}) {
  return _then(_LibraryState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as LibraryStatus,books: null == books ? _self._books : books // ignore: cast_nullable_to_non_nullable
as List<Audiobook>,grouping: null == grouping ? _self.grouping : grouping // ignore: cast_nullable_to_non_nullable
as LibraryGrouping,layout: null == layout ? _self.layout : layout // ignore: cast_nullable_to_non_nullable
as LibraryLayout,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as LibraryFilter,sort: null == sort ? _self.sort : sort // ignore: cast_nullable_to_non_nullable
as LibrarySort,sections: null == sections ? _self._sections : sections // ignore: cast_nullable_to_non_nullable
as List<LibrarySection>,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as AppMessage?,effectRevision: null == effectRevision ? _self.effectRevision : effectRevision // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$LibrarySection {

 List<Audiobook> get books; String get title; LibrarySectionLabel? get label;
/// Create a copy of LibrarySection
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LibrarySectionCopyWith<LibrarySection> get copyWith => _$LibrarySectionCopyWithImpl<LibrarySection>(this as LibrarySection, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LibrarySection&&const DeepCollectionEquality().equals(other.books, books)&&(identical(other.title, title) || other.title == title)&&(identical(other.label, label) || other.label == label));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(books),title,label);

@override
String toString() {
  return 'LibrarySection(books: $books, title: $title, label: $label)';
}


}

/// @nodoc
abstract mixin class $LibrarySectionCopyWith<$Res>  {
  factory $LibrarySectionCopyWith(LibrarySection value, $Res Function(LibrarySection) _then) = _$LibrarySectionCopyWithImpl;
@useResult
$Res call({
 List<Audiobook> books, String title, LibrarySectionLabel? label
});




}
/// @nodoc
class _$LibrarySectionCopyWithImpl<$Res>
    implements $LibrarySectionCopyWith<$Res> {
  _$LibrarySectionCopyWithImpl(this._self, this._then);

  final LibrarySection _self;
  final $Res Function(LibrarySection) _then;

/// Create a copy of LibrarySection
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? books = null,Object? title = null,Object? label = freezed,}) {
  return _then(_self.copyWith(
books: null == books ? _self.books : books // ignore: cast_nullable_to_non_nullable
as List<Audiobook>,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as LibrarySectionLabel?,
  ));
}

}


/// Adds pattern-matching-related methods to [LibrarySection].
extension LibrarySectionPatterns on LibrarySection {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LibrarySection value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LibrarySection() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LibrarySection value)  $default,){
final _that = this;
switch (_that) {
case _LibrarySection():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LibrarySection value)?  $default,){
final _that = this;
switch (_that) {
case _LibrarySection() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Audiobook> books,  String title,  LibrarySectionLabel? label)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LibrarySection() when $default != null:
return $default(_that.books,_that.title,_that.label);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Audiobook> books,  String title,  LibrarySectionLabel? label)  $default,) {final _that = this;
switch (_that) {
case _LibrarySection():
return $default(_that.books,_that.title,_that.label);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Audiobook> books,  String title,  LibrarySectionLabel? label)?  $default,) {final _that = this;
switch (_that) {
case _LibrarySection() when $default != null:
return $default(_that.books,_that.title,_that.label);case _:
  return null;

}
}

}

/// @nodoc


class _LibrarySection implements LibrarySection {
  const _LibrarySection({required final  List<Audiobook> books, this.title = '', this.label}): _books = books;
  

 final  List<Audiobook> _books;
@override List<Audiobook> get books {
  if (_books is EqualUnmodifiableListView) return _books;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_books);
}

@override@JsonKey() final  String title;
@override final  LibrarySectionLabel? label;

/// Create a copy of LibrarySection
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LibrarySectionCopyWith<_LibrarySection> get copyWith => __$LibrarySectionCopyWithImpl<_LibrarySection>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LibrarySection&&const DeepCollectionEquality().equals(other._books, _books)&&(identical(other.title, title) || other.title == title)&&(identical(other.label, label) || other.label == label));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_books),title,label);

@override
String toString() {
  return 'LibrarySection(books: $books, title: $title, label: $label)';
}


}

/// @nodoc
abstract mixin class _$LibrarySectionCopyWith<$Res> implements $LibrarySectionCopyWith<$Res> {
  factory _$LibrarySectionCopyWith(_LibrarySection value, $Res Function(_LibrarySection) _then) = __$LibrarySectionCopyWithImpl;
@override @useResult
$Res call({
 List<Audiobook> books, String title, LibrarySectionLabel? label
});




}
/// @nodoc
class __$LibrarySectionCopyWithImpl<$Res>
    implements _$LibrarySectionCopyWith<$Res> {
  __$LibrarySectionCopyWithImpl(this._self, this._then);

  final _LibrarySection _self;
  final $Res Function(_LibrarySection) _then;

/// Create a copy of LibrarySection
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? books = null,Object? title = null,Object? label = freezed,}) {
  return _then(_LibrarySection(
books: null == books ? _self._books : books // ignore: cast_nullable_to_non_nullable
as List<Audiobook>,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,label: freezed == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as LibrarySectionLabel?,
  ));
}


}

// dart format on
