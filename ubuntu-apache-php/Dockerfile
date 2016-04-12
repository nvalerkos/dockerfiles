FROM justckr/ubuntu-base:latest

MAINTAINER Constantinos Kouloumbris <c@kouloumbris.com>

# Install packages
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update

RUN apt-get install -y software-properties-common \
    python-software-properties \
    language-pack-en-base

RUN LC_ALL=en_US.UTF-8 add-apt-repository ppa:ondrej/php

RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y apache2 \
    libapache2-mod-php5.6 \
    php5.6 \
    php5.6-curl \
    php5.6-gd \
    php5.6-intl \
    php5.6-ldap \
    php5.6-mysql \
    php5.6-pgsql \
    php5.6-sqlite3 \
    php5.6-json \
    php5.6-mcrypt \
    php5.6-xmlrpc \
    php5.6-xml \
    php5.6-mbstring \
    php5.6-soap \
    php5.6-zip \
    php5.6-cli \
    php5.6-sybase \
    php5.6-odbc \
    freetds-common \
    php5.6-dev


# Install xdebug
RUN wget http://xdebug.org/files/xdebug-2.4.0.tgz
RUN tar -xvzf xdebug-2.4.0.tgz
RUN cd xdebug-2.4.0 && phpize
RUN cd xdebug-2.4.0 && ./configure
RUN cd xdebug-2.4.0 && make
RUN cd xdebug-2.4.0 && cp modules/xdebug.so /usr/lib/php/20131226
ADD conf/xdebug.conf /xdebug.conf
RUN cat /xdebug.conf >> /etc/php/5.6/apache2/php.ini
RUN cat /xdebug.conf >> /etc/php/5.6/cli/php.ini
RUN rm -rf /xdebug-2.4.0
RUN rm -rf /xdebug-2.4.0.tgz

# Cleanup
RUN apt-get remove --purge -y software-properties-common \
    python-software-properties \
    php5.6-dev

RUN apt-get autoremove -y
RUN apt-get clean
RUN apt-get autoclean

# Tweek apache config
ADD conf/apache-default.conf /etc/apache2/sites-available/000-default.conf
RUN ln -sfF /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-enabled/000-default.conf

ADD conf/apache-default-ssl.conf /etc/apache2/sites-available/default-ssl.conf
RUN ln -sfF /etc/apache2/sites-available/default-ssl.conf /etc/apache2/sites-enabled/default-ssl.conf

RUN a2enmod rewrite
RUN a2enmod ldap
RUN a2enmod ssl

# Add scripts
ADD scripts/start-apache2.sh /start-apache2.sh
RUN chmod 755 /start-apache2.sh

# Supervisor Config
ADD conf/supervisord.conf /etc/supervisord.conf

# Start Supervisord
ADD scripts/start.sh /start.sh
RUN chmod 755 /start.sh

# Setup Volume
VOLUME ["/app", "/etc/apache2/sites-enabled"]

# create web server directories
RUN mkdir -p /app/src/public
RUN mkdir -p /var/www/html/logs

# add test PHP file
ADD src/index.php /app/src/public/index.php
ADD src/index.php /app/src/public/info.php
RUN chown -Rf www-data.www-data /app
RUN chown -Rf www-data.www-data /var/www/html


# Expose Ports
EXPOSE 443
EXPOSE 80
EXPOSE 9000

CMD ["/bin/bash", "/start.sh"]
