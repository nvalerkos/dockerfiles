FROM ubuntu:latest

MAINTAINER Constantinos Kouloumbris <c@kouloumbris.com>

# Surpress Upstart errors/warning
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN ln -sf /bin/true /sbin/initctl

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
