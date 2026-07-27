#!/usr/bin/env bash
set -euo pipefail

pdf="${1:-main.pdf}"
out_dir="${2:-figures/slides}"
density="${DENSITY:-144}"

mkdir -p "$out_dir"
pages=$(pdfinfo "$pdf" | awk '/^Pages:/ {print $2}')

for i in $(seq 0 $((pages - 1))); do
  n=$(printf "%02d" $((i + 1)))
  magick -density "$density" "$pdf[$i]" \
    -background white -alpha remove -alpha off \
    "$out_dir/slide-$n.png"
done
