#!/bin/bash
# Run from a prepared Wine checkout, after all GE patches.
set -euo pipefail
export LC_ALL=C
patch_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
mapfile -t patches < <(sed '/^[[:space:]]*#/d; /^[[:space:]]*$/d' "$patch_dir/series")
((${#patches[@]})) || { echo "Empty LMU series" >&2; exit 1; }
# Validate all names and checksums before changing Wine.
declare -A seen
for name in "${patches[@]}"; do
    [[ "$name" =~ ^[0-9][0-9]-[a-z0-9-]+\.patch$ && ! ${seen[$name]+yes} ]] || {
        echo "Invalid or duplicate LMU patch: $name" >&2; exit 1;
    }
    seen[$name]=1
    hash=$(awk -v name="$name" '$2 == name {print $1}' "$patch_dir/SHA256SUMS")
    [[ "$hash" =~ ^[0-9a-f]{64}$ ]] || {
        echo "Missing or duplicate checksum for $name" >&2; exit 1;
    }
done
(cd "$patch_dir" && sha256sum --check --strict SHA256SUMS)
for name in "${patches[@]}"; do
    echo "LMU: applying $name"
    git apply --check "$patch_dir/$name"
    git apply "$patch_dir/$name"
done
