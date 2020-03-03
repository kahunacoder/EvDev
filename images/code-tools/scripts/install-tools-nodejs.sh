#!/bin/bash

echo "\e[33m############################ Installing NODE.JS and YARN ############################"
# Install Node.js
curl -sL https://deb.nodesource.com/setup_12.x | bash -

# Install Yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

apt-get update && apt-get install -y yarn nodejs

echo "\e[32m############################ NODE.JS and YARN INSTALLED ############################\e[0m"
