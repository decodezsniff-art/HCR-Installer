
# HCR Installer

Instalador y administrador de HCR Server para Linux.

## Archivos

- `install.sh`: instalación y configuración del servicio.
- `hcr-server`: ejecutable del servidor.
- `update.sh`: actualización del instalador y del servidor.
- `uninstall.sh`: desinstalación del servicio.

## Requisitos

- Sistema Linux.
- Acceso root.
- systemd.

## Instalación

Descarga los archivos:

```bash
mkdir -p /root/HCR-Installer
cd /root/HCR-Installer

wget -O install.sh https://raw.githubusercontent.com/decodezsniff-art/HCR-Installer/main/install.sh
wget -O hcr-server https://raw.githubusercontent.com/decodezsniff-art/HCR-Installer/main/hcr-server
wget -O update.sh https://raw.githubusercontent.com/decodezsniff-art/HCR-Installer/main/update.sh
wget -O uninstall.sh https://raw.githubusercontent.com/decodezsniff-art/HCR-Installer/main/uninstall.sh

chmod +x install.sh hcr-server update.sh uninstall.sh
```

Para instalar sin certificados TLS:

```bash
./install.sh --transport plain
```

Los modos `auto` y `tls` requieren certificados TLS.

## Servicio

Consultar estado:

```bash
systemctl status hcr-server
```

Ver registros:

```bash
journalctl -u hcr-server -f
```

## Actualización

```bash
./update.sh
```

## Desinstalación

```bash
./uninstall.sh
```

La desinstalación conserva los archivos del instalador y del servidor.

## Proyecto

GitHub: https://github.com/decodezsniff-art/HCR-Installer
