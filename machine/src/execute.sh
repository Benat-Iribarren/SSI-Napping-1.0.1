#! /bin/bash

echo "[+] Iniciando MariaDB..."
service mariadb start

echo "[+] Iniciando Apache..."
service apache2 start

echo "[+] Iniciando Cron..."
service cron start

echo "[+] Sistema Napping listo."
tail -f /var/log/apache2/access.log