#!/bin/bash

echo "\e[32m############################## Installing PYTHON and PIP ##############################\e[0m"
apt-get update && apt-get install -y python3 python3-pip
pip3 install python-language-server