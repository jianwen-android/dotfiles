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

read -p "Show diffs? [Y]es [N]o: " -r
echo
if [[ "$REPLY" =~ ^[Yy]$ ]]; then
    while :; do 
        read -p "Enter index of file (-1 to exit): " -r
        if [[ "$REPLY" = -1 ]]; then
            break
        else
            file="${changedFiles["$REPLY"]}"
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
                    *) echo "Invalid input (0-...)"
                esac
            
        fi
    done
fi

# Terminal setup
rsync -azPu "$HOME"/.zshrc zshrc/"$os"/zshrc
rsync -azPu "$HOME"/.hyper.js hyper/"$os"/hyper.js
rsync -azPu "$HOME"/.vimrc vim/"$os"/vimrc
rsync -azPu "$HOME"/.p10k.zsh p10k/"$os"/p10k.zsh
# bro ok

if [[ "$os" = linux ]]; then
    rsync -azPu "$HOME"/.config/sway "$HOME"/.config/waybar "$HOME"/.config/rofi .
fi

# Insert copying code here

git add .
git commit -m "$(date '+%T, %d %B %Y')"
git push
echo ""
echo "Copied new files and synced!"

# Heres how it goes
# COMPARE ALL FILES BY YDIFF
# IF OS IS LINUX
#     DO YOUR EXTRA STEPS
#
# COUNT NUMBER OF DIFFS + WHICH ONES ARE DIFFS
#     NO DIFFS: EXIT 1
# PRINT FILE + INDEX
# ASK IF I SHOULD SHOW WHAT ARE DIFFS?
#     YES: WHICH ONE BABE?
#         TAKE INDEX, SLAP INTO ARRAY
#         RETURNS YDIFF OUTPUT
#         LOOP
#     NO: PASS
# COPY
# EXIT 1
