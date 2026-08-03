// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bookish_backup.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BackupSettings {

 String get theme; PlaybackPreferences get playback;
/// Create a copy of BackupSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BackupSettingsCopyWith<BackupSettings> get copyWith => _$BackupSettingsCopyWithImpl<BackupSettings>(this as BackupSettings, _$identity);

  /// Serializes this BackupSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BackupSettings&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.playback, playback) || other.playback == playback));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,theme,playback);

@override
String toString() {
  return 'BackupSettings(theme: $theme, playback: $playback)';
}


}

/// @nodoc
abstract mixin class $BackupSettingsCopyWith<$Res>  {
  factory $BackupSettingsCopyWith(BackupSettings value, $Res Function(BackupSettings) _then) = _$BackupSettingsCopyWithImpl;
@useResult
$Res call({
 String theme, PlaybackPreferences playback
});


$PlaybackPreferencesCopyWith<$Res> get playback;

}
/// @nodoc
class _$BackupSettingsCopyWithImpl<$Res>
    implements $BackupSettingsCopyWith<$Res> {
  _$BackupSettingsCopyWithImpl(this._self, this._then);

  final BackupSettings _self;
  final $Res Function(BackupSettings) _then;

/// Create a copy of BackupSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? theme = null,Object? playback = null,}) {
  return _then(_self.copyWith(
theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as String,playback: null == playback ? _self.playback : playback // ignore: cast_nullable_to_non_nullable
as PlaybackPreferences,
  ));
}
/// Create a copy of BackupSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlaybackPreferencesCopyWith<$Res> get playback {
  
  return $PlaybackPreferencesCopyWith<$Res>(_self.playback, (value) {
    return _then(_self.copyWith(playback: value));
  });
}
}


/// Adds pattern-matching-related methods to [BackupSettings].
extension BackupSettingsPatterns on BackupSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BackupSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BackupSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BackupSettings value)  $default,){
final _that = this;
switch (_that) {
case _BackupSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BackupSettings value)?  $default,){
final _that = this;
switch (_that) {
case _BackupSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String theme,  PlaybackPreferences playback)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BackupSettings() when $default != null:
return $default(_that.theme,_that.playback);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String theme,  PlaybackPreferences playback)  $default,) {final _that = this;
switch (_that) {
case _BackupSettings():
return $default(_that.theme,_that.playback);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String theme,  PlaybackPreferences playback)?  $default,) {final _that = this;
switch (_that) {
case _BackupSettings() when $default != null:
return $default(_that.theme,_that.playback);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BackupSettings implements BackupSettings {
  const _BackupSettings({required this.theme, this.playback = const PlaybackPreferences()});
  factory _BackupSettings.fromJson(Map<String, dynamic> json) => _$BackupSettingsFromJson(json);

@override final  String theme;
@override@JsonKey() final  PlaybackPreferences playback;

/// Create a copy of BackupSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BackupSettingsCopyWith<_BackupSettings> get copyWith => __$BackupSettingsCopyWithImpl<_BackupSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BackupSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BackupSettings&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.playback, playback) || other.playback == playback));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,theme,playback);

@override
String toString() {
  return 'BackupSettings(theme: $theme, playback: $playback)';
}


}

/// @nodoc
abstract mixin class _$BackupSettingsCopyWith<$Res> implements $BackupSettingsCopyWith<$Res> {
  factory _$BackupSettingsCopyWith(_BackupSettings value, $Res Function(_BackupSettings) _then) = __$BackupSettingsCopyWithImpl;
@override @useResult
$Res call({
 String theme, PlaybackPreferences playback
});


@override $PlaybackPreferencesCopyWith<$Res> get playback;

}
/// @nodoc
class __$BackupSettingsCopyWithImpl<$Res>
    implements _$BackupSettingsCopyWith<$Res> {
  __$BackupSettingsCopyWithImpl(this._self, this._then);

  final _BackupSettings _self;
  final $Res Function(_BackupSettings) _then;

/// Create a copy of BackupSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? theme = null,Object? playback = null,}) {
  return _then(_BackupSettings(
theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as String,playback: null == playback ? _self.playback : playback // ignore: cast_nullable_to_non_nullable
as PlaybackPreferences,
  ));
}

/// Create a copy of BackupSettings
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlaybackPreferencesCopyWith<$Res> get playback {
  
  return $PlaybackPreferencesCopyWith<$Res>(_self.playback, (value) {
    return _then(_self.copyWith(playback: value));
  });
}
}


/// @nodoc
mixin _$BookishBackup {

 DateTime get exportedAt; BackupSettings get settings; int get schemaVersion; List<Audiobook> get books; List<BookNote> get notes; List<ListeningSession> get sessions;
/// Create a copy of BookishBackup
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookishBackupCopyWith<BookishBackup> get copyWith => _$BookishBackupCopyWithImpl<BookishBackup>(this as BookishBackup, _$identity);

  /// Serializes this BookishBackup to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookishBackup&&(identical(other.exportedAt, exportedAt) || other.exportedAt == exportedAt)&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&const DeepCollectionEquality().equals(other.books, books)&&const DeepCollectionEquality().equals(other.notes, notes)&&const DeepCollectionEquality().equals(other.sessions, sessions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,exportedAt,settings,schemaVersion,const DeepCollectionEquality().hash(books),const DeepCollectionEquality().hash(notes),const DeepCollectionEquality().hash(sessions));

@override
String toString() {
  return 'BookishBackup(exportedAt: $exportedAt, settings: $settings, schemaVersion: $schemaVersion, books: $books, notes: $notes, sessions: $sessions)';
}


}

/// @nodoc
abstract mixin class $BookishBackupCopyWith<$Res>  {
  factory $BookishBackupCopyWith(BookishBackup value, $Res Function(BookishBackup) _then) = _$BookishBackupCopyWithImpl;
@useResult
$Res call({
 DateTime exportedAt, BackupSettings settings, int schemaVersion, List<Audiobook> books, List<BookNote> notes, List<ListeningSession> sessions
});


$BackupSettingsCopyWith<$Res> get settings;

}
/// @nodoc
class _$BookishBackupCopyWithImpl<$Res>
    implements $BookishBackupCopyWith<$Res> {
  _$BookishBackupCopyWithImpl(this._self, this._then);

  final BookishBackup _self;
  final $Res Function(BookishBackup) _then;

/// Create a copy of BookishBackup
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? exportedAt = null,Object? settings = null,Object? schemaVersion = null,Object? books = null,Object? notes = null,Object? sessions = null,}) {
  return _then(_self.copyWith(
exportedAt: null == exportedAt ? _self.exportedAt : exportedAt // ignore: cast_nullable_to_non_nullable
as DateTime,settings: null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as BackupSettings,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,books: null == books ? _self.books : books // ignore: cast_nullable_to_non_nullable
as List<Audiobook>,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as List<BookNote>,sessions: null == sessions ? _self.sessions : sessions // ignore: cast_nullable_to_non_nullable
as List<ListeningSession>,
  ));
}
/// Create a copy of BookishBackup
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BackupSettingsCopyWith<$Res> get settings {
  
  return $BackupSettingsCopyWith<$Res>(_self.settings, (value) {
    return _then(_self.copyWith(settings: value));
  });
}
}


/// Adds pattern-matching-related methods to [BookishBackup].
extension BookishBackupPatterns on BookishBackup {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BookishBackup value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BookishBackup() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BookishBackup value)  $default,){
final _that = this;
switch (_that) {
case _BookishBackup():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BookishBackup value)?  $default,){
final _that = this;
switch (_that) {
case _BookishBackup() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime exportedAt,  BackupSettings settings,  int schemaVersion,  List<Audiobook> books,  List<BookNote> notes,  List<ListeningSession> sessions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BookishBackup() when $default != null:
return $default(_that.exportedAt,_that.settings,_that.schemaVersion,_that.books,_that.notes,_that.sessions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime exportedAt,  BackupSettings settings,  int schemaVersion,  List<Audiobook> books,  List<BookNote> notes,  List<ListeningSession> sessions)  $default,) {final _that = this;
switch (_that) {
case _BookishBackup():
return $default(_that.exportedAt,_that.settings,_that.schemaVersion,_that.books,_that.notes,_that.sessions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime exportedAt,  BackupSettings settings,  int schemaVersion,  List<Audiobook> books,  List<BookNote> notes,  List<ListeningSession> sessions)?  $default,) {final _that = this;
switch (_that) {
case _BookishBackup() when $default != null:
return $default(_that.exportedAt,_that.settings,_that.schemaVersion,_that.books,_that.notes,_that.sessions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BookishBackup implements BookishBackup {
  const _BookishBackup({required this.exportedAt, required this.settings, this.schemaVersion = 1, final  List<Audiobook> books = const <Audiobook>[], final  List<BookNote> notes = const <BookNote>[], final  List<ListeningSession> sessions = const <ListeningSession>[]}): _books = books,_notes = notes,_sessions = sessions;
  factory _BookishBackup.fromJson(Map<String, dynamic> json) => _$BookishBackupFromJson(json);

@override final  DateTime exportedAt;
@override final  BackupSettings settings;
@override@JsonKey() final  int schemaVersion;
 final  List<Audiobook> _books;
@override@JsonKey() List<Audiobook> get books {
  if (_books is EqualUnmodifiableListView) return _books;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_books);
}

 final  List<BookNote> _notes;
@override@JsonKey() List<BookNote> get notes {
  if (_notes is EqualUnmodifiableListView) return _notes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_notes);
}

 final  List<ListeningSession> _sessions;
@override@JsonKey() List<ListeningSession> get sessions {
  if (_sessions is EqualUnmodifiableListView) return _sessions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sessions);
}


/// Create a copy of BookishBackup
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookishBackupCopyWith<_BookishBackup> get copyWith => __$BookishBackupCopyWithImpl<_BookishBackup>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookishBackupToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BookishBackup&&(identical(other.exportedAt, exportedAt) || other.exportedAt == exportedAt)&&(identical(other.settings, settings) || other.settings == settings)&&(identical(other.schemaVersion, schemaVersion) || other.schemaVersion == schemaVersion)&&const DeepCollectionEquality().equals(other._books, _books)&&const DeepCollectionEquality().equals(other._notes, _notes)&&const DeepCollectionEquality().equals(other._sessions, _sessions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,exportedAt,settings,schemaVersion,const DeepCollectionEquality().hash(_books),const DeepCollectionEquality().hash(_notes),const DeepCollectionEquality().hash(_sessions));

@override
String toString() {
  return 'BookishBackup(exportedAt: $exportedAt, settings: $settings, schemaVersion: $schemaVersion, books: $books, notes: $notes, sessions: $sessions)';
}


}

/// @nodoc
abstract mixin class _$BookishBackupCopyWith<$Res> implements $BookishBackupCopyWith<$Res> {
  factory _$BookishBackupCopyWith(_BookishBackup value, $Res Function(_BookishBackup) _then) = __$BookishBackupCopyWithImpl;
@override @useResult
$Res call({
 DateTime exportedAt, BackupSettings settings, int schemaVersion, List<Audiobook> books, List<BookNote> notes, List<ListeningSession> sessions
});


@override $BackupSettingsCopyWith<$Res> get settings;

}
/// @nodoc
class __$BookishBackupCopyWithImpl<$Res>
    implements _$BookishBackupCopyWith<$Res> {
  __$BookishBackupCopyWithImpl(this._self, this._then);

  final _BookishBackup _self;
  final $Res Function(_BookishBackup) _then;

/// Create a copy of BookishBackup
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? exportedAt = null,Object? settings = null,Object? schemaVersion = null,Object? books = null,Object? notes = null,Object? sessions = null,}) {
  return _then(_BookishBackup(
exportedAt: null == exportedAt ? _self.exportedAt : exportedAt // ignore: cast_nullable_to_non_nullable
as DateTime,settings: null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as BackupSettings,schemaVersion: null == schemaVersion ? _self.schemaVersion : schemaVersion // ignore: cast_nullable_to_non_nullable
as int,books: null == books ? _self._books : books // ignore: cast_nullable_to_non_nullable
as List<Audiobook>,notes: null == notes ? _self._notes : notes // ignore: cast_nullable_to_non_nullable
as List<BookNote>,sessions: null == sessions ? _self._sessions : sessions // ignore: cast_nullable_to_non_nullable
as List<ListeningSession>,
  ));
}

/// Create a copy of BookishBackup
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BackupSettingsCopyWith<$Res> get settings {
  
  return $BackupSettingsCopyWith<$Res>(_self.settings, (value) {
    return _then(_self.copyWith(settings: value));
  });
}
}

// dart format on
