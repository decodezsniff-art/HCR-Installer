#!/usr/bin/env bash
set -Eeuo pipefail

(( EUID == 0 )) || { echo "Ejecuta como root."; exit 1; }
command -v systemctl >/dev/null 2>&1 || { echo "Se necesita systemd para desinstalar HCR."; exit 1; }

echo "Deteniendo y eliminando los servicios HCR..."
systemctl disable --now hcr-server.service 2>/dev/null || true

shopt -s nullglob
for unit in /etc/systemd/system/hcr-server-port-*.service; do
  name="${unit##*/}"
  systemctl disable --now "$name" 2>/dev/null || true
  rm -f -- "$unit"
done
shopt -u nullglob

# Eliminar el servicio principal y sus archivos de unidad.
rm -f -- /etc/systemd/system/hcr-server.service
rm -f -- /opt/hcr-server/hcr-server.service

# Eliminar herramientas de administración instaladas por HCR.
rm -f -- /usr/local/bin/hcr-panel
rm -f -- /usr/local/bin/hcr-ports

# Eliminar ajustes BBR creados por el panel, sin cambiar los valores
# activos del kernel ni tocar configuraciones BBR ajenas a HCR.
if [ -f /etc/sysctl.d/99-hcrcustom-bbr.conf ] &&
   grep -q '^# HCRCUSTOM BBR FQ$' /etc/sysctl.d/99-hcrcustom-bbr.conf; then
  rm -f -- /etc/sysctl.d/99-hcrcustom-bbr.conf
fi

# Eliminar binario, configuraciones, datos y archivos descargados propios de HCR.
rm -rf -- /opt/hcr-server
rm -rf -- /etc/hcr-server
# Limpiar también el clon temporal usado en las instrucciones de instalación.
rm -rf -- /tmp/HCR-Installer

systemctl daemon-reload
systemctl reset-failed hcr-server.service 2>/dev/null || true

# Comprobación final: no dejar los comandos del panel disponibles.
if [ -e /usr/local/bin/hcr-panel ] || [ -e /usr/local/bin/hcr-ports ] ||
   [ -e /opt/hcr-server ] || [ -e /etc/hcr-server ]; then
  echo "AVISO: quedaron archivos HCR que no se pudieron eliminar." >&2
  exit 1
fi

echo "HCR se desinstaló completamente."
echo "Se eliminaron servicios, binario, configuración, datos, panel y gestor de puertos."
echo "No se borraron certificados ni archivos que estén fuera de las carpetas propias de HCR."
