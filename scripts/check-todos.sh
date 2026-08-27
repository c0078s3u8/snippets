#!/usr/bin/env bash
set -euo pipefail

# Check for TODO/FIXME comments in tracked files.
# Usage: ./scripts/check-todos.sh [--fail]

fail=0
if [[ "${1:-}" == "--fail" ]]; then
  fail=1
fi

files=$(git ls-files '*.sh' '*.yml' '*.yaml' '*.json' '*.md' '*.py')
if [[ -z "$files" ]]; then
  echo "No files to scan."
  exit 0
fi

matches=$(grep -nE 'TODO|FIXME' $files || true)
if [[ -n "$matches" ]]; then
  echo "$matches"
  if [[ $fail -eq 1 ]]; then
    echo "ERROR: TODO/FIXME found." >&2
    exit 1
  fi
else
  echo "Clean: no TODO/FIXME comments."
fi
