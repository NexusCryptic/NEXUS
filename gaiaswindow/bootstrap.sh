#!/usr/bin/env bash
set -Eeuo pipefail
IFS=$'\n\t'

ROOT="${GAIASWINDOW_ROOT:-$HOME/.gaiaswindow}"
mkdir -p "$ROOT" "$ROOT/logs" "$ROOT/config" "$ROOT/cache" "$ROOT/field" "$ROOT/branches"

log(){ printf '[gaiaswindow] %s\n' "$*" | tee -a "$ROOT/logs/bootstrap.log"; }

command -v node >/dev/null 2>&1 || { log 'Node.js is required; install a supported Node LTS before continuing.'; exit 1; }
command -v npm >/dev/null 2>&1 || { log 'npm is required; install npm before continuing.'; exit 1; }

cat > "$ROOT/config/runtime.env" <<EOF
GAIASWINDOW_ROOT=$ROOT
GAIASWINDOW_FIELD_IR=field-ir-v0.3
GAIASWINDOW_ROLE=secondary-compatible-runtime
GAIASWINDOW_AUTO_CONFIGURE=1
GAIASWINDOW_OFFSCREEN=1
EOF

if [[ ! -f "$ROOT/package.json" ]]; then
  cat > "$ROOT/package.json" <<'EOF'
{
  "name": "gaiaswindow-runtime",
  "private": true,
  "version": "0.3.0",
  "type": "module",
  "scripts": {
    "check": "node --check runtime.mjs"
  }
}
EOF
fi

cat > "$ROOT/runtime.mjs" <<'EOF'
import fs from 'node:fs';
import path from 'node:path';

const root = process.env.GAIASWINDOW_ROOT || path.join(process.env.HOME || '.', '.gaiaswindow');
const statePath = path.join(root, 'field', 'state.json');
const state = {
  schema: 'field-ir-v0.3',
  runtime: 'gaiaswindow',
  role: 'secondary-compatible-runtime',
  revision: Date.now(),
  branches: [],
  certificate: { exact: false, status: 'pending' }
};
fs.mkdirSync(path.dirname(statePath), { recursive: true });
fs.writeFileSync(statePath, JSON.stringify(state, null, 2) + '\n');
console.log(JSON.stringify(state, null, 2));
EOF

(cd "$ROOT" && npm install --no-audit --no-fund)
(cd "$ROOT" && npm run check)
node "$ROOT/runtime.mjs"
log 'auto-configuration complete'
