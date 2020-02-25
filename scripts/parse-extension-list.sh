#!/bin/bash

echo "\e[33m############################## CREATING extensions.list FROM GIST ##############################"

jq -r ".[].metadata.publisherId" ../extensions.json > ../extensions.list

echo "\e[32m############################## extensions.list FROM GIST CREATED ##############################\e[0m"
