#!/bin/sh

set -eu

script_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
repo_dir=$(CDPATH= cd -- "$script_dir/../.." && pwd)
output_dir="$script_dir/assets"
phone_dir="$output_dir/phone"

if ! command -v magick >/dev/null 2>&1; then
  echo "ImageMagick 7 is required. Install it with: brew install imagemagick" >&2
  exit 1
fi

serif_font=""
for candidate in \
  "/System/Library/Fonts/Supplemental/Georgia Bold.ttf" \
  "/System/Library/Fonts/NewYork.ttf" \
  "/usr/share/fonts/truetype/dejavu/DejaVuSerif-Bold.ttf"
do
  if [ -f "$candidate" ]; then
    serif_font=$candidate
    break
  fi
done

if [ -z "$serif_font" ]; then
  echo "No supported bold serif font found." >&2
  exit 1
fi

icon_source="$repo_dir/apps/store/assets/icon/bookish_app_icon.png"
library_source="$repo_dir/docs/screenshots/library.png"
player_source="$repo_dir/docs/screenshots/player.png"
settings_source="$repo_dir/docs/screenshots/settings.png"

for source in "$icon_source" "$library_source" "$player_source" "$settings_source"; do
  if [ ! -f "$source" ]; then
    echo "Missing source asset: $source" >&2
    exit 1
  fi
done

mkdir -p "$phone_dir"

# Google Play icon: 512 x 512, 32-bit PNG, with the original artwork preserved.
magick "$icon_source" \
  -filter Lanczos -resize 512x512! -alpha on -define png:color-type=6 \
  "$output_dir/app-icon-512.png"

# Feature graphic: actual Bookish UI using the exact dark-theme colors. No text
# is baked in, so the same graphic can be used for every listing locale.
magick -size 1024x500 xc:'#171612' \
  -fill '#211f1a' -stroke '#3b382f' -strokewidth 2 \
  -draw 'roundrectangle 160,18 404,482 22,22' \
  -draw 'roundrectangle 620,18 864,482 22,22' \
  -fill '#211f1a' -stroke '#bd6c3b' -strokewidth 3 \
  -draw 'roundrectangle 380,10 644,490 24,24' \
  \( "$library_source" -filter Lanczos -resize 210x456! \) \
  -gravity center -geometry -228+0 -composite \
  \( "$player_source" -filter Lanczos -resize 242x456! \) \
  -gravity center -geometry +0+0 -composite \
  \( "$settings_source" -filter Lanczos -resize 210x456! \) \
  -gravity center -geometry +228+0 -composite \
  -alpha off -define png:color-type=2 \
  "$output_dir/feature-graphic-1024x500.png"

make_phone_asset() {
  source=$1
  title=$2
  destination=$3
  point_size=$4

  magick -size 1080x1920 xc:'#171612' \
    -fill '#211f1a' -stroke '#3b382f' -strokewidth 3 \
    -draw 'roundrectangle 146,246 934,1898 28,28' \
    -fill '#bd6c3b' -stroke none \
    -draw 'roundrectangle 450,208 630,214 3,3' \
    -font "$serif_font" -fill '#f4eee4' -gravity north \
    -pointsize "$point_size" -annotate +0+76 "$title" \
    \( "$source" -filter Lanczos -resize 740x1602! \) \
    -gravity north -geometry +0+270 -composite \
    -alpha off -define png:color-type=2 "$destination"
}

make_phone_asset "$library_source" \
  "Your books. Your device." \
  "$phone_dir/01-library.png" 64
make_phone_asset "$player_source" \
  "Built for long listening." \
  "$phone_dir/02-player.png" 62
make_phone_asset "$player_source" \
  "Chapters, notes, sleep timer." \
  "$phone_dir/03-listening-tools.png" 54
make_phone_asset "$settings_source" \
  "Insights and storage controls" \
  "$phone_dir/04-settings.png" 56

assert_image() {
  path=$1
  expected_size=$2
  max_bytes=$3
  actual_size=$(magick identify -format '%wx%h' "$path")
  actual_bytes=$(wc -c < "$path" | tr -d ' ')

  if [ "$actual_size" != "$expected_size" ]; then
    echo "Wrong dimensions for $path: $actual_size, expected $expected_size" >&2
    exit 1
  fi
  if [ "$actual_bytes" -gt "$max_bytes" ]; then
    echo "File too large: $path is $actual_bytes bytes" >&2
    exit 1
  fi
}

assert_image "$output_dir/app-icon-512.png" "512x512" 1048576
assert_image "$output_dir/feature-graphic-1024x500.png" "1024x500" 15728640
for screenshot in "$phone_dir"/*.png; do
  assert_image "$screenshot" "1080x1920" 8388608
done

echo "Google Play assets are ready in $output_dir"
