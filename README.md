# Bookish

Bookish is a quiet, offline-first audiobook player for iOS and Android. It keeps
your books, playback history, notes, and preferences on your device and is built
for both single-file audiobooks and multi-file collections.

## What Bookish can do

### Import and organize

- Import MP3, M4A, M4B, AAC, FLAC, WAV, OGG, and Opus files with the native
  document picker, including files from iCloud and Android document providers.
- Copy imported audio into app-private storage so books remain available
  offline.
- Combine naturally ordered multi-file selections into one continuous book and
  create chapters at track boundaries.
- Read embedded M4B `chpl`, QuickTime text-track, and supported audio-metadata
  chapters without loading complete media files into memory.
- Extract embedded cover art from MP3, MP4/M4B, FLAC, OGG, Opus, and WAV files.
- Browse the library as a grid or list, search it, and group books by author,
  series, folder, or listening status.
- Edit a book's title, author, series, folder, cover, track order, and chapters.
- Remove a book from the library while choosing whether to keep or delete its
  imported audio files.

### Listen

- Play in the background with lock-screen, notification, headset, CarPlay, and
  Android Auto controls.
- Choose the system audio output from the player.
- Seek by chapter or position, make configurable short and large jumps, and
  listen from 0.75x to 2x speed.
- On Android, optionally shorten silence and boost voices; on both platforms,
  continue automatically with the next book in a series.
- Remember playback speed per book and automatically rewind after longer pauses.
- Save progress frequently and on pause, seek, completion, lifecycle changes,
  and app shutdown.
- Use fixed or end-of-chapter sleep timers with a configurable fade-out and
  chapter fallback.
- Track listening time and review weekly, monthly, and yearly activity, total
  listening time, active days, and completed books.

### Capture and share

- Create timestamped text or voice notes, jump back to their position, edit
  them, and share individual notes.
- Browse notes across the whole library or by book, including notes retained
  from removed books.
- Export a book's notes as Markdown.
- Transcribe a selected passage locally, adjust the captured range, edit the
  result, and share it as a quote.
- Download and manage on-device speech models from Settings.

### Keep data under your control

- Export and restore JSON backups containing progress, notes, listening
  history, metadata, and settings.
- Inspect managed storage, missing books, duplicate entries, and orphaned files;
  clean reclaimable files or reset all app data.
- Choose system, light, or dark appearance and use the app in English or Slovak.

## Architecture

The source follows a feature-first structure under `lib/features/` with a
pragmatic MVI flow:

```text
Widget -> Cubit intent -> application workflow/domain port -> data adapter
   ^                                                        |
   +---------------- immutable state -----------------------+
```

The current feature modules are:

- `library` — saved books, metadata, listening history, and Sembast persistence
- `importing` — file selection, durable copying, metadata probing, and chapter
  parsing
- `player` — playback, progress, sleep timers, notes, and player UI
- `editing` — offline metadata, cover, track-order, and chapter editing
- `notes` — the library-wide note gallery and archived notes
- `insights` — listening-history aggregation and activity views
- `transcription` — local speech-model management and audio transcription
- `storage` — storage diagnostics, cleanup, and app-data reset
- `portability` — Markdown note export and JSON backup/restore
- `settings` — persisted appearance, playback, library, and speech preferences
- `core` — navigation, dependency injection, database setup, localization,
  theming, and shared presentation code

Every route has a `ScreenRoot` composition boundary. Roots resolve Cubits through
GetIt/Injectable; ordinary widgets bind immutable state and dispatch user intent.
Application workflows coordinate multi-step work, domain ports isolate data
adapters, and data-only state uses Freezed. Named `go_router` routes include
deep-linkable player IDs.

The complete boundaries and enforced size limits are documented in
[`docs/architecture.md`](docs/architecture.md).

## Development

Bookish requires the Flutter SDK and a configured iOS or Android toolchain.

```sh
flutter pub get
flutter pub run intl_utils:generate
dart run build_runner build
dart format lib test
flutter analyze
flutter test
flutter run
```

Do not edit generated `*.freezed.dart`, `*.g.dart`, or `injection.config.dart`
files by hand.

Localization source files live in `lib/l10n`. After changing an ARB file, run
`flutter pub run intl_utils:generate` to refresh the generated `S` class. The app
follows the device locale and currently supports English and Slovak.

## Test media

An M4B sample from the freely available LibriVox collection below is kept in
`test_samples/` for local parser and playback testing:

- <https://archive.org/details/LibrivoxM4bCollectionAudiobooks_22>
