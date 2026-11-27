#!/bin/bash

HCR Server - Uninstaller

if [ "$(id -u)" -ne 0 ]; then
echo "Ejecuta este script como root."
exit 1
fi

if [ ! -f /root/HCR-Installer/install.sh ]; then
echo "No se encontró install.sh."
exit 1
fi

chmod +x /root/HCR-Installer/install.sh
/root/HCR-Installer/install.sh --uninstall
