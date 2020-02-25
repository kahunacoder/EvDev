#!/bin/bash

echo 'Installing ruby w/rbenv and gems...'
echo "\e[33m######################### Installing RUBY w/RBENV and GLOBAL GEMS #########################"
# apt-get update
# apt-get install -y ruby-full rubygems

apt update
apt install -y git curl libssl-dev libreadline-dev zlib1g-dev autoconf bison build-essential libyaml-dev libreadline-dev libncurses5-dev libffi-dev libgdbm-dev

curl -sL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer | bash -

# echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshrc
# echo 'eval "$(rbenv init -)"' >> ~/.zshrc
source ~/.zshrc

rbenv install 2.5.1
rbenv global 2.5.1

echo "gem: --no-document" > ~/.gemrc

# gem_packages:
gem install bundler addressable airbrussh bigdecimal capistrano colorator concurrent-ruby did_you_mean em-websocket eventmachine ffi forwardable-extended http_parser.rb i18n io-console jekyll jekyll-sass-converter jekyll-sitemap jekyll-tagging jekyll-watch json kramdown libxml-ruby liquid listen mercenary minitest mkpasswd net-scp net-ssh net-telnet nokogiri nuggets pathutil power_assert psych public_suffix rake rb-fsevent rb-inotify rdoc rouge ruby_dep safe_yaml sass sass-listen sqlite3 sshkit test-unit unix-crypt

rbenv rehash

echo "\e[32m######################### RUBY w/RBENV and GLOBAL GEMS INSTALLED #########################\e[0m"
