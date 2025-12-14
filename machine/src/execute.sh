#! /bin/bash

echo " - Iniciando MariaDB..."
service mariadb start

echo " - Iniciando Apache..."
service apache2 start

echo " - Iniciando Cron..."
service cron start

echo " - Iniciando SSH..."
mkdir -p /run/sshd
service ssh start

echo " - Moviendo cada flag al directorio correspondiente"

if [ -f /flag/root.txt ]; then
    cp /flag/root.txt /root/root.txt
    chown root:root /root/root.txt
    chmod 600 /root/root.txt
    rm /flag/root.txt
fi

if [ -f /flag/user.txt ]; then
    cp /flag/user.txt /home/daniel/user.txt
    chown daniel:daniel /home/daniel/user.txt
    chmod 600 /home/daniel/user.txt
    rm /flag/user.txt
fi
if [ -f /flag/flag.txt ]; then
    cp /flag/flag.txt /home/adrian/flag.txt
    chown adrian:adrian /home/adrian/flag.txt
    chmod 600 /home/adrian/flag.txt
    rm /flag/flag.txt
fi

rm /flag

echo "----- Sistema Napping listo. -----"
tail -f /var/log/apache2/access.log
