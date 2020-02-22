#!/bin/bash

echo "\e[32m############################ Installing NODE.JS and YARN w/GLOBALS ############################\e[0m"
# Install Node.js
curl -sL https://deb.nodesource.com/setup_12.x | bash -

# Install Yarn
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

apt-get update && apt-get install -y yarn nodejs

# yarn --global config set user root
yarn global add webpack "@vue/cli" browserify cordova cordova-icon cordova-splash csslint emma-cli eslint eslint-plugin-vue fs jshint n nib npm prettier quasar-cli readline rupture standard stylint typographic wt-cli commitizen