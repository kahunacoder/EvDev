#!/bin/bash

echo "\e[32m############################## Installing JAVA and OPENJDK ##############################\e[0m"
echo oracle-java11-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
apt-get update && apt-get -y install openjdk-11-jdk