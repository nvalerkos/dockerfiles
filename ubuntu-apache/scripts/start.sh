#!/bin/bash

# Disable Strict Host checking for non interactive git clones

mkdir -p -m 0700 /root/.ssh
echo -e "Host *\n\tStrictHostKeyChecking no\n" >> /root/.ssh/config

# Install Extras
if [ ! -z "$DEBS" ]; then
 apt-get update
 apt-get install -y $DEBS
fi

# Again set the right permissions (needed when mounting from a volume)
chown -Rf www-data.www-data /app

# Start supervisord and services
/usr/bin/supervisord -n -c /etc/supervisord.conf
