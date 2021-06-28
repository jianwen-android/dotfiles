#!/bin/bash

declare -a changedFiles
declare -a noSync

changedFiles=("hyper.js" "betterdiscord" "zshrc" "vimrc")
noSync=("hyper.js")

echo
echo "Files to exclude?"
read -p "[N]one [0-...]: " -r
echo
for number in $REPLY
do
    noSync+=("${changedFiles["$number"]}")
done

for file in "${changedFiles[@]}" ; do
    if  [[ ! $file = "sway" ||  ! $file = "waybar" || ! $file = "rofi" ]]; then
        if [[ ! "${noSync[@]}" =~ "${file}" ]]; then # if the file is not excluded
            echo "Syncing $file"
        fi
    elif [[ $file = "betterdiscord" ]]; then
        echo "Syncing betterdiscord"
    else
        echo "Syncing $file"
    fi
done