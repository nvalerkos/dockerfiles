FROM ubuntu:latest

MAINTAINER Constantinos Kouloumbris <c@kouloumbris.com>

# Surpress Upstart errors/warning
RUN dpkg-divert --local --rename --add /sbin/initctl \
    && ln -sf /bin/true /sbin/initctl

# Install packages and Oh My Zsh and cleanup
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y supervisor \
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
        zsh \
        iputils-ping \
        net-tools \
        telnet \
        tzdata \
    && git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh \
    && cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc \
    && chsh -s /bin/zsh \
    && apt-get autoremove -y \
    && apt-get clean \
    && apt-get autoclean
RUN cp /usr/share/zoneinfo/Europe/London /etc/localtime
