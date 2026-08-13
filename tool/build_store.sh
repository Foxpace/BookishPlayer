#!/usr/bin/env bash
set -euo pipefail

repository_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
store_root="$repository_root/apps/store"

cd "$store_root"
flutter pub get --enforce-lockfile

if flutter pub deps --style=compact | grep -Eiq '(^|[^a-z_])(cactus|ffmpeg_kit_flutter_new_audio)([^a-z_]|$)'; then
  echo "Store dependency graph contains a forbidden transcription package." >&2
  exit 1
fi

verify_archive() {
  local artifact="$1"
  if unzip -l "$artifact" | grep -Eiq 'cactus|ffmpeg'; then
    echo "Store artifact contains a forbidden transcription native artifact." >&2
    exit 1
  fi
}

case "${1:-}" in
  android)
    flutter build appbundle --release
    verify_archive build/app/outputs/bundle/release/app-release.aab
    ;;
  ios)
    flutter build ipa --release
    ipa_path="$(find build/ios/ipa -maxdepth 1 -name '*.ipa' -print -quit)"
    if [[ -z "$ipa_path" ]]; then
      echo "Flutter did not produce an IPA to verify." >&2
      exit 1
    fi
    verify_archive "$ipa_path"
    ;;
  *)
    echo "Usage: tool/build_store.sh <android|ios>" >&2
    exit 64
    ;;
esac
