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
    openssh-server \
    cron \
    nano \
    sudo \
    vim \
    && apt-get clean

# 2. CREACIÓN DE USUARIOS
useradd -u 1000 -m -s /bin/bash adrian
echo "adrian:adrian" | chpasswd

groupadd -g 1002 administrators
useradd -u 1001 -m -s /bin/bash -G administrators daniel
echo "daniel:daniel" | chpasswd

# 3. BASE DE DATOS
service mariadb start
mysql -u root < /opt/src/schema.sql

# 4. CONFIGURACIÓN WEB
rm -f /var/www/html/index.html
chown -R root:root /var/www/html
chmod -R 755 /var/www/html
chmod 644 /var/www/html/config.php

# 5. SCRIPT VULNERABLE
if [ -f /opt/src/query.py ]; then
    mv /opt/src/query.py /home/adrian/query.py

    chown adrian:administrators /home/adrian/query.py
    
    #permisos 775: El dueño (adrian) y el grupo (administrators/daniel) pueden escribir
    chmod 775 /home/adrian/query.py
else
    echo "AVISO: No se encontró query.py"
fi

# 6. CRON
echo "*/2 * * * * adrian /usr/bin/python3 /home/adrian/query.py" > /etc/cron.d/vuln_task
chmod 644 /etc/cron.d/vuln_task

#7 meto a adrian en sudoers para que pueda editar archivos con vim
echo "adrian ALL=(ALL) NOPASSWD: /usr/bin/vim" >> /etc/sudoers

8 7. FLAGS
mkdir -p /flag