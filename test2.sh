#!/bin/bash

declare -a changedFiles

#OS check
if [ "$(uname -s)" = "Darwin" ]; then
    os="macos"
elif [ "$(uname -s)" = "Linux" ]; then
    os="linux"
fi

if [[ $(ydiff "$HOME"/.hyper.js ./hyper/"$os"/hyper.js) ]]; then
    changedFiles+=("hyper"); fi
if [[ $(ydiff "$HOME"/.zshrc ./zshrc/"$os"/zshrc) ]]; then
    changedFiles+=("zshrc"); fi
if [[ $(ydiff "$HOME"/.p10k.zsh ./p10k/"$os"/p10k.zsh) ]]; then
    changedFiles+=("p10k"); fi
if [[ $(ydiff "$HOME"/.vimrc ./vimrc/"$os"/vimrc) ]]; then
    changedFiles+=("vimrc"); fi

if [[ "$os" = linux ]]; then
    if [[ $(ydiff "$HOME"/.config/sway ./sway) ]]; then
        changedFiles+=("sway"); fi
    if [[ $(ydiff "$HOME"/.config/waybar ./waybar) ]]; then
        changedFiles+=("waybar"); fi
    if [[ $(ydiff "$HOME"/.config/rofi ./rofi) ]]; then
        changedFiles+=("rofi"); fi
fi

echo "You have ${#changedFiles[@]} file(s) changed"
if [[ ! ${#changedFiles[@]} = 0 ]]; then
    echo
    count=0
    for each in "${changedFiles[@]}"; do
        echo "$count" "$each" 
        ((count+=1))
    done
    echo
fi

while :; do
    read -p "Show diffs? [Y]es [N]o: " -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        while :; do 
        read -p "Enter index of file (-1 to exit): " -r
        file=changedFiles["$REPLY"]
        echo "$file"
            case $file in
                "hyper") ydiff "$HOME"/.hyper.js ./hyper/"$os"/hyper.js
                ;;
                "zshrc") ydiff "$HOME"/.zshrc ./zshrc/"$os"/zshrc
                ;;
                "p10k") ydiff "$HOME"/.p10k.zsh ./hyper/"$os"/p10k.zsh
                ;;
                "vimrc") ydiff "$HOME"/.vimrc ./vimrc/"$os"/vimrc
                ;;
                "sway") ydiff "$HOME"/.config/sway ./sway
                ;;
                "waybar") ydiff "$HOME"/.config/waybar ./waybar
                ;;
                "rofi") ydiff "$HOME"/.config/rofi ./rofi
                ;;
                "-1") break
                ;;
                *) echo "Invalid input (0-...)"
            esac
        done
    elif [[ $REPLY =~ ^[Nn]$ ]]; then
        break
    fi
done