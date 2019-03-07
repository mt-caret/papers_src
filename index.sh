#!/usr/bin/env bash
set -euo pipefail

cat << EOF
---
title: surveys
---
<!-- no RSS feeds, check back every day :love: -->
EOF
ls src/*.md | sort -nr |
while read -r f; do
  date=$(basename "$f" .md | sed -e "s/src\///")
  title=$(./scripts/extract_title.sh "$f")
  echo "- [$date - $title](./$date.html)"
done

