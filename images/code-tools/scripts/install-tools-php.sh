#!/bin/bash

echo "\e[33m########################## Installing PHP and COMPOSER w/$1 TZ ##########################"
export DEBIAN_FRONTEND=noninteractive

ln -fs /usr/share/zoneinfo/$1 /etc/localtime
apt-get install -y tzdata
dpkg-reconfigure --frontend noninteractive tzdata

apt-get update
apt-get install -y php-cli php-zip composer


echo "\e[32m########################## PHP and COMPOSER INSTALLED ##########################\e[0m"
