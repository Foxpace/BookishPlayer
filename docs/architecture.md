# Bookish architecture

Bookish uses one shared feature package and two application targets. The
`apps/store` dependency graph excludes optional transcription native packages;
`apps/internal` registers the adapter exported by
`packages/bookish_cactus_transcription`. Both targets consume
`packages/bookish_player`, which uses feature-first modules with a pragmatic
MVI loop:

```text
Widget -> Cubit intent -> application module -> repository port -> adapter
   ^                                                           |
   +-------------------- immutable state -----------------------+
```

## Feature structure

```text
feature/
  feature_screen_root.dart
  cubits/              # screen Cubit, state, and UI intents
  models/              # feature-owned value types
  repos/               # ports and implementations/
  use_cases/           # cohesive application modules and domain policies
  ui/
    feature_screen.dart
    widgets/
```

- A `ScreenRoot` is the composition boundary. It resolves one Cubit, supplies
  route input, connects Bloc listeners/builders, handles navigation, and passes
  immutable state plus typed callbacks to `ui`.
- Ordinary widgets do not import Bloc, Cubits, repositories, use cases, or the
  router. They do not resolve GetIt, access files, read clocks, or perform
  product work.
- Widgets may own ephemeral controllers, focus, validation, animation, and
  modal lifecycle. Product actions still leave through typed callbacks. Use an
  enum or Freezed action instead of string commands.
- Give each reusable or visually independent public widget its own file. Small
  private helper widgets may stay with their parent.
- A Cubit owns and emits all screen state. It receives one feature-specific
  application module and exposes user or system intents.
- Application modules expose verb-led behavior and hide repositories, policies,
  command ordering, subscriptions, timers, and other resource handles. A module
  may contain an occasional pass-through operation, but its interface as a
  whole must provide useful depth through coordination, policy, translation,
  or result construction.
- Avoid one-operation wrapper classes and public field bags. Inject a contract
  directly when no behavior is worth hiding.
- Start independent asynchronous work together; preserve ordering only when an
  operation needs a previous result.
- Repository ports isolate packages, files, databases, codecs, and platform
  APIs. Implementations live under the owning feature's `repos` folder.
- Models are framework-free unless they are Cubit state.

- Put shared UI primitives in `core` and feature-aware UI in its owning feature.
- Use `BookishScaffold` for routed screens.
- Keep shared fonts and diagnostic text styles in `BookishTheme`.

## Capability ownership

| Capability | Owns |
| --- | --- |
| `app` | App-wide startup, reset coordination, and target composition |
| `library` | Audiobooks, metadata, catalog persistence, history, filtering, grouping, and removal |
| `importing` | File selection, media probing, import processing, cleanup, and source removal |
| `editing` | Metadata and chapter editing |
| `player` | Playback, queueing, progress, sessions, completion, sleep timers, and player UI |
| `notes` | Note capture, detail, gallery, voice notes, sharing, and Markdown export |
| `transcription` | Quote transcription, speech models, preferences, and clip preparation |
| `portability` | Backup validation, export, and transactional restore |
| `storage` | Library inspection, cleanup assistance, and persistent data deletion |
| `settings` | Preferences and local diagnostic controls |

- Keep numbered audiobook files as separate import inputs.
- Treat grouping and ordering as explicit user actions, not persistence or
  folder-name conventions.
- Run imports on their own route and return a structured result containing the
  final status, committed count, and failed item. The library reloads whenever
  at least one book was committed, even if a later item failed or was cancelled.
- Block ambient back navigation while import work is active. Explicit
  cancellation interrupts file copying, waits for parsing and persistence to
  reach a safe boundary, removes only pending files, and preserves completed
  books.
- Keep failed item names in ephemeral presentation state. Copyable diagnostics
  contain classified stages and timings but omit book names, titles, paths, raw
  exceptions, and stack traces.

## Dependency direction

Feature dependencies must remain acyclic:

```text
app/router/ScreenRoot
  -> library, importing, editing, player, notes, transcription,
     insights, storage, portability, settings

importing     -> library repository ports
editing       -> library repository ports + media/file-picker ports
player        -> library repository ports + notes repository ports
notes         -> library repository ports
transcription -> transcription and preference ports
insights      -> library history ports
storage       -> library and storage repository ports
portability   -> library/notes/settings repository ports
```

- Cross-feature orchestration may use another feature's repository port. App-wide
  workflows live under `app/use_cases/` and own their full command sequence.
- Compose cross-feature presentation only in app, router, or `ScreenRoot` code.
- Never import another feature's repository implementation.

## State and effects

- Each screen or workflow has one Cubit state stream.
- Every Cubit state is Freezed. Loading, progress, success, typed failures, and
  revisioned one-time effects are explicit state.
- Screen and retry context belongs in state, not parallel mutable Cubit fields.
  Non-rendering bookkeeping uses one immutable Freezed runtime state. Only
  lifecycle handles, such as a cancellable timer, may remain separately mutable.
- Advance effect revisions from the emitted state; do not duplicate them in a
  private counter.
- Widgets localize typed message identifiers. Cubits do not expose localized
  strings or raw exceptions. English and Slovak ARB entries must stay aligned.
- Data-only classes use Freezed. Prefer records or enums for small private
  parser and worker shapes.
- Route persistence, playback, transcription, file work, and sharing through
  repository ports.

## Player

- Make `PlayerCubit` the sole owner of mutable player product and presentation
  state.
- Allow audio services, policies, trackers, savers, and coordinators to retain
  dependencies and platform-resource handles only.
- Do not store the active book, progress, completion, session, sleep timer, or
  screen state outside `PlayerCubit`.
- Publish external audio and CarPlay actions as typed `PlaybackBookRequest`s.
  `PlayerCubit` consumes each request, opens the book, emits state, and
  completes the request.

## Dependency injection

- Use GetIt as the runtime container and Injectable for generated registrations.
- Keep `configureDependencies` configurable with an optional container and
  environment so tests can create isolated graphs.
- Register app-lifetime Cubits as lazy singletons and route Cubits as factories.
- Use `AppModule` only to construct third-party objects.
- Use annotations and constructor injection for Bookish services, adapters,
  clocks, ID generators, diagnostics, media probes, preference ports, and
  bootstrap code.
- Initialize audio and CarPlay from `AppBootstrapper`.

## Persistence and diagnostics

- Sembast storage is schema-versioned and migrated in order.
- Restore validates versions, record shapes, references, and payloads before a
  transactional replacement.
- Library removal remains atomic across catalog, metadata, notes, and history.
- Cleanup failures are structured results, not discarded errors.
- Local diagnostics are bounded and store only the operation, sanitized error,
  stack, timestamp, platform, and build metadata. Never store absolute paths or
  user content such as titles, notes, transcripts, or audio.
- Diagnostics can be exported or deleted locally. There is no remote telemetry.

## Maintainability

- Give methods verb-led names and one cohesive responsibility.
- Limit a `try` or `catch` body to one delegated operation; extract multi-step
  work.
- Separate setup, validation, transformation, side effects, and result
  construction with blank lines.

Architecture limits for handwritten production code:

| Scope | Limit |
| --- | ---: |
| File or class | 300 lines |
| Behavior method | 90 lines |
| Flutter `build` method | 60 lines |
| Consecutive nonblank lines in a non-UI callable | 19 lines |
| `PlayerCubit` class / file | 500 / 550 lines |

- Exclude generated files and test-registration `main` functions where the
  checks allow it.
- Keep every Lintel diagnostic enabled in `analysis_options.yaml`; configure
  project-specific numeric thresholds in `lintel.yaml`.

## Test structure

- Mirror feature ownership under `test/`; keep only genuinely cross-feature
  helpers in `test/support`.
- Name test files `<subject>_test.dart`.
- Name `group` blocks after the subject or context. Do not use Given/When/Then
  as group names.
- Write every `test` and `testWidgets` description as
  `Given ..., When ..., Then ...`.
- Use `// GIVEN`, `// WHEN`, and `// THEN` comments only when the corresponding
  phase has code. Omit empty phase comments.
- Test behavior at the narrowest useful boundary:
  - unit tests for models, policies, use cases, parsers, and repositories;
  - Cubit tests for intents and emitted state;
  - widget tests for rendering, interaction, navigation, and effects;
  - golden tests for important locale, theme, and layout variants;
  - Lintel diagnostics for dependency and maintainability rules.
- Use feature-local builders to assemble a subject with explicit dependencies.
- Use a small harness when a test repeatedly coordinates a Cubit, widget tree,
  streams, or lifecycle. Keep assertions out of harnesses.
- Use feature-local robots for substantial user-visible screen flows, not every
  widget test. Robots expose user actions and visible outcomes; the shared
  `WidgetRobot` owns low-level Flutter mechanics.
- Keep fixture values, localized labels, and product assertions in the test
  body, not in robots.
- Prefer small explicit fakes with call logs, controllable results, streams, and
  failures. Implement the full contract; do not use `noSuchMethod`.
- Use shared deterministic fixtures, `FakeClock`, `FakeIdGenerator`, and
  `pumpBookishApp` when applicable.
- Close Cubits, controllers, subscriptions, and streams with `tearDown` or
  `addTearDown`.

Run local verification with:

```sh
dart format lib test
flutter analyze
flutter test
dart run tool/widget_audit.dart
dart run tool/code_readability_audit.dart --minimum=20 --fail-at=20
```
