#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
platform="${1:?Usage: bash tool/build_cactus.sh android|apple}"
case "$platform" in android|apple) ;; *) exit 2 ;; esac
revision=7e7eada40c387736dec138db003ab38f028f3a15
source_dir="$root/build/cactus-v2.0.1"
if [[ ! -d "$source_dir/.git" ]]; then
  git clone --depth 1 --branch v2.0.1 https://github.com/cactus-compute/cactus.git "$source_dir"
fi
[[ "$(git -C "$source_dir" rev-parse HEAD)" == "$revision" ]] || {
  echo 'Unexpected Cactus revision.' >&2; exit 1;
}
if ! git -C "$source_dir" apply --reverse --check "$root/tool/cactus-v2-local-only.patch" 2>/dev/null; then
  git -C "$source_dir" apply --check "$root/tool/cactus-v2-local-only.patch"
  git -C "$source_dir" apply "$root/tool/cactus-v2-local-only.patch"
fi
if ! git -C "$source_dir" apply --reverse --check "$root/tool/cactus-v2-ffi-exports.patch" 2>/dev/null; then
  git -C "$source_dir" apply --check "$root/tool/cactus-v2-ffi-exports.patch"
  git -C "$source_dir" apply "$root/tool/cactus-v2-ffi-exports.patch"
fi
if [[ "$platform" == android ]]; then
  if [[ -z "${ANDROID_NDK_HOME:-}" ]]; then
    echo "Set ANDROID_NDK_HOME to an installed Android NDK directory." >&2
    exit 1
  fi
  bash -e "$source_dir/android/build.sh"
  binary="$source_dir/android/libcactus_engine.so"
  nm_tool=("$ANDROID_NDK_HOME"/toolchains/llvm/prebuilt/*/bin/llvm-nm)
  exported_symbols="$("${nm_tool[0]}" -D --defined-only "$binary")"
  for symbol in bookish_cactus_init bookish_cactus_destroy bookish_cactus_transcribe bookish_cactus_get_last_error; do
    if ! grep -q " $symbol$" <<< "$exported_symbols"; then
      echo "Missing Android FFI export: $symbol" >&2
      exit 1
    fi
  done
else
  BUILD_STATIC=false bash -e "$source_dir/apple/build.sh"
  for slice in ios-arm64 ios-arm64-simulator; do
    binary="$source_dir/apple/cactus-ios.xcframework/$slice/cactus.framework/cactus"
    exported_symbols="$(nm -gU "$binary")"
    for symbol in cactus_init cactus_destroy cactus_transcribe cactus_get_last_error; do
      if ! grep -q " _$symbol$" <<< "$exported_symbols"; then
        echo "Missing iOS FFI export in $slice: $symbol" >&2
        exit 1
      fi
    done
  done
fi
