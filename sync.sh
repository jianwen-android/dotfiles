#!/bin/bash

# Sync sway configs
linux() {
    # Unique linux config files
    cp -i -R -u "$HOME"/.config/sway/config sway/
    cp -i -R -u "$HOME"/.config/waybar .
    cp -i -R -u "$HOME"/.config/rofi .

    # Terminal setup
    cp -i -R -u "$HOME"/.zshrc zshrc/"$os"/zshrc
    cp -i -R -u "$HOME"/.hyper.js hyper/"$os"/hyper.js
    cp -i -R -u "$HOME"/.vimrc vim/"$os"/vimrc
    cp -i -R -u "$HOME"/.p10k.zsh p10k/"$os"/p10k.zsh
}

macos() {
    # Terminal setup
    cp -i -R -u "$HOME"/.zshrc zshrc/"$os"/zshrc
    cp -i -R -u "$HOME"/.hyper.js hyper/"$os"/hyper.jsh
    cp -i -R -u "$HOME"/.vimrc vim/"$os"/vimrc
    cp -i -R -u "$HOME"/.p10k.zsh p10k/"$os"/p10k.zsh
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
echo "\n"
echo "Copied new files and synced!"