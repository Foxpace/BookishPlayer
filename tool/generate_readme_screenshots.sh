#!/usr/bin/env bash

set -euo pipefail

script_directory="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
repository_root="$(cd -- "$script_directory/.." && pwd)"
package_directory="$repository_root/packages/bookish_player"
screenshot_directory="$repository_root/docs/screenshots"

cd "$package_directory"
flutter test --update-goldens test/readme_screenshots_test.dart

for screenshot in library player settings; do
  test -s "$screenshot_directory/$screenshot.png"
done

echo "Updated README screenshots in $screenshot_directory"
