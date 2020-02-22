#!/bin/bash

echo "\e[32m############################## CREATING extensions.list FROM GIST ##############################\e[0m"

jq -r ".[].metadata.publisherId" ../extensions.json > ../extensions.list

