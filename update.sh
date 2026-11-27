#!/bin/bash

HCR Installer - Updater

set -e

REPO="https://raw.githubusercontent.com/decodezsniff-art/HCR-Installer/main"
DIR="/root/HCR-Installer"

if [ "$(id -u)" -ne 0 ]; then
echo "Ejecuta este script como root."
exit 1
fi

mkdir -p "$DIR"

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

echo "Descargando archivos de HCR..."

wget -q -O "$TMP/install.sh" "$REPO/install.sh"
wget -q -O "$TMP/hcr-server" "$REPO/hcr-server"

if [ ! -s "$TMP/install.sh" ] || [ ! -s "$TMP/hcr-server" ]; then
echo "Error: descarga incompleta."
exit 1
fi

chmod +x "$TMP/install.sh" "$TMP/hcr-server"

install -m 755 "$TMP/install.sh" "$DIR/install.sh"
install -m 755 "$TMP/hcr-server" "$DIR/hcr-server"

if systemctl is-active --quiet hcr-server; then
systemctl restart hcr-server
echo "Servicio HCR reiniciado."
fi

echo "Actualización completada."
