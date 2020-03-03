#!/bin/bash

echo "\e[33m########################## COMPOSER GLOBALS ##########################"
export DEBIAN_FRONTEND=noninteractive

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

echo "\e[32m########################## COMPOSER GLOBALS INSTALLED ##########################\e[0m"
