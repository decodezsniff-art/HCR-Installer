#!/usr/bin/env bash
set -Eeuo pipefail
(( EUID == 0 )) || { echo "Ejecuta como root."; exit 1; }
BASE="https://raw.githubusercontent.com/decodezsniff-art/HCR-Installer/main"
DIR=/opt/hcr-server
BIN="$DIR/hcr-server"
tmp="$(mktemp -d)"; trap 'rm -rf "$tmp"' EXIT
curl -fsSL --retry 3 "$BASE/hcr-server" -o "$tmp/hcr-server"
chmod 0755 "$tmp/hcr-server"
"$tmp/hcr-server" -version >/dev/null 2>&1 || { echo "El binario descargado no es válido para esta VPS."; exit 1; }
systemctl stop hcr-server.service 2>/dev/null || true
install -d -m 0755 "$DIR"
install -m 0755 "$tmp/hcr-server" "$BIN"
systemctl start hcr-server.service
systemctl is-active --quiet hcr-server.service || { echo "HCR no quedó activo; revisa journalctl -u hcr-server."; exit 1; }
echo "HCR actualizado correctamente."
