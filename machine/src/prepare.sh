#! /bin/bash

# 1. INSTALACIÓN DE PAQUETES
apt-get update && apt-get install -y \
    apache2 \
    mariadb-server \
    php \
    php-mysql \
    libapache2-mod-php \
    python3 \
    python3-requests \
    cron \
    nano \
    sudo \
    && apt-get clean

# 2. CREACIÓN DE USUARIOS
# ADRIAN (UID 1000)
useradd -u 1000 -m -s /bin/bash adrian
echo "adrian:adrian" | chpasswd

# DANIEL (UID 1001)
useradd -u 1001 -m -s /bin/bash daniel
echo "daniel:daniel" | chpasswd

# 3. BASE DE DATOS
service mariadb start
mysql -u root < /opt/src/schema.sql

# 4. CONFIGURACIÓN WEB
rm -f /var/www/html/index.html
chown -R root:root /var/www/html
chmod -R 755 /var/www/html
chmod 644 /var/www/html/config.php

# 5. COLOCACIÓN DEL SCRIPT VULNERABLE
if [ -f /opt/src/query.py ]; then
    mv /opt/src/query.py /home/adrian/query.py
    chown adrian:adrian /home/adrian/query.py
    chmod 777 /home/adrian/query.py
else
    echo "AVISO: No se encontró query.py"
fi

# 6. CONFIGURACIÓN DEL CRON (LA VULNERABILIDAD)
echo "*/2 * * * * adrian /usr/bin/python3 /home/adrian/query.py" > /etc/cron.d/vuln_task
chmod 644 /etc/cron.d/vuln_task

# 7. CARPETAS DE FLAGS
mkdir -p /flag