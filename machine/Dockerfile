#  versión específica de Debian para estabilidad (Bullseye)
FROM debian:bullseye

# Evita que la instalación se congele preguntando la zona horaria
ENV DEBIAN_FRONTEND=noninteractive

COPY html /var/www/html/
COPY src /opt/src/

RUN chmod +x /opt/src/prepare.sh /opt/src/execute.sh

RUN /opt/src/prepare.sh

WORKDIR /var/www/html

ENTRYPOINT ["/opt/src/execute.sh"]