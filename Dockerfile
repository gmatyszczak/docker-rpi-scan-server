# Dockerized Tor Relay Node on Raspberry Pi
#
# VERSION               0.0.1

FROM resin/rpi-raspbian
MAINTAINER Andrew Schamp "schamp@gmail.com"

# Install dependencies
RUN apt-get update 
RUN apt-get -y install \
    sane-utils \
    hplip \
    unzip \
    imagemagick \
    usbutils \
    tesseract-ocr \
    tesseract-ocr-eng \
    apache2 \
    libapache2-mod-php5 \
    coreutils \
    php5 \
    php5-json \
    php5-curl \
    tar \
    zip \
    php-fpdf \ 
    libpaper-utils \
    sed \
    grep

RUN apt-get clean

RUN mkdir -p /tmp/
RUN wget -O /tmp/PHP-Scanner-Server.zip "https://github.com/GM-Script-Writer-62850/PHP-Scanner-Server/archive/master.zip"
RUN unzip -q /tmp/PHP-Scanner-Server.zip -d /tmp
RUN ls /tmp/
RUN mv /tmp/PHP-Scanner-Server-master/* /var/www/html

# remove original index.html so the PHP page shows up
RUN rm /var/www/html/index.html

RUN sudo adduser www-data lp
RUN sudo mkdir -p /var/www/html/scans
RUN sudo mkdir -p /var/www/html/config/parallel
RUN sudo chown www-data /var/www/html/scans 
RUN sudo chown -R www-data /var/www/html/config

RUN a2enmod headers
RUN echo "ServerName scanner.local" >> /etc/apache2/sites-available/000-default.conf
RUN systemctl enable apache2 

# Add launcher
ADD start.sh /start.sh

# Start scan service(s)
CMD /start.sh
