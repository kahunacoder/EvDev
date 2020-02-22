#!/bin/bash

echo "\e[32m############################## Installing VSCODE EXTENSIONS ##############################\e[0m"

while IFS='' read -r line || [[ -n "$line" ]]; do
    echo "Installing $line using VSCode";
    code --user-data-dir /root/.config/Code --install-extension $line
done < "$1"
