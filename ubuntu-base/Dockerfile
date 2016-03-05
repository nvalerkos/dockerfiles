FROM ubuntu:latest

MAINTAINER Constantinos Kouloumbris <c@kouloumbris.com>

# Surpress Upstart errors/warning
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -sf /bin/true /sbin/initctl

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
RUN apt-get upgrade -y
RUN apt-get install -y supervisor \
	git \
	pwgen \
	bash-completion \
	hostname \
	vim \
	screen

# Cleanup
RUN apt-get autoremove -y
RUN apt-get clean
RUN apt-get autoclean
