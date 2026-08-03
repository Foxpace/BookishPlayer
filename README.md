# Bookish

Bookish is an offline-first Flutter audiobook player for iOS and Android.

## Features

- Imports MP3, M4A, M4B, AAC, FLAC, WAV, OGG, and Opus through the native document picker.
- Copies imports into durable app-private storage (including files selected from iCloud or Android document providers).
- Plays in the background with lock-screen, notification, headset, CarPlay, and Android Auto controls.
- Checkpoints each book's playback position every 250 ms and on pause, seek, completion, lifecycle changes, and app shutdown.
- Remembers playback speed per book and automatically rewinds after longer pauses.
- Supports fixed sleep timers and an end-of-chapter sleep timer.
- Stores timestamped bookmarks and notes, supports jumping back to them, and exports them as Markdown.
- Parses embedded M4B `chpl`, QuickTime text-track, and supported audio metadata chapters without loading media payloads into memory.
- Combines naturally ordered multi-file selections into one continuous audiobook with track-boundary chapters.
- Extracts embedded MP3, MP4/M4B, FLAC, OGG, Opus, and WAV cover art and displays it throughout the app.
- Groups the local library by author, series, folder, or listening status.
- Edits title, author, series, folder, cover, track order, and chapters entirely offline.
- Exports and restores local JSON backups of progress, notes, metadata, and settings.
- Supports system, light, and dark appearance modes with a persisted Settings screen.
- Supports 15-second rewind, 30-second forward, seeking, and 0.75×–2× playback speed.

## Architecture

The source uses feature-first (screaming) architecture under `lib/features/`:

- `library` owns saved books and Sembast persistence.
- `importing` owns document selection, durable copying, metadata probing, and M4B parsing.
- `player` owns playback, progress checkpointing, notes, and player UI.
- `editing` owns offline metadata, cover, track-order, and chapter editing.
- `portability` owns notes export and local backup/restore.
- `settings` owns independent persisted app preferences.
- `core` contains cross-feature DI, database setup, and presentation primitives.
- Navigation uses named `go_router` routes, including deep-linkable player IDs.

Every route has a `ScreenRoot` composition boundary. Roots resolve Cubits through GetIt/Injectable; screen widgets only bind immutable state and dispatch user intent. Multi-step work lives in pure-Dart application workflows, domain ports isolate data adapters, and all Cubit state uses Freezed. The enforced dependency rules and MVI loop are documented in [`docs/architecture.md`](docs/architecture.md).

## Development

```sh
flutter pub get
dart run build_runner build
flutter test
flutter analyze
flutter run
```

## Testing

For testing, this freely available audiobook is included in the `test_assets` folder:

- <https://archive.org/details/LibrivoxM4bCollectionAudiobooks_22>
