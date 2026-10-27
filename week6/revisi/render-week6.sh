#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
OUTPUT_DIR="${SCRIPT_DIR}/hasil"

if ! command -v mmdc >/dev/null 2>&1; then
  printf '%s\n' "Mermaid CLI (mmdc) is not installed or is not available on PATH." >&2
  exit 127
fi

mkdir -p "${OUTPUT_DIR}"

while IFS= read -r -d '' input; do
  relative_path="${input#"${SCRIPT_DIR}/"}"
  relative_path="${relative_path%.mmd}.png"
  output_path="${OUTPUT_DIR}/${relative_path}"

  mkdir -p "$(dirname -- "${output_path}")"
  printf 'Rendering %s\n' "${relative_path}"

  mmdc \
    -i "${input}" \
    -o "${output_path}" \
    -s 4 \
    -b white \
    # -c "${SCRIPT_DIR}/mermaid-config.json"
done < <(find "${SCRIPT_DIR}" -path "${OUTPUT_DIR}" -prune -o -type f -name '*.mmd' -print0)

printf 'PNG files saved in %s\n' "${OUTPUT_DIR}"
