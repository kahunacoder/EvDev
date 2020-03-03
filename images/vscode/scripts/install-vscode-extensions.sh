#!/bin/bash

echo "\e[33m############################## Installing VSCODE EXTENSIONS ##############################"

while IFS='' read -r line || [[ -n "$line" ]]; do
    echo "\e[33mInstalling $line using VSCode";
    code --user-data-dir /home/coder/.local/share/code-server --install-extension $line
    echo "\e[32m";
done < "$1"

echo "\e[32m############################## VSCODE EXTENSIONS INSTALLED ##############################\e[0m"
