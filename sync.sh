#!/bin/bash

# Sync sway configs
linux() {
    # Unique linux config files
    cp -i "$HOME"/.config/sway/config sway/
    cp -i -R "$HOME"/.config/waybar .
    cp -i -R "$HOME"/.config/rofi .

    # Terminal setup
    cp -i "$HOME"/.zshrc zshrc/"$os"/zshrc
    cp -i "$HOME"/.hyper.js hyper/"$os"
    cp -i "$HOME"/.vimrc vim/"$os"
}

macos() {
    # Terminal setup
    cp -i "$HOME"/.zshrc zshrc/"$os"/zshrc
    cp -i "$HOME"/.hyper.js hyper/"$os"
    cp -i "$HOME"/.vimrc vim/"$os"
}

if [ "$(uname -s)" = "Darwin" ]; then
    os="macos"
    macos
elif [ "$(uname -s)" = "Linux" ]; then
    os="linux"
    linux
fi

# Commit and sync to github :)
git add .
git commit -m "$(date '+%T, %d %B %Y')"
git push
echo "Copied new files and synced!"