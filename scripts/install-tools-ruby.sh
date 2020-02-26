#!/bin/bash

echo 'Installing ruby w/rbenv and gems...'
echo "\e[33m######################### Installing RUBY w/RBENV and GLOBAL GEMS #########################"

apt update
apt install -y libssl-dev libreadline-dev zlib1g-dev autoconf bison build-essential libyaml-dev libreadline-dev libncurses5-dev libffi-dev libgdbm-dev

# curl -sL https://github.com/rbenv/rbenv-installer/raw/master/bin/rbenv-installer | bash -

echo "\e[32m######################### RUBY w/RBENV and GLOBAL GEMS INSTALLED #########################\e[0m"
