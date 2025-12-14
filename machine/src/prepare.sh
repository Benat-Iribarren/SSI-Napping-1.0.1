#! /bin/bash

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

useradd -u 1000 -m -s /bin/bash adrian
echo "adrian:adrian" | chpasswd

groupadd -g 1002 administrators
useradd -u 1001 -m -s /bin/bash -G administrators daniel
echo "daniel:daniel" | chpasswd

service mariadb start
mysql -u root < /opt/src/schema.sql

rm -f /var/www/html/index.html
chown -R root:root /var/www/html
chmod -R 755 /var/www/html
chmod 644 /var/www/html/config.php

if [ -f /opt/src/query.py ]; then
    mv /opt/src/query.py /home/adrian/query.py

    chown adrian:administrators /home/adrian/query.py

    chmod 775 /home/adrian/query.py
else
    echo "AVISO: No se encontró query.py"
fi

echo "*/2 * * * * adrian /usr/bin/python3 /home/adrian/query.py" > /etc/cron.d/vuln_task
chmod 644 /etc/cron.d/vuln_task

echo "adrian ALL=(root) NOPASSWD: /usr/bin/vim" >> /etc/sudoers
