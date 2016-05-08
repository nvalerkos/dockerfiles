FROM justckr/ubuntu-base:latest

MAINTAINER Constantinos Kouloumbris <c@kouloumbris.com>

#for compatibiltiy
ENV DOCKER_USER_ID 501
ENV DOCKER_USER_GID 20

ENV BOOT2DOCKER_ID 1000
ENV BOOT2DOCKER_GID 50

# # Tweaks to give the web service and php write permissions to the app
RUN usermod -u ${BOOT2DOCKER_ID} www-data
RUN usermod -G staff www-data

RUN groupmod -g $(($BOOT2DOCKER_GID + 10000)) $(getent group $BOOT2DOCKER_GID | cut -d: -f1)
RUN groupmod -g ${BOOT2DOCKER_GID} staff

# Install packages
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update

RUN apt-get install -y software-properties-common \
    python-software-properties \
    language-pack-en-base

RUN apt-get update
RUN apt-get upgrade -y

RUN apt-get install -y apache2

# Cleanup
RUN apt-get remove --purge -y software-properties-common \
    python-software-properties

RUN apt-get autoremove -y
RUN apt-get clean
RUN apt-get autoclean

# Tweek apache config
ADD conf/apache-default.conf /etc/apache2/sites-available/000-default.conf
RUN ln -sfF /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-enabled/000-default.conf

ADD conf/apache-default-ssl.conf /etc/apache2/sites-available/default-ssl.conf
RUN ln -sfF /etc/apache2/sites-available/default-ssl.conf /etc/apache2/sites-enabled/default-ssl.conf

RUN a2enmod rewrite
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

# add test HTML file
ADD src/index.html /app/src/public/index.html
RUN chown -Rf www-data.www-data /app
RUN chown -Rf www-data.www-data /var/www/html

# Expose Ports
EXPOSE 443
EXPOSE 80

CMD ["/bin/bash", "/start.sh"]
