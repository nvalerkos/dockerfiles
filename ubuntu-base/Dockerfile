FROM ubuntu:latest

MAINTAINER Constantinos Kouloumbris <c@kouloumbris.com>

# Setup proxy
ENV http_proxy http://10.185.207.118:8080
ENV https_proxy http://10.185.207.118:8080
ENV no_proxy booking.com,corp.pcln.com,rentalcars.com,traveljigsaw.com,traveljigsaw.local
ENV http_proxy_request_fullurl false

ENV HTTP_PROXY http://10.185.207.118:8080
ENV HTTPS_PROXY http://10.185.207.118:8080
ENV NO_PROXY booking.com,corp.pcln.com,rentalcars.com,traveljigsaw.com,traveljigsaw.local
ENV HTTP_PROXY_REQUEST_FULLURL false

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
	screen \
	wget \
	curl \
	tree \
	htop \
	zsh

# Install Oh My Zsh
RUN git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh \
      && cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc \
      && chsh -s /bin/zsh

# Cleanup
RUN apt-get autoremove -y
RUN apt-get clean
RUN apt-get autoclean
