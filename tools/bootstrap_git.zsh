#!/bin/zsh
set -euo pipefail
unsetopt BANG_HIST 2>/dev/null || true

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

echo "=== RÍSTA – GIT BOOTSTRAP ==="
echo "Prosjektmappe: $ROOT"
echo ""

if [ -d .git ]; then
  echo "OK: Git-repo finnes allerede."
else
  if git init -b main >/dev/null 2>&1; then
    echo "OK: Git initialisert med main."
  else
    git init >/dev/null
    git checkout -B main >/dev/null
    echo "OK: Git initialisert og main opprettet."
  fi
fi

git add .

if ! git config user.name >/dev/null 2>&1 || ! git config user.email >/dev/null 2>&1; then
  echo ""
  echo "MERK: Git-identitet mangler. Sett navn og e-post før første commit:"
  echo "git config --global user.name 'Ditt navn'"
  echo "git config --global user.email 'din@epost.no'"
  echo ""
  git status --short --branch
  exit 0
fi

if git diff --cached --quiet; then
  echo "OK: Ingen nye filer å committe."
else
  git commit -m "initial rista macos markdown editor scaffold"
fi

echo ""
echo "=== SLUTTSTATUS ==="
git branch --show-current
git rev-parse HEAD
git status --short --branch
