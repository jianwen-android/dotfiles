#!/bin/bash

declare -a changedFiles
declare -a noSync

#OS check
if [ "$(uname -s)" = "Darwin" ]; then
    os="macos"
elif [ "$(uname -s)" = "Linux" ]; then
    os="linux"
fi

if [[ $(ydiff "$HOME"/.hyper.js ./hyper/"$os"/hyper.js) ]]; then
    changedFiles+=("hyper.js"); fi
if [[ $(ydiff "$HOME"/.zshrc ./zshrc/"$os"/zshrc) ]]; then
    changedFiles+=("zshrc"); fi
if [[ $(ydiff "$HOME"/.p10k.zsh ./p10k/"$os"/p10k.zsh) ]]; then
    changedFiles+=("p10k.zsh"); fi
if [[ $(ydiff "$HOME"/.vimrc ./vimrc/"$os"/vimrc) ]]; then
    changedFiles+=("vimrc"); fi
if [[ $(ydiff "$HOME"/spicetify_data ./"$os"/spicetify) || $(ydiff "$HOME"/.config/spicetify ./"$os"/spicetify) ]]; then
    changedFiles+=("spicetify"); fi

if [[ "$os" = linux ]]; then
    if [[ $(ydiff "$HOME"/.config/sway ./sway) ]]; then
        changedFiles+=("sway"); fi
    if [[ $(ydiff "$HOME"/.config/waybar ./waybar) ]]; then
        changedFiles+=("waybar"); fi
    if [[ $(ydiff "$HOME"/.config/rofi ./rofi) ]]; then
        changedFiles+=("rofi"); fi
    if [[ $(ydiff "$HOME"/.config/BetterDiscord ./betterdiscord) ]]; then
        changedFiles+=("betterdiscord"); fi
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
    read -p "Enter index of file (-1 to exit): " -r
    if [[ "$REPLY" = -1 ]]; then
        break
    else
        file="${changedFiles["$REPLY"]}"
            case $file in
                "hyper.js") ydiff ./hyper/"$os"/hyper.js "$HOME"/.hyper.js
                ;;
                "zshrc") ydiff ./zshrc/"$os"/zshrc "$HOME"/.zshrc
                ;;
                "p10k.zsh") ydiff ./hyper/"$os"/p10k.zsh "$HOME"/.p10k.zsh
                ;;
                "vimrc") ydiff ./vimrc/"$os"/vimrc "$HOME"/.vimrc
                ;;
                "sway") ydiff ./sway "$HOME"/.config/sway
                ;;
                "waybar") ydiff ./waybar "$HOME"/.config/waybar
                ;;
                "rofi") ydiff ./rofi "$HOME"/.config/rofi
                ;;
                "betterdiscord") ydiff ./betterdiscord "$HOME"/.config/BetterDiscord
                ;;
                "spicetify")
                if [[ "$os" = "macos" ]]; then
                    ydiff ./spicetify/"$os" "$HOME"/spicetify_data
                elif [[ "$os" = "linux" ]]; then
                    ydiff ./spicetify/"$os" "$HOME"/.config/spicetify
                fi
                ;;
                *) echo "Invalid input (0-...)"
            esac
    fi
done


# Terminal setup
echo
echo "Files to exclude?"
read -p "[N]one [0-...]: " -r
echo
for number in $REPLY
do
    noSync+=("${changedFiles["$number"]}")
done

for file in "${changedFiles[@]}" ; do
    if [[ ! "${noSync[@]}" =~ "${file}" ]]; then # if the file is not excluded
        if  [[ $file = "sway" ||  $file = "waybar" || $file = "rofi" ]]; then # if file is sway config
            echo "Syncing $file"
        elif [[ $file = "betterdiscord" ]]; then
            echo "Syncing betterdiscord"
        elif [[ $file = "spicetify" ]]; then # spicetify
            echo "Syncing spicetify"
        else
            echo "Syncing $file"
        fi
    fi
done

# Commit
git add .
git commit -m "$(date '+%a %d %b %I:%M %p')"
git push
echo ""
echo "Copied new files and synced!"

#TODO you fat shit
# add spicetify
