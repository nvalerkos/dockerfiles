FROM centos:centos7

MAINTAINER Constantinos Kouloumbris <c@kouloumbris.com>

#for compatibiltiy
ENV DOCKER_USER_ID 501
ENV DOCKER_USER_GID 20

ENV BOOT2DOCKER_ID 1000
ENV BOOT2DOCKER_GID 50

# # Tweaks to give the web service and php write permissions to the app
#RUN usermod -u ${BOOT2DOCKER_ID} www-data
#RUN usermod -G staff www-data

#RUN groupmod -g $(($BOOT2DOCKER_GID + 10000)) $(getent group $BOOT2DOCKER_GID | cut -d: -f1)
#RUN groupmod -g ${BOOT2DOCKER_GID} staff

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
    zsh

# Install Oh My Zsh
RUN git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh \
      && cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc \
      && chsh -s /bin/zsh

# Cleanup
RUN yum clean all


