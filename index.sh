#!/usr/bin/env bash
set -euo pipefail

cat << EOF
---
title: comp-prog
---
<!-- no RSS feeds, check back every day :love: -->
EOF
ls src/*.md | sort -nr |
while read -r f; do
  outfile=$(basename "$f" .md | sed -e "s/src\///")
  date=$(./scripts/extract_date.sh "$f")
  title=$(./scripts/extract_title.sh "$f")
  echo "- [$date - $title](./$outfile.html)"
done

