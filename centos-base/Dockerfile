FROM centos:centos6

MAINTAINER Constantinos Kouloumbris <c@kouloumbris.com>

#for compatibiltiy
ENV DOCKER_USER_ID 501
ENV DOCKER_USER_GID 20

ENV BOOT2DOCKER_ID 1000
ENV BOOT2DOCKER_GID 50

#Add the official nginx repo
ADD conf/nginx.repo /etc/yum.repos.d/nginx.repo

#Add the webtatic EL yum repo for php7
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
RUN rpm -Uvh https://mirror.webtatic.com/yum/el6/latest.rpm

# Install packages
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
    zsh \
    nginx \
    php70w \
    php70w-fpm \
    php70w-mysql \
    php70w-common \
    php70w-gd \
    php70w-intl \
    php70w-mcrypt \
    php70w-tidy	\
    php70w-xmlrpc \
    php70w-pgsql \
    php70w-xml \
    php70w-mbstring	\
    php70w-soap	\
    php70w-cli \
    php70w-odbc	\
    php70w-pecl-xdebug \
    php70w-opcache

# Install Oh My Zsh
RUN git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh \
      && cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc \
      && chsh -s /bin/zsh

# Cleanup
RUN yum clean all

# Tweaks to give the web service and php write permissions to the app
RUN groupadd staff
RUN usermod -u ${BOOT2DOCKER_ID} nginx
RUN usermod -G staff nginx
RUN usermod -G staff apache

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
RUN chown -Rf apache.apache /app

# Setup Volume
VOLUME ["/app"]

# Expose Ports
EXPOSE 443
EXPOSE 80

CMD ["/bin/bash", "/start.sh"]
