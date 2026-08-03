# Repository Guidelines

## Project Structure & Module Organization

Bookish is a Flutter audiobook player. Application code lives in `lib/`. Shared navigation, DI, database, theme, and reusable presentation code belong in `lib/core/`; feature code belongs in `lib/features/<feature>/` and is divided into `presentation`, optional `application`, `domain`, and `data` layers. Tests mirror that layout under `test/`, with architectural checks in `test/architecture/`. Platform projects are in `android/` and `ios/`; app artwork is in `assets/`, and media fixtures are in `test_samples/`. See `docs/architecture.md` before changing boundaries.

## Build, Test, and Development Commands

- `flutter pub get` resolves dependencies.
- `dart run build_runner build` regenerates Freezed, JSON, and Injectable output after annotated model or DI changes.
- `dart format lib test` formats handwritten Dart sources.
- `flutter analyze` runs the configured Flutter lints.
- `flutter test` runs unit, widget, parser, and architecture tests.
- `flutter run` launches the app on a selected device.

Run analysis and the full test suite before submitting changes. Do not hand-edit `*.freezed.dart`, `*.g.dart`, or `injection.config.dart`.

## Coding Style & Naming Conventions

Use two-space Dart indentation and let `dart format` control layout. Files use `snake_case.dart`; classes and enums use `UpperCamelCase`; methods and variables use `lowerCamelCase`. Follow the pragmatic MVI flow: widget → Cubit intent → application/domain contract → data adapter → immutable state. Ordinary widgets must not resolve `getIt` or import `data`. Data-only classes must use Freezed; private temporary shapes should use records or enums. Keep handwritten files within the limits enforced by `architecture_test.dart`.

## Testing Guidelines

Use `flutter_test`. Name files `<subject>_test.dart` and describe observable behavior, for example `player_cubit_test.dart`. Add Cubit tests for state transitions, widget tests for rendering/intent dispatch, and fixture-backed tests for media parsing. Any architecture or dependency change must keep `test/architecture/architecture_test.dart` passing.

## Commit & Pull Request Guidelines

Prefer concise Conventional Commit subjects such as `feat: add sleep timer` or `fix: clamp chapter seek`. Keep commits focused. Pull requests should explain behavior and architecture impact, list verification commands, link relevant issues, and include screenshots or recordings for visible UI changes. Call out generated files, persistence compatibility, and platform-specific testing when applicable.
