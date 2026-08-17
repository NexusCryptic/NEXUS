#!/data/data/com.termux/files/usr/bin/bash
set -Eeuo pipefail
IFS=$'\n\t'

ROOT="${HOME}/.nexus-field"
BIN="${PREFIX}/bin"
LOG="${ROOT}/logs/bootstrap.log"
CONF="${ROOT}/config"
STATE="${ROOT}/state"

mkdir -p "$ROOT" "$BIN" "$CONF" "$STATE" "${ROOT}/branches" "${ROOT}/streams" "${ROOT}/certificates" "${ROOT}/cache" "${ROOT}/logs"
exec > >(tee -a "$LOG") 2>&1

echo "[NEXUS A15] bootstrap $(date -Is)"

pkg update -y
pkg install -y git curl jq openssh python nodejs tmux termux-api

cat > "$CONF/device.env" <<EOF
NEXUS_DEVICE_ROLE=operator-controller
NEXUS_DEVICE_TARGET=samsung-a15
NEXUS_FIELD_ROOT=$ROOT
NEXUS_FIELD_PROTOCOL=field-ir-v0.3
NEXUS_LOCAL_PORT=8765
NEXUS_OPERATOR_MODE=controller
NEXUS_GPU_MODE=remote-or-browser
EOF

cat > "$BIN/nexus-a15" <<'EOF'
#!/data/data/com.termux/files/usr/bin/bash
set -Eeuo pipefail
ROOT="${HOME}/.nexus-field"
case "${1:-status}" in
  status)
    echo "NEXUS A15 controller"
    echo "root=$ROOT"
    echo "role=operator-controller"
    echo "field-ir=field-ir-v0.3"
    echo "branches=$(find "$ROOT/branches" -mindepth 1 -maxdepth 1 -type d 2>/dev/null | wc -l)"
    ;;
  init)
    mkdir -p "$ROOT/branches" "$ROOT/streams" "$ROOT/certificates" "$ROOT/cache"
    echo "initialized $ROOT"
    ;;
  health)
    command -v git >/dev/null && echo "git=ok" || echo "git=missing"
    command -v node >/dev/null && echo "node=ok" || echo "node=missing"
    command -v python >/dev/null && echo "python=ok" || echo "python=missing"
    ;;
  sync)
    echo "Controller sync endpoint is intentionally configured by environment; no credentials are embedded."
    ;;
  *)
    echo "usage: nexus-a15 {status|init|health|sync}"
    exit 2
    ;;
esac
EOF
chmod 700 "$BIN/nexus-a15"

cat > "$ROOT/README.termux" <<'EOF'
NEXUS Samsung A15 operator controller

Run:
  nexus-a15 status
  nexus-a15 health
  nexus-a15 init

This device is the operator/control plane. Heavy field rendering and exact symbolic solving may run on a paired host.
EOF

echo "[NEXUS A15] bootstrap complete"
nexus-a15 status
