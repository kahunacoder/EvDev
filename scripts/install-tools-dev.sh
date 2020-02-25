#!/bin/bash

echo "\e[33m############################## Installing DEV TOOLS ##############################"

apt-get update
apt-get -y install build-essential pass xz-utils openssl net-tools

echo "\e[32m############################## DEV TOOLS INSTALLED ##############################\e[0m"
