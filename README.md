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

Screens use the public-domain LibriVox recording of [_Alice's Adventures in Wonderland_](https://librivox.org/alices-adventures-in-wonderland-by-lewis-carroll-5/).

Bookish treats an audiobook as a book, not a loose playlist. Import it once, keep it on the device, and return to the exact chapter and position later. Notes, history, covers, preferences, and backups remain local too.

## Features

- Import, organize, and edit audiobooks offline
- Play by chapter with speed, audio, rewind, and sleep controls
- Use lock-screen, headset, CarPlay, and Android Auto controls
- Save text or voice notes and export them as Markdown
- Track listening history and completed books
- Back up and restore the local library as JSON

Internal builds can also transcribe a selected passage with an on-device speech model. Store builds leave that code and its native packages out.

## Project structure

The Dart workspace has four members. `packages/bookish_player` contains the
shared app. `apps/store` is the public target, while `apps/internal` adds
`packages/bookish_cactus_transcription`. The store target never depends on
Cactus.

Features follow an MVI flow:

```text
Widget -> Cubit -> use case -> repository -> platform adapter
   ^                                      |
   +------------- immutable state --------+
```

The workspace uses one root lockfile. See [docs/architecture.md](docs/architecture.md)
for module and dependency rules.

## Development

Use Flutter 3.47 or newer with Dart 3.13 or newer. Android builds require
SDK 37 and use AGP 9.1.1 with Gradle 9.3.1. Install the platform toolchain, then run:

```sh
flutter pub get

cd apps/store # or apps/internal
flutter run

cd ../../packages/bookish_player
flutter analyze
flutter test
```

For iOS builds, create the ignored local signing file and replace
`YOUR_TEAM_ID` with your Apple development team:

```sh
cp signing/ios/Signing.local.xcconfig.example \
  signing/ios/Signing.local.xcconfig
```

Use `./tool/build_store.sh android` or `./tool/build_store.sh ios` for guarded
store builds. CI must create its own local signing file before iOS builds.

Run `bash tool/test_store_dependencies.sh` to test the store dependency guard.

The internal app builds its pinned native Cactus runtime through a Flutter build
hook. See [the adapter setup guide](packages/bookish_cactus_transcription/README.md)
for fresh-clone steps, supported targets, and caveats.

Run adapter tests with `flutter test` from
`packages/bookish_cactus_transcription`.

VS Code launch configurations at the repository root can run either app in
debug, profile, or release mode.
