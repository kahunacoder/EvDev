#!/bin/bash

echo "\e[33m############################## GETTING VSCODE SETTINGS FROM GIST ##############################"

gistid=`cat ../sync.gist`
gisturl="https://gist.githubusercontent.com/${gistid}/raw"

curl -o ../extensions.json "${gisturl}/extensions.json"
curl -o ../settings.json "${gisturl}/settings.json"

echo "\e[32m############################## VSCODE SETTINGS FROM GIST DOWNLOADED ##############################\e[0m"
