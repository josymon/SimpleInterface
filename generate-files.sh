#!/usr/bin/env bash
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUTPUT="$DIR/files.js"

# List only *.png files (case-insensitive), sorted, basenames only
files=$(find "$DIR" -maxdepth 1 -type f -iname '*.png' -printf '%f\n' | sort)

{
  echo "// Auto-generated list of PNG files"
  echo "const pngFiles = ["
  first=true
  while IFS= read -r f; do
    [ -z "$f" ] && continue
    if [ "$first" = true ]; then
      first=false
    else
      echo ","
    fi
    printf '  "%s"' "$f"
  done <<< "$files"
  echo ""
  echo "];"
} > "$OUTPUT"

echo "Generated: $OUTPUT"
