#!/usr/bin/env bash

set -Eeuo pipefail

SCRIPT_NAME="$(basename -- "$0")"
PACKAGE_NAME="com.tomasrepcik.bookish"
BUILD_NAME=""
BUILD_NUMBER=""
PLAY_TRACK="internal"
RELEASE_STATUS="draft"
PROJECT_DIR="."
AAB_PATH="build/app/outputs/bundle/release/app-release.aab"
OUTPUT_PATH="build/app/outputs/bundle/release/app-release-signed.aab"
VALIDATE_ONLY=false
BUILD_FLOOR=0
BUILD_EPOCH=1788566400 # 2026-09-05

generate_build_name() {
  date -u '+%Y.%m.%d.%H'
}

generate_build_number() {
  local now_utc

  now_utc="$(date -u '+%s')"
  printf '%s\n' "$((BUILD_FLOOR + 1 + (now_utc - BUILD_EPOCH) / 60))"
}

usage() {
  cat <<EOF
Build, sign, and upload a Flutter Android App Bundle using environment secrets.

Usage:
  $SCRIPT_NAME \\
    --package-name com.example.app \\
    [--build-name 2026.09.05.14] \
    [--build-number 31] \\
    [--track internal] \\
    [--release-status draft] \\
    [--project-dir PATH] \\
    [--aab-path PATH] \\
    [--output PATH] \\
    [--validate-only]

Required environment variables:
  ANDROID_GRADLE_ALIAS
  ANDROID_GRADLE_BASE64_JKS
  ANDROID_GRADLE_KEY_PASSWORD
  ANDROID_GRADLE_KEYSTORE_PASSWORD
  ANDROID_SUPPLY_BASE64_SECRET

ANDROID_SUPPLY_BASE64_SECRET must contain the base64-encoded Google Play
service-account JSON key. Both --build-name and --build-number are optional.
If omitted, --build-name is generated in UTC using the yyyy.mm.dd.hh format and
--build-number is generated in UTC from the release epoch using minute steps:
BUILD_FLOOR + 1 + (now - BUILD_EPOCH) / 60. The default destination is an
internal draft release. The default AAB path is
build/app/outputs/bundle/release/app-release.aab and the default signed output
path is build/app/outputs/bundle/release/app-release-signed.aab.
EOF
}

die() {
  printf 'Error: %s\n' "$*" >&2
  exit 1
}

require_command() {
  command -v "$1" >/dev/null 2>&1 || die "Required command not found: $1"
}

require_environment_variable() {
  [[ -n "${!1:-}" ]] || die "Required environment variable is missing: $1"
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --package-name)
      [[ $# -ge 2 ]] || die "Missing value for $1"
      PACKAGE_NAME="$2"
      shift 2
      ;;
    --build-name)
      [[ $# -ge 2 ]] || die "Missing value for $1"
      BUILD_NAME="$2"
      shift 2
      ;;
    --build-number)
      [[ $# -ge 2 ]] || die "Missing value for $1"
      BUILD_NUMBER="$2"
      shift 2
      ;;
    --track)
      [[ $# -ge 2 ]] || die "Missing value for $1"
      PLAY_TRACK="$2"
      shift 2
      ;;
    --release-status)
      [[ $# -ge 2 ]] || die "Missing value for $1"
      RELEASE_STATUS="$2"
      shift 2
      ;;
    --project-dir)
      [[ $# -ge 2 ]] || die "Missing value for $1"
      PROJECT_DIR="$2"
      shift 2
      ;;
    --aab-path)
      [[ $# -ge 2 ]] || die "Missing value for $1"
      AAB_PATH="$2"
      shift 2
      ;;
    --output)
      [[ $# -ge 2 ]] || die "Missing value for $1"
      OUTPUT_PATH="$2"
      shift 2
      ;;
    --validate-only)
      VALIDATE_ONLY=true
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      die "Unknown argument: $1"
      ;;
  esac
done

[[ -n "$PACKAGE_NAME" ]] || die "--package-name is required"
[[ "$PACKAGE_NAME" =~ ^[A-Za-z][A-Za-z0-9_]*(\.[A-Za-z][A-Za-z0-9_]*)+$ ]] || \
  die "--package-name is not a valid Android application ID"
if [[ -z "$BUILD_NAME" ]]; then
  BUILD_NAME="$(generate_build_name)"
fi
if [[ -z "$BUILD_NUMBER" ]]; then
  BUILD_NUMBER="$(generate_build_number)"
fi
[[ -n "$BUILD_NAME" ]] || die "Could not determine --build-name"
[[ "$BUILD_NUMBER" =~ ^[1-9][0-9]*$ ]] || die "--build-number must be a positive integer"

case "$PLAY_TRACK" in
  internal|alpha|beta|production) ;;
  *) die "--track must be internal, alpha, beta, or production" ;;
esac

case "$RELEASE_STATUS" in
  draft|completed|halted|inProgress) ;;
  *) die "--release-status must be draft, completed, halted, or inProgress" ;;
esac

require_command flutter
require_command ruby
require_command keytool
require_command jarsigner
require_command zip
require_command unzip

require_environment_variable ANDROID_GRADLE_ALIAS
require_environment_variable ANDROID_GRADLE_BASE64_JKS
require_environment_variable ANDROID_GRADLE_KEY_PASSWORD
require_environment_variable ANDROID_GRADLE_KEYSTORE_PASSWORD
require_environment_variable ANDROID_SUPPLY_BASE64_SECRET

PROJECT_DIR="$(cd -- "$PROJECT_DIR" && pwd -P)"
[[ -f "$PROJECT_DIR/pubspec.yaml" ]] || die "No pubspec.yaml found in $PROJECT_DIR"
SIGNING_DIRECTORY="$(cd -- "$PROJECT_DIR/../.." && pwd -P)/signing/android"
FASTLANE_DIRECTORY="$PROJECT_DIR"
FASTLANE_GEMFILE_PATH="$FASTLANE_DIRECTORY/Gemfile"

require_command bundle
[[ -f "$FASTLANE_GEMFILE_PATH" ]] || \
  die "Fastlane must run with bundle exec. Add a Gemfile at $FASTLANE_GEMFILE_PATH"
fastlane_command=(bundle exec fastlane)

umask 077
release_tmp="$(mktemp -d "${TMPDIR:-/tmp}/flutter-android-release.XXXXXX")"
keystore_path="$release_tmp/upload.jks"
play_secret_path="$release_tmp/google-play-service-account.json"
unsigned_copy="$release_tmp/app-unsigned.aab"
key_properties_path="$SIGNING_DIRECTORY/key.properties"
key_properties_backup_path=""

cleanup() {
  local exit_code=$?

  # Prevent recursion when cleanup exits and ensure secrets are no longer
  # available to any commands executed after this point.
  trap - EXIT HUP INT TERM
  unset \
    ANDROID_GRADLE_ALIAS \
    ANDROID_GRADLE_BASE64_JKS \
    ANDROID_GRADLE_KEY_PASSWORD \
    ANDROID_GRADLE_KEYSTORE_PASSWORD \
    ANDROID_SUPPLY_BASE64_SECRET

  if [[ -n "${key_properties_path:-}" ]]; then
    if [[ -n "${key_properties_backup_path:-}" && -f "$key_properties_backup_path" ]]; then
      if ! cp -- "$key_properties_backup_path" "$key_properties_path"; then
        printf 'Error: could not restore Gradle signing properties: %s\n' \
          "$key_properties_path" >&2
        [[ $exit_code -ne 0 ]] || exit_code=1
      fi
    elif [[ -f "$key_properties_path" ]]; then
      if ! rm -f -- "$key_properties_path"; then
        printf 'Error: could not remove generated Gradle signing properties: %s\n' \
          "$key_properties_path" >&2
        [[ $exit_code -ne 0 ]] || exit_code=1
      fi
    fi
  fi

  if [[ -n "${release_tmp:-}" && -d "$release_tmp" ]]; then
    if ! rm -rf -- "$release_tmp"; then
      printf 'Error: could not remove temporary credential directory: %s\n' \
        "$release_tmp" >&2
      [[ $exit_code -ne 0 ]] || exit_code=1
    fi
  fi

  exit "$exit_code"
}

trap cleanup EXIT
trap 'exit 129' HUP
trap 'exit 130' INT
trap 'exit 143' TERM

ruby -rbase64 -e '
  encoded = ENV.fetch(ARGV.fetch(0)).gsub(/\s+/, "")
  File.binwrite(ARGV.fetch(1), Base64.strict_decode64(encoded))
' ANDROID_GRADLE_BASE64_JKS "$keystore_path" || die "Could not decode ANDROID_GRADLE_BASE64_JKS"

ruby -rbase64 -rjson -e '
  encoded = ENV.fetch(ARGV.fetch(0)).gsub(/\s+/, "")
  decoded = Base64.strict_decode64(encoded)
  JSON.parse(decoded)
  File.binwrite(ARGV.fetch(1), decoded)
' ANDROID_SUPPLY_BASE64_SECRET "$play_secret_path" || \
  die "ANDROID_SUPPLY_BASE64_SECRET is not valid base64-encoded JSON"

chmod 600 "$keystore_path" "$play_secret_path"

keytool -list \
  -keystore "$keystore_path" \
  -storetype JKS \
  -storepass:env ANDROID_GRADLE_KEYSTORE_PASSWORD \
  -alias "$ANDROID_GRADLE_ALIAS" >/dev/null || \
  die "Could not open the JKS or find alias '$ANDROID_GRADLE_ALIAS'"

mkdir -p -- "$SIGNING_DIRECTORY"
if [[ -f "$key_properties_path" ]]; then
  key_properties_backup_path="$release_tmp/key.properties.backup"
  cp -- "$key_properties_path" "$key_properties_backup_path"
fi

cat > "$key_properties_path" <<EOF
storeFile=$keystore_path
storePassword=$ANDROID_GRADLE_KEYSTORE_PASSWORD
keyAlias=$ANDROID_GRADLE_ALIAS
keyPassword=$ANDROID_GRADLE_KEY_PASSWORD
EOF

chmod 600 "$key_properties_path"

cd "$PROJECT_DIR"

printf 'Running Flutter checks...\n'
flutter pub get

printf 'Using build name %s and build number %s (generated from UTC time when omitted).\n' "$BUILD_NAME" "$BUILD_NUMBER"
printf 'Building Flutter AAB %s (%s)...\n' "$BUILD_NAME" "$BUILD_NUMBER"
flutter build appbundle --release \
  --build-name="$BUILD_NAME" \
  --build-number="$BUILD_NUMBER"

if [[ -n "$AAB_PATH" ]]; then
  [[ "$AAB_PATH" = /* ]] || AAB_PATH="$PROJECT_DIR/$AAB_PATH"
else
  release_dir="$PROJECT_DIR/build/app/outputs/bundle/release"
  candidates=()
  while IFS= read -r candidate; do
    candidates+=("$candidate")
  done < <(find "$release_dir" -maxdepth 1 -type f -name '*.aab' ! -name '*-signed.aab' | sort)

  [[ ${#candidates[@]} -gt 0 ]] || die "Flutter build completed but no AAB was found in $release_dir"
  [[ ${#candidates[@]} -eq 1 ]] || \
    die "Multiple AAB files found; select one with --aab-path"
  AAB_PATH="${candidates[0]}"
fi

[[ -f "$AAB_PATH" ]] || die "AAB not found: $AAB_PATH"

if [[ -z "$OUTPUT_PATH" ]]; then
  OUTPUT_PATH="${AAB_PATH%.aab}-signed.aab"
elif [[ "$OUTPUT_PATH" != /* ]]; then
  OUTPUT_PATH="$PROJECT_DIR/$OUTPUT_PATH"
fi

mkdir -p -- "$(dirname -- "$OUTPUT_PATH")"
cp -- "$AAB_PATH" "$unsigned_copy"

# Flutter projects are sometimes configured to sign release builds already.
# Remove only JAR signature records from the temporary copy to avoid adding a
# second signer; jarsigner recreates them for the environment-provided upload key.
signature_entries=()
while IFS= read -r entry; do
  signature_entries+=("$entry")
done < <(unzip -Z1 "$unsigned_copy" | grep -E '^META-INF/[^/]+\.(SF|RSA|DSA|EC)$' || true)

if [[ ${#signature_entries[@]} -gt 0 ]]; then
  zip -q -d "$unsigned_copy" "${signature_entries[@]}"
fi

printf 'Signing AAB with alias %s...\n' "$ANDROID_GRADLE_ALIAS"
jarsigner \
  -keystore "$keystore_path" \
  -storetype JKS \
  -storepass:env ANDROID_GRADLE_KEYSTORE_PASSWORD \
  -keypass:env ANDROID_GRADLE_KEY_PASSWORD \
  -signedjar "$OUTPUT_PATH" \
  "$unsigned_copy" \
  "$ANDROID_GRADLE_ALIAS"

printf 'Verifying signed AAB...\n'
jarsigner -verify "$OUTPUT_PATH" >/dev/null || die "Signed AAB verification failed"

printf 'Uploading %s release to Google Play...\n' "$PLAY_TRACK"
supply_args=(
  supply
  --aab "$OUTPUT_PATH"
  --json_key "$play_secret_path"
  --package_name "$PACKAGE_NAME"
  --track "$PLAY_TRACK"
  --release_status "$RELEASE_STATUS"
  --skip_upload_metadata true
  --skip_upload_changelogs true
  --skip_upload_images true
  --skip_upload_screenshots true
)

if [[ "$VALIDATE_ONLY" == true ]]; then
  supply_args+=(--validate_only true)
fi

cd "$FASTLANE_DIRECTORY"
"${fastlane_command[@]}" "${supply_args[@]}"

printf 'Release completed successfully.\nSigned AAB: %s\n' "$OUTPUT_PATH"
