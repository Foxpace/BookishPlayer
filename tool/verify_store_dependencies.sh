#!/usr/bin/env bash
set -euo pipefail

repository_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repository_root/apps/store"

flutter pub get --enforce-lockfile

dart run "$repository_root/tool/verify_store_dependencies.dart"
