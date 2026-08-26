# Repository Guidelines

## Project

Bookish is a Flutter audiobook player.

It is local first player where everything lives locally - player, books, data, transcription, settings and everything else.
It is designed to be self sufficient and simple with warm interface for any user.

## Project Organization

Shared application code lives in `packages/bookish_player/lib/`. Shared navigation, DI, database, theme, and reusable presentation code belong in `packages/bookish_player/lib/core/`; feature code belongs in `packages/bookish_player/lib/features/<feature>/` and is divided into `cubits`, `models`, `repos`, `ui`, and `use_cases` as needed. Tests mirror that layout under `packages/bookish_player/test/`. Lintel enforces architectural boundaries through `dart analyze`.

The app has two versions:

- public one - store platform projects are in `apps/store/android/` and `apps/store/ios/`; internal platform projects are in `apps/internal/`. - repo only - optional Cactus adapter lives in `packages/bookish_cactus_transcription/` and must never become a dependency of `apps/store`. See `docs/architecture.md` before changing boundaries.

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

## Coding Style & Naming Conventions

The implementation should be simple, verbose and straighforward. Avoid cleverness, and prefer clarity over brevity, but over all, keep it simple. Think about solution and architecture before writing code. Avoid premature optimization, and prefer readable code over clever code.

Follow the pragmatic MVI flow: widget → Cubit intent → use case/repository contract → repository adapter → immutable state. Ordinary widgets must not resolve `getIt` or import repository implementations. Data-only classes must use Freezed. Private temporary shapes should use records or enums. Keep handwritten files within the limits configured in `lintel.yaml`.

There is no exception to the rule to MVI flow. If you find yourself needing to break it, consider if the feature is too complex and needs to be split into smaller features. Prefer deep modules - screen with its implementation is one folder. Cross cutting concerns are their own modules. Avoid deep nesting of any kind.

Prefer only user intent naming in all variables, methods and classes. Avoid implementation details in names, abbreviation or vague names. Avoid using `get` or `set` in names. Avoid using `manager`, `controller`, `helper`, `util`, `service`, `provider`, `repository` in names, they are however permitted for classes implementing a contract.

Exceptions are handled centrally by the error handler with united error class. Avoid throwing exceptions and only return result class of this project. Try and catch are allowed only in repository layer when working with thrird party libraries.

## Testing Guidelines

Every layer should be tested. Repos should be tested with appropriate fakes. Bloc with the repos and its fakes. UI shall be kept dumb and consume state coming from the Cubit only. No GetIt or other service locators shall be used in the UI layer.

Follow BDD testing with `given`, `when`, `then` structure. Use `testWidgets` for UI tests, and `test` for Cubit and repository tests. Use `mocktail` for mocking dependencies. Avoid testing implementation details; focus on behavior and outcomes.

## Commit & Pull Request Guidelines

Prefer concise Conventional Commit subjects such as `feat: add sleep timer` or `fix: clamp chapter seek`. Keep commits focused. Pull requests should explain behavior and architecture impact, list verification commands, link relevant issues, and include screenshots or recordings for visible UI changes. Call out generated files, persistence compatibility, and platform-specific testing when applicable.

## Talking to the team

You are agent, me / user is the user of this app and programmer of it.

Talk to me in explicit and clear way, avoid vague statements without any ground. Point out architectural issues, code smells, and potential problems. Feel free to work on them without asking me, but always explain what you are doing.
