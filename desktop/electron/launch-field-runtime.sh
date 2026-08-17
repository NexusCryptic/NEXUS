#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
APP="$ROOT/desktop/electron"
cd "$APP"

command -v node >/dev/null 2>&1 || { echo "Node.js is required." >&2; exit 1; }
command -v npm >/dev/null 2>&1 || { echo "npm is required." >&2; exit 1; }

if [[ ! -d node_modules/electron ]]; then
  echo "[NEXUS] Installing Electron runtime..."
  npm install --no-audit --no-fund
fi

ELECTRON_BIN="$APP/node_modules/.bin/electron"
[[ -x "$ELECTRON_BIN" ]] || { echo "Electron installation failed." >&2; exit 1; }

exec "$ELECTRON_BIN" . \
  --enable-gpu-rasterization \
  --enable-zero-copy \
  --ignore-gpu-blocklist \
  --enable-features=Vulkan,WebGPU \
  "$@"
