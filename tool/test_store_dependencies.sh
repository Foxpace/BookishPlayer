#!/usr/bin/env bash
# Regression checks for the workspace-aware store dependency guard.
set -euo pipefail
repository_root="$(cd "$(dirname "$0")/.." && pwd)"
fixture="$(mktemp -d)"
trap 'rm -rf "$fixture"' EXIT
check_guard() {
  dart "$repository_root/tool/verify_store_dependencies.dart" "$fixture/graph.json" "$fixture/plugins.json"
}
expect_rejection() {
  if check_guard > "$fixture/result" 2>&1; then
    echo 'Expected the store guard to reject this graph.' >&2
    exit 1
  fi
  grep -q "$1" "$fixture/result"
}

# Given separate apps in one graph, internal-only Cactus must not fail the store.
cat > "$fixture/graph.json" <<'JSON'
{"packages":[
  {"name":"bookish_store","dependencies":["core"],"devDependencies":[]},
  {"name":"core","dependencies":[],"devDependencies":["cactus"]},
  {"name":"bookish_internal","dependencies":["cactus"],"devDependencies":[]},
  {"name":"cactus","dependencies":[],"devDependencies":[]}
]}
JSON
printf '{"plugins":{"android":[],"ios":[]}}' > "$fixture/plugins.json"
check_guard

# Given a transitive SDK dependency, the store must fail.
sed 's/"name":"core","dependencies":\[\]/"name":"core","dependencies":["cactus"]/' "$fixture/graph.json" > "$fixture/transitive.json"
cp "$fixture/graph.json" "$fixture/clean.json"
cp "$fixture/transitive.json" "$fixture/graph.json"
expect_rejection 'Store dependency graph contains cactus'

# Given a store dev dependency, debug native plugin inclusion must also fail.
sed 's/"devDependencies":\[\]/"devDependencies":["cactus"]/' "$fixture/clean.json" > "$fixture/graph.json"
expect_rejection 'Store dependency graph contains cactus'

# Given stale plugin metadata, a clean graph is insufficient.
cp "$fixture/clean.json" "$fixture/graph.json"
printf '{"plugins":{"ios":[{"name":"ffmpeg_kit_flutter_new_audio"}]}}' > "$fixture/plugins.json"
expect_rejection 'Store plugin metadata contains ffmpeg'

# Given missing graph nodes, fail closed instead of claiming the graph is safe.
printf '{"plugins":{}}' > "$fixture/plugins.json"
printf '{"packages":[{"name":"bookish_store","dependencies":["missing"],"devDependencies":[]}]}' > "$fixture/graph.json"
expect_rejection 'Incomplete workspace graph'
echo 'All store dependency guard checks passed.'
