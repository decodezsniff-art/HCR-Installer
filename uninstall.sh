#!/usr/bin/env bash
set -Eeuo pipefail
(( EUID == 0 )) || { echo "Ejecuta como root."; exit 1; }
systemctl disable --now hcr-server.service 2>/dev/null || true
shopt -s nullglob
for unit in /etc/systemd/system/hcr-server-port-*.service; do
  name="${unit##*/}"; systemctl disable --now "$name" 2>/dev/null || true; rm -f "$unit"
done
shopt -u nullglob
rm -f /etc/systemd/system/hcr-server.service /opt/hcr-server/hcr-server.service
systemctl daemon-reload
echo "Servicios HCR eliminados. Se conservaron el binario, certificados y configuración."
