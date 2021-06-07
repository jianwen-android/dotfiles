#!/bin/bash

# Sync sway configs
linux() {
    # Unique linux config files
    cp -iRu "$HOME"/.config/sway/config sway/
    cp -iRu "$HOME"/.config/waybar .
    cp -iRu "$HOME"/.config/rofi .

    # Terminal setup
    cp -iRu "$HOME"/.zshrc zshrc/"$os"/zshrc
    cp -iRu "$HOME"/.hyper.js hyper/"$os"/hyper.js
    cp -iRu "$HOME"/.vimrc vim/"$os"/vimrc
    cp -iRu "$HOME"/.p10k.zsh p10k/"$os"/p10k.zsh
}

macos() {
    # Terminal setup
    cp -iRu "$HOME"/.zshrc zshrc/"$os"/zshrc
    cp -iRu "$HOME"/.hyper.js hyper/"$os"/hyper.jsh
    cp -iRu "$HOME"/.vimrc vim/"$os"/vimrc
    cp -iRu "$HOME"/.p10k.zsh p10k/"$os"/p10k.zsh
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
echo ""
echo "Copied new files and synced!"
