#!/bin/bash

usage() {
  echo "Usage: $0 [--list | --write [files...]]"
  echo ""
  echo "Options:"
  echo "  --list         List files that differ from Prettier formatting"
  echo "  --write [files...]  Format and overwrite files (all files if none specified)"
  echo "  (no option)    Show diff for each file that needs formatting"
  exit 1
}

case "$1" in
  --list)
    npx prettier --list-different .
    ;;
  --write)
    shift
    if [ $# -eq 0 ]; then
      npx prettier --write .
    else
      npx prettier --write "$@"
    fi
    ;;
  --help|-h)
    usage
    ;;
  "")
    for f in $(npx prettier --list-different .); do
      echo "=== $f ==="
      npx prettier "$f" | colordiff -u "$f" -
    done
    ;;
  *)
    echo "Unknown option: $1"
    usage
    ;;
esac
