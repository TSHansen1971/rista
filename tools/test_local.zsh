#!/bin/zsh
set -euo pipefail
unsetopt BANG_HIST 2>/dev/null || true

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

echo "=== RÍSTA – LOKALE TESTER ==="
swift test
