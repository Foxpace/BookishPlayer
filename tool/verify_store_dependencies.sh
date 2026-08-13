#!/usr/bin/env bash
set -euo pipefail

repository_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repository_root/apps/store"

flutter pub get --enforce-lockfile

if flutter pub deps --style=compact | grep -Eiq '(^|[^a-z_])(cactus|ffmpeg_kit_flutter_new_audio)([^a-z_]|$)'; then
  echo "Store dependency graph contains a forbidden transcription package." >&2
  exit 1
fi

if grep -Eiq '(^|/)(cactus|ffmpeg_kit_flutter_new_audio)(/|$)' .flutter-plugins-dependencies; then
  echo "Store plugin metadata contains a forbidden transcription plugin." >&2
  exit 1
fi

echo "Store dependency graph is free of Cactus and its FFmpeg adapter."
