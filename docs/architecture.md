# Bookish architecture

Bookish uses feature-first modules with a pragmatic MVI presentation loop:

```text
Widget -> Cubit intent -> application workflow/domain port -> data adapter
   ^                                                        |
   +---------------- immutable state -----------------------+
```

## Layer responsibilities

- `presentation` renders immutable state, dispatches named Cubit intents, and performs navigation or modal presentation from listeners. Widgets may own only controllers, focus, animation, and other unpersisted UI mechanics.
- `application` contains multi-step, pure-Dart workflows. It depends on domain entities and ports, never Flutter or data implementations.
- `domain` contains entities and abstract ports. It does not depend on Flutter, presentation, or data.
- `data` implements domain ports and owns packages, files, databases, codecs, and platform APIs.
- `ScreenRoot`, navigation, DI, and app startup are composition boundaries. `getIt` must not appear in ordinary widgets.

Cross-feature orchestration may depend on another feature's domain port. Presentation-to-data imports are never allowed. Shared UI primitives belong in `core`; feature-aware UI stays with its owning feature.

## State and effects

Each cohesive screen or workflow has one Cubit state stream. Public Cubit methods are user/system intents. Loading, progress, success, and failure are explicit state. `BlocListener` translates state transitions into navigation, sheets, dialogs, and snackbars. Persistence, transcription, playback, file work, and sharing enter through domain ports.

All classes whose sole responsibility is carrying data use Freezed for immutable fields, value equality, diagnostics, and `copyWith`. Small private parser/worker shapes use Dart records or enums instead of ad-hoc data classes. The architecture test detects future handwritten data-only classes that omit `@freezed`.

## Maintainability guard

`test/architecture/architecture_test.dart` parses handwritten Dart with the analyzer and enforces import direction and size budgets. Generated files are excluded. Files are capped at 300 lines; classes at 300; behavior methods at 100; declarative Flutter `build` methods at 180. These AST-aware callable limits account for formatter-expanded Flutter trees while keeping orchestration methods substantially smaller. Test registration `main` functions are exempt.
