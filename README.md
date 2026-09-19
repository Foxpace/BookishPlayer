<p align="center">
  <img src="apps/store/assets/icon/bookish_app_icon.png" width="132" alt="Bookish app icon">
</p>

<h1 align="center">Bookish</h1>

<p align="center">
  A quiet, offline-first audiobook player for iOS and Android.
</p>

<p align="center">
  <img alt="Android 10+" src="https://img.shields.io/badge/Android-10%2B-3DDC84?logo=android&amp;logoColor=white">
  <img alt="iOS 16+" src="https://img.shields.io/badge/iOS-16%2B-000000?logo=apple&amp;logoColor=white">
  <img alt="Flutter" src="https://img.shields.io/badge/UI-Flutter-02569B?logo=flutter&amp;logoColor=white">
</p>

## See it in use

<table>
  <tr>
    <td width="33%"><img src="docs/screenshots/library.png" alt="Bookish library"></td>
    <td width="33%"><img src="docs/screenshots/player.png" alt="Bookish audiobook player"></td>
    <td width="33%"><img src="docs/screenshots/settings-ios.png" alt="Bookish settings"></td>
  </tr>
  <tr>
    <td align="center"><sub>Browse covers, progress, and listening status.</sub></td>
    <td align="center"><sub>Move by chapter, position, or jump interval.</sub></td>
    <td align="center"><sub>Set playback, sleep timer, and appearance.</sub></td>
  </tr>
</table>

Screens use the public-domain LibriVox recording of [*Alice's Adventures in Wonderland*](https://librivox.org/alices-adventures-in-wonderland-by-lewis-carroll-5/).

## The idea

Bookish treats an audiobook as a book, not a loose playlist. Import it once, keep it on the device, and return to the exact chapter and position later. Notes, history, covers, preferences, and backups remain local too.

## What it does

- Imports common audiobook formats, embedded chapters, and cover art
- Organizes books by author, series, folder, or listening status
- Plays in the background with lock-screen, headset, CarPlay, and Android Auto controls
- Supports chapters, speed control, silence shortening, voice boost, smart rewind, and sleep timers
- Saves text or voice notes and exports them as Markdown
- Tracks listening time and completed books
- Edits metadata, covers, chapters, and track order offline
- Exports and restores the whole library as a JSON backup

Internal builds can also transcribe a selected passage with an on-device speech model. Store builds leave that code and its native packages out.

## How it is built

Bookish uses feature-first Flutter packages and a pragmatic MVI flow:

```text
Widget -> Cubit -> use case -> repository -> platform adapter
   ^                                      |
   +------------- immutable state --------+
```

`packages/bookish_player` owns the shared app and its feature modules. `apps/store` is the App Store and Google Play target. `apps/internal` adds local transcription through the independent `bookish_cactus_transcription` package. GetIt and Injectable wire dependencies, Sembast stores local data, and `go_router` owns navigation.

All four packages form one Dart workspace. Run `flutter pub get` once from the repository root. Pub maintains one root `pubspec.lock`; each app still declares and builds only its own dependencies. The shared lockfile includes Cactus because the internal app uses it, but the store app does not depend on it.

The boundary rules live in [docs/architecture.md](docs/architecture.md).

## Build it

You need Flutter, Dart, and either Android Studio with an Android SDK or Xcode with the iOS toolchain.

```sh
# Resolve the entire workspace once.
flutter pub get

# Develop either app independently.
cd apps/store # or apps/internal
flutter run

# Run shared checks from the core package.
cd ../../packages/bookish_player
flutter analyze
flutter test
```

Use `./tool/build_store.sh android` or `./tool/build_store.sh ios` for guarded store builds. Release signing values live under `signing/`; private credentials stay untracked.

In VS Code, open the repository root, select **Bookish: Debug**, **Bookish: Profile**,
or **Bookish: Release**, and press F5. Choose
`store` or `internal` from the dropdown. The pre-launch task resolves the whole
workspace using the saved lockfile; switching apps requires no manifest edits
or Git restore. Each target keeps its own native build output. Both app IDs
remain unchanged, so the targets replace the same installed app.

Keep app dependencies in each app's pubspec and shared dependencies in the core
package. Put compatibility overrides in the root pubspec because the workspace
uses one version of each dependency. Do not add Cactus to the store or core
package. After dependency changes, run `flutter pub get` at the root and commit
the single updated lockfile. `dart pub workspace list` lists all members.

The store verification script follows the store app's dependencies through the
shared graph and checks its generated plugin metadata. It intentionally does
not reject Cactus merely for appearing in the workspace lockfile. Guarded store
release builds also inspect archive entries for the excluded native libraries.
Run `bash tool/test_store_dependencies.sh` to test this guard.

Run adapter tests with `flutter test` from
`packages/bookish_cactus_transcription`; its PCM adapter uses Flutter plugins
and cannot run under plain `dart test`.
