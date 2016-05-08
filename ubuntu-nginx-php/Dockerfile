FROM justckr/ubuntu-base:latest

MAINTAINER Constantinos Kouloumbris <c@kouloumbris.com>

# Install packages
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update

RUN apt-get install -y software-properties-common \
    python-software-properties \
    language-pack-en-base

RUN add-apt-repository ppa:nginx/stable
RUN LC_ALL=en_US.UTF-8 add-apt-repository ppa:ondrej/php

RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y nginx \
    php5.6-fpm \
    php5.6-mysql \
    php-apcu \
    php5.6-curl \
    php5.6-gd \
    php5.6-intl \
    php5.6-mcrypt \
    php-memcache \
    php5.6-sqlite \
    php5.6-tidy \
    php5.6-xmlrpc \
    php5.6-pgsql \
    php5.6-ldap \
    freetds-common \
    php5.6-pgsql \
    php5.6-sqlite3 \
    php5.6-json \
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
RUN cat /xdebug.conf >> /etc/php/5.6/fpm/php.ini
RUN rm -rf /xdebug-2.4.0
RUN rm -rf /xdebug-2.4.0.tgz

# Cleanup
RUN apt-get remove --purge -y software-properties-common \
    python-software-properties

RUN apt-get autoremove -y
RUN apt-get clean
RUN apt-get autoclean

#tweek nginx config
RUN sed -i -e '/worker_processes/c\worker_processes  5;' /etc/nginx/nginx.conf
RUN sed -i -e '/keepalive_timeout/c\keepalive_timeout  2;' /etc/nginx/nginx.conf
RUN sed -i -e '/client_max_body_size/c\client_max_body_size 100m;' /etc/nginx/nginx.conf
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

#tweek php-fpm config
RUN sed -i -e "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" /etc/php/5.6/fpm/php.ini
RUN sed -i -e "s/upload_max_filesize\s*=\s*2M/upload_max_filesize = 100M/g" /etc/php/5.6/fpm/php.ini
RUN sed -i -e "s/post_max_size\s*=\s*8M/post_max_size = 100M/g" /etc/php/5.6/fpm/php.ini
RUN sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php/5.6/fpm/php-fpm.conf
RUN sed -i -e "s/;catch_workers_output\s*=\s*yes/catch_workers_output = yes/g" /etc/php/5.6/fpm/pool.d/www.conf
RUN sed -i -e "s/pm.max_children = 5/pm.max_children = 9/g" /etc/php/5.6/fpm/pool.d/www.conf
RUN sed -i -e "s/pm.start_servers = 2/pm.start_servers = 3/g" /etc/php/5.6/fpm/pool.d/www.conf
RUN sed -i -e "s/pm.min_spare_servers = 1/pm.min_spare_servers = 2/g" /etc/php/5.6/fpm/pool.d/www.conf
RUN sed -i -e "s/pm.max_spare_servers = 3/pm.max_spare_servers = 4/g" /etc/php/5.6/fpm/pool.d/www.conf
RUN sed -i -e "s/pm.max_requests = 500/pm.max_requests = 200/g" /etc/php/5.6/fpm/pool.d/www.conf
RUN sed -i -e "/listen\s*=\s*\/run\/php\/php5.6-fpm.sock/c\listen = 127.0.0.1:9000" /etc/php/5.6/fpm/pool.d/www.conf
RUN sed -i -e "/pid\s*=\s*\/run/c\pid = /run/php5.6-fpm.pid" /etc/php/5.6/fpm/php-fpm.conf

#fix ownership of sock file
RUN sed -i -e "s/;listen.mode = 0660/listen.mode = 0750/g" /etc/php/5.6/fpm/pool.d/www.conf
RUN find /etc/php/5.6/cli/conf.d/ -name "*.ini" -exec sed -i -re 's/^(\s*)#(.*)/\1;\2/g' {} \;

# nginx site conf
RUN rm -Rf /etc/nginx/conf.d/*
RUN rm -Rf /etc/nginx/sites-available/default
RUN rm -Rf /etc/nginx/sites-enabled/default
RUN mkdir -p /etc/nginx/ssl/
ADD conf/nginx-site.conf /etc/nginx/sites-available/default.conf
RUN ln -s /etc/nginx/sites-available/default.conf /etc/nginx/sites-enabled/default.conf

# Supervisor Config
ADD conf/supervisord.conf /etc/supervisord.conf

# Start Supervisord
ADD scripts/start.sh /start.sh
RUN chmod 755 /start.sh

# Setup Volume
VOLUME ["/app"]

# change nginx directory
RUN mkdir -p /app/src/public
RUN mkdir -p /var/www/html/logs

# add test PHP file
ADD src/index.php /app/src/public/index.php
RUN chown -Rf www-data.www-data /app
RUN chown -Rf www-data.www-data /var/www/html


# Expose Ports
EXPOSE 443
EXPOSE 80
EXPOSE 9000
EXPOSE 9001

CMD ["/bin/bash", "/start.sh"]
