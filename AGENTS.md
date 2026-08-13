# Repository Guidelines

## Project Structure & Module Organization

Bookish is a Flutter audiobook player. Shared application code lives in `packages/bookish_player/lib/`. Shared navigation, DI, database, theme, and reusable presentation code belong in `packages/bookish_player/lib/core/`; feature code belongs in `packages/bookish_player/lib/features/<feature>/` and is divided into `cubits`, `models`, `repos`, `ui`, and `use_cases` as needed. Tests mirror that layout under `packages/bookish_player/test/`. Lintel enforces architectural boundaries through `dart analyze`. Store platform projects are in `apps/store/android/` and `apps/store/ios/`; internal platform projects are in `apps/internal/`. The optional Cactus adapter lives in `packages/bookish_cactus_transcription/` and must never become a dependency of `apps/store`. See `docs/architecture.md` before changing boundaries.

## Build, Test, and Development Commands

- Run shared development commands from `packages/bookish_player/`.
- `flutter pub get` resolves shared dependencies.
- `dart run build_runner build` regenerates Freezed, JSON, and Injectable output after annotated model or DI changes.
- `dart format lib test` formats handwritten Dart sources.
- `flutter analyze` runs the configured Flutter lints.
- `flutter test` runs unit, widget, and parser tests.
- `flutter run` launches the app on a selected device.
- `../../tool/verify_store_dependencies.sh` proves the store graph excludes Cactus and its FFmpeg adapter.
- `../../tool/build_store.sh android|ios` creates guarded store artifacts from `apps/store`.

Run analysis and the full test suite before submitting changes. Do not hand-edit `*.freezed.dart`, `*.g.dart`, or `injection.config.dart`.

## Coding Style & Naming Conventions

Use two-space Dart indentation and let `dart format` control layout. Files use `snake_case.dart`; classes and enums use `UpperCamelCase`; methods and variables use `lowerCamelCase`. Follow the pragmatic MVI flow: widget → Cubit intent → use case/repository contract → repository adapter → immutable state. Ordinary widgets must not resolve `getIt` or import repository implementations. Data-only classes must use Freezed; private temporary shapes should use records or enums. Keep handwritten files within the limits configured in `lintel.yaml`.

## Testing Guidelines

Use `flutter_test`. Name files `<subject>_test.dart` and describe observable behavior, for example `player_cubit_test.dart`. Add Cubit tests for state transitions, widget tests for rendering/intent dispatch, and fixture-backed tests for media parsing. Any architecture or dependency change must keep Lintel clean under `dart analyze`.

## Commit & Pull Request Guidelines

Prefer concise Conventional Commit subjects such as `feat: add sleep timer` or `fix: clamp chapter seek`. Keep commits focused. Pull requests should explain behavior and architecture impact, list verification commands, link relevant issues, and include screenshots or recordings for visible UI changes. Call out generated files, persistence compatibility, and platform-specific testing when applicable.
