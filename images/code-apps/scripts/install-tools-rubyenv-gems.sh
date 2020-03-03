#!/bin/bash

echo "\e[33m######################### Installing RBENV and GLOBAL GEMS #########################"

curl -sL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer | bash -
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(rbenv init -)"' >> ~/.zshrc
source ~/.zshrc
eval "$(rbenv init -)"

rbenv install 2.5.1
rbenv global 2.5.1
echo "gem: --no-document" >> ~/.gemrc
# echo "gem: — no-rdoc — no-ri" > ~/.gemrc

# gem_packages:
gem install \
  bundler \
  bigdecimal \
  colorator \
  concurrent-ruby \
  did_you_mean \
  http_parser.rb \
  i18n \
  io-console \
  jekyll \
  jekyll-sass-converter \
  jekyll-sitemap \
  jekyll-tagging \
  jekyll-watch \
  json \
  kramdown \
  liquid \
  listen \
  mercenary \
  minitest \
  mkpasswd \
  net-scp \
  net-ssh \
  net-telnet \
  nokogiri \
  nuggets \
  pathutil \
  power_assert \
  psych \
  rake \
  rb-inotify \
  rouge \
  safe_yaml \
  sqlite3 \
  sshkit \
  unix-crypt \
  tmuxinator

echo "\e[32m######################### RUBY w/RBENV and GLOBAL GEMS INSTALLED #########################\e[0m"
