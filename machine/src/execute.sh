#! /bin/bash

echo "[+] Iniciando MariaDB..."
service mariadb start

echo "[+] Iniciando Apache..."
service apache2 start

echo "[+] Iniciando Cron..."
service cron start

# --- BLOQUE NUEVO PARA SSH ---
echo "[+] Iniciando SSH..."
mkdir -p /run/sshd   
service ssh start
# -----------------------------

echo "[+] Sistema Napping listo."
tail -f /var/log/apache2/access.log