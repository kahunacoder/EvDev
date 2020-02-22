#!/bin/bash

echo "\e[32m############################## GETTING VSCODE SETTINGS FROM GIST ##############################\e[0m"

gistid=`cat ../sync.gist`
gisturl="https://gist.githubusercontent.com/${gistid}/raw"

curl -o ../extensions.json "${gisturl}/extensions.json"
curl -o ../settings.json "${gisturl}/settings.json"
