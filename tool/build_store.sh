#!/usr/bin/env bash
set -euo pipefail

repository_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
store_root="$repository_root/apps/store"

cd "$store_root"
bash "$repository_root/tool/verify_store_dependencies.sh"

verify_archive() {
  local artifact="$1"
  local contents
  contents="$(unzip -Z1 "$artifact")"
  if grep -Eiq 'cactus|ffmpeg|libav(codec|device|filter|format|util)|libsw(resample|scale)|whisper' <<< "$contents"; then
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
