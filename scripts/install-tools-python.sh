#!/bin/bash

echo "\e[33m############################## Installing PYTHON and PIP ##############################"
apt-get update && apt-get install -y python3 python3-pip
pip3 install python-language-server
echo "\e[32m############################## PYTHON and PIP INSTALLED ##############################\e[0m"
