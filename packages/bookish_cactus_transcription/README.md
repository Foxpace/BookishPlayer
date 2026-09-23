# Bookish Cactus adapter

The internal app uses Cactus v2.0.1 for on-device transcription. Native source
is pinned to `7e7eada40c387736dec138db003ab38f028f3a15`. The store app has
no Cactus dependency.

## Build from a clone

Install Flutter 3.47+ with Dart 3.13+, Git, and CMake. Android needs SDK 37 and
an NDK. iOS needs Xcode; its simulator build needs an Apple Silicon Mac.

```sh
git clone https://github.com/Foxpace/BookishPlayer.git
cd BookishPlayer
flutter pub get
```

Run these commands from the repository root. The first build downloads and
compiles Cactus; later builds reuse it.

### Android arm64

Set `ANDROID_NDK_HOME` to your installed NDK. Replace `VERSION` in this macOS
example:

```sh
export ANDROID_NDK_HOME="$HOME/Library/Android/sdk/ndk/VERSION"
test -f "$ANDROID_NDK_HOME/build/cmake/android.toolchain.cmake"
(cd apps/internal && flutter build apk --debug --target-platform android-arm64)
```

Release builds also need `signing/android/key.properties`. Copy the example in
that directory and supply your own keystore details.

### iOS arm64

```sh
(cd apps/internal && flutter build ios --simulator --no-codesign)
```

For a physical device, copy `signing/ios/Signing.local.xcconfig.example` to
`signing/ios/Signing.local.xcconfig`, enter your Apple team ID, and run the
internal app on the device. Cactus needs iOS 16.4+.

## How it works

Flutter finds `hook/build.dart` through the internal app's package dependency.
The hook checks the requested architecture, runs `tool/build_cactus.sh` when
needed, and registers the resulting library as a bundled code asset. Flutter
puts `libcactus_engine.so` in the Android APK or `cactus.framework` in the iOS
app. `lib/src/vendor/cactus.dart` opens that library and calls the C API.

The script checks out the pinned Cactus commit under ignored `build/`, applies
the local-only and Android FFI export patches in `tool/`, and builds the native
library. The patches disable telemetry initialization and cloud handoff, and
export the C functions that Dart FFI calls on Android. Cactus is not packaged
through a separate Swift package or copied into Android `jniLibs` by hand.

## Caveats

- This adapter supports arm64 only. Android needs
  `--target-platform android-arm64`. The internal iOS `.xcconfig` files exclude
  x86_64 simulators; Intel Mac simulators are unsupported.
- A fresh build needs network access for the Cactus source. Speech models are
  separate downloads inside the app. Transcription runs locally afterward.
- `flutter clean` leaves the ignored native checkout under `build/`. The hook
  rebuilds when its binary is missing or older than the build script or patch.
  If you edit native source there, run `bash tool/build_cactus.sh android` or
  `bash tool/build_cactus.sh apple` before rebuilding the app.
- If the script reports an unexpected revision or patch failure, inspect local
  edits in `build/cactus-v2.0.1/` before removing that generated checkout.
- When upgrading Cactus, update the pinned commit, patches, hook paths, FFI
  bindings, and model format together. Keep the adapter out of `apps/store`;
  check with `bash tool/test_store_dependencies.sh`.

## Models and inference

The app offers pinned Whisper base and Parakeet TDT 0.6B v2/v3 CQ4 bundles.
Other published speech archives have not been verified with this pinned Cactus
runtime. Models live under `cactus-v2.0.1/models`; users must redownload after
migrating from the old plugin. Saved tiny selections fall back to base.

FFmpeg decodes the selected passage to 16 kHz mono PCM. Whisper detects the
language before transcription; Parakeet transcribes directly. Inference runs
in an isolate, one request at a time. Each request loads and releases its
model, and temporary audio is removed afterward.

References: [Flutter native code hooks](https://docs.flutter.dev/platform-integration/bind-native-code),
[Cactus v2.0.1](https://github.com/cactus-compute/cactus/tree/v2.0.1).
