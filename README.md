HCR Installer

Instalador oficial de HCR Server para sistemas Linux.

Archivos

- "install.sh": script de instalación y administración.
- "hcr-server": ejecutable del servidor HCR.

Requisitos

- Servidor Linux.
- Acceso root.
- systemd.
- Certificados TLS para los modos "auto" y "tls".

Instalación

Descarga los archivos y ejecuta el instalador:

mkdir -p /root/HCR-Installer
cd /root/HCR-Installer

wget -O install.sh https://raw.githubusercontent.com/decodezsniff-art/HCR-Installer/main/install.sh
wget -O hcr-server https://raw.githubusercontent.com/decodezsniff-art/HCR-Installer/main/hcr-server

chmod +x install.sh hcr-server
./install.sh

Servicio

Consultar estado:

systemctl status hcr-server

Ver registros:

journalctl -u hcr-server -f

Desinstalación

El instalador admite:

./install.sh --uninstall

Autor

GitHub: https://github.com/decodezsniff-art

Proyecto

HCR-Installer
