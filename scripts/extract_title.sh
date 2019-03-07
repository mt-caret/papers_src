#!/usr/bin/env bash
set -euo pipefail

awk -f ./scripts/extract_front_matter.awk "$1" |
  sed 's/^title: //'
