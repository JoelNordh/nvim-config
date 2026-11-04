#!/usr/bin/env bash
# Regenerates docs/cheatsheet.pdf from docs/cheatsheet.md via pandoc.
#
# Usage: ./docs/build-cheatsheet.sh
# Requires: pandoc, and a LaTeX engine (xelatex or pdflatex).
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")"

if ! command -v pandoc >/dev/null 2>&1; then
  echo "error: pandoc is not installed (try: sudo apt install pandoc texlive-xetex)" >&2
  exit 1
fi

ENGINE="xelatex"
command -v xelatex >/dev/null 2>&1 || ENGINE="pdflatex"

pandoc cheatsheet.md \
  --pdf-engine="$ENGINE" \
  -o cheatsheet.pdf

echo "Wrote docs/cheatsheet.pdf (engine: $ENGINE)"
