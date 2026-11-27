#!/bin/bash
# HCR Server - Uninstaller

set -e

if [ "$(id -u)" -ne 0 ]; then
    echo "Ejecuta este script como root."
    exit 1
fi

INSTALLER="/root/HCR-Installer/install.sh"

if [ ! -f "$INSTALLER" ]; then
    echo "No se encontró $INSTALLER."
    exit 1
fi

chmod +x "$INSTALLER"
"$INSTALLER" --uninstall
