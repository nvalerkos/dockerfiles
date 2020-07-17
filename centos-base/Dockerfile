FROM centos:centos8

MAINTAINER Constantinos Kouloumbris <c@kouloumbris.com>

#for compatibiltiy
ENV DOCKER_USER_ID 501
ENV DOCKER_USER_GID 20

ENV BOOT2DOCKER_ID 1000
ENV BOOT2DOCKER_GID 50

#Add the official nginx repo
ADD conf/nginx.repo /etc/yum.repos.d/nginx.repo

#Add EPEL and REMI repos and then enable php 7.4 on remi
RUN yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
RUN yum -y install https://rpms.remirepo.net/enterprise/remi-release-8.rpm
RUN dnf -y install dnf-utils
RUN dnf module -y install php:remi-7.4

# Install packages
RUN dnf -y update
RUN yum -y upgrade

RUN yum -y install \
    bash-completion \
    curl \
    hostname \
    vim-enhanced \
    git \
    supervisor \
    vim \
    screen \
    wget \
    tree \
    htop \
    nginx \
    php \
    php-fpm \
    php-mysql \
    php-common \
    php-gd \
    php-intl \
    php-mcrypt \
    php-tidy	\
    php-xmlrpc \
    php-pgsql \
    php-xml \
    php-mbstring	\
    php-soap	\
    php-cli \
    php-odbc	\
    php-pecl-xdebug \
    php-opcache

# Cleanup
RUN yum clean all

# Tweaks to give the web service and php write permissions to the app
RUN groupadd staff
RUN usermod -u ${BOOT2DOCKER_ID} nginx
RUN usermod -G staff nginx

RUN groupmod -g $(($BOOT2DOCKER_GID + 10000)) $(getent group $BOOT2DOCKER_GID | cut -d: -f1)
RUN groupmod -g ${BOOT2DOCKER_GID} staff

# nginx site conf
RUN mkdir -p /etc/nginx/ssl/
ADD ssl/nginx.crt /etc/nginx/ssl/nginx.crt
ADD ssl/nginx.key /etc/nginx/ssl/nginx.key
ADD conf/nginx-site.conf /etc/nginx/conf.d/default.conf
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Supervisor Config
ADD conf/supervisord.conf /etc/supervisord.conf

# Start Supervisord
ADD scripts/start.sh /start.sh
RUN chmod 755 /start.sh

# add test PHP file
RUN mkdir -p /app/src/public
ADD src/index.php /app/src/public/index.php
ADD src/index.php /app/src/public/info.php
RUN chown -Rf nginx.nginx /app

# Setup Volume
VOLUME ["/app"]

# Expose Ports
EXPOSE 443
EXPOSE 80

CMD ["/bin/bash", "/start.sh"]
