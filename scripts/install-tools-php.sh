#!/bin/bash

echo "\e[32m########################## Installing PHP and COMPOSER w/ GLOBALS ##########################\e[0m"
export DEBIAN_FRONTEND=noninteractive

ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime
apt-get install -y tzdata
dpkg-reconfigure --frontend noninteractive tzdata

apt-get update
apt-get install -y php-cli php-zip composer

composer global require friendsofphp/php-cs-fixer
composer global require laravel/installer
# composer global require phpunit/phpunit
# composer global require phpunit/dbunit
# composer global require phing/phing
# composer global require phpdocumentor/phpdocumentor
# composer global require sebastian/phpcpd
# composer global require phploc/phploc
# composer global require phpmd/phpmd
# composer global require squizlabs/php_codesniffer
