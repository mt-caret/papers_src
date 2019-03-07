#!/usr/bin/env bash
set -euo pipefail
d=$(date +%F)
fp="src/$d.md"
last_entry=$(ls src/*.md | sort -nr | head -n 1)
template=$(cat << EOF
---
title: サーベイ
date: $d
---

EOF
)
if [ -f "$fp" ]; then
  echo "file already exists at $fp"
  exit 1
else
  echo "creating entry at $fp"
  echo "$template" > "$fp"
  echo "touching $last_entry"
  touch "$last_entry"
fi
