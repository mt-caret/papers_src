#!/usr/bin/env bash
set -euo pipefail

function to_markdown_link() {
  OUTFILE=$(basename "$1" .md | sed -e "s/src\///")
  if [ "$OUTFILE" == "#" ]; then
    echo "<a href=\"#\">#</a>"
  else
    TITLE=$(./scripts/extract_title.sh "$1")
    DATE=$(./scripts/extract_date.sh "$1")
    echo "<a href=\"./$OUTFILE.html\">$DATE - $TITLE</a>"
  fi
}

LIST=$(cat << EOF
src/#
$(ls src/*.md | sort -nr)
src/#
EOF
)

CONTEXT=$(grep -C1 "$1" <<< "$LIST")
NEXT=$(to_markdown_link "$(head -n 1 <<< "$CONTEXT")")
PREV=$(to_markdown_link "$(tail -n 1 <<< "$CONTEXT")")
INDEX='<a href="./index.html">index</a>'
echo -e "$PREV\\n$INDEX\\n$NEXT"

