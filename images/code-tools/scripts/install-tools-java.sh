#!/bin/bash

echo "\e[33m############################## Installing JAVA and OPENJDK ##############################"
echo oracle-java11-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
apt-get update && apt-get -y install openjdk-11-jdk

echo "\e[32m############################## JAVA and OPENJDK INSTALLED ##############################\e[0m"
