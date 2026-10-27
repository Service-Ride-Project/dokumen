#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
OUTPUT_DIR="${SCRIPT_DIR}/hasil"
SCALE="${SCALE:-4}"

if ! command -v mmdc >/dev/null 2>&1; then
  printf '%s\n' 'Mermaid CLI (mmdc) belum tersedia di PATH.' >&2
  exit 127
fi

mkdir -p -- "${OUTPUT_DIR}"
count=0
while IFS= read -r -d '' input; do
  relative="${input#"${SCRIPT_DIR}/"}"
  output="${OUTPUT_DIR}/${relative%.mmd}.png"
  mkdir -p -- "$(dirname -- "${output}")"
  printf 'Merender: %s\n' "${relative}"
  mmdc -i "${input}" -o "${output}" -s "${SCALE}" -b white
  count=$((count + 1))
done < <(find "${SCRIPT_DIR}" -path "${OUTPUT_DIR}" -prune -o -type f -name '*.mmd' -print0 | sort -z)

printf 'Selesai: %d diagram, PNG di %s\n' "${count}" "${OUTPUT_DIR}"
