#!/usr/bin/env bash
# Retry a command with exponential backoff.
# Usage: retry.sh [--max-attempts N] [--delay SECONDS] -- command

set -euo pipefail

max_attempts=5
delay=1

while [[ $# -gt 0 ]]; do
  case "$1" in
    --max-attempts) max_attempts="$2"; shift 2 ;;
    --delay) delay="$2"; shift 2 ;;
    --) shift; break ;;
    *) echo "Unknown option: $1" >&2; exit 1 ;;
  esac
done

for attempt in $(seq 1 "$max_attempts"); do
  if "$@"; then
    exit 0
  fi
  echo "Attempt $attempt failed. Retrying in ${delay}s..." >&2
  sleep "$delay"
  delay=$((delay * 2))
done

echo "Command failed after $max_attempts attempts" >&2
exit 1
