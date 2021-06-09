#!/bin/bash

# Sync sway configs

prompt() {
    echo "Compare files?"
    read -p "[N]one [A]ll [D]ffs" -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Nn]$ ]]; then
        exit 1
    elif [[ $REPLY =~ ^[Aa]$ ]]; then
        read -p "Which one?" -n 1 -r
        if [[ $REPLY =~ ^hyper|js ]]; then
            diff -y $HOME/.hyper.js ./hyper/$os/hyper.js
        
        elif [[ $REPLY =~ ^p10k|zsh ]]; then
            diff -y $HOME/.p10k.zsh ./hyper/$os/p10k.zsh


    fi

    echo ""
    read -p "We good boss? " -n 1 -r
    echo    # (optional) move to a new line
    if [[ ! $REPLY =~ ^[Yy]$ ]]
    then
        exit 1
    fi
}

linux() {
    #Test
    rsync -azunv "$HOME"/.config/sway "$HOME"/.config/waybar "$HOME"/.config/rofi .

    rsync -azunv "$HOME"/.zshrc zshrc/"$os"/zshrc
    rsync -azunv "$HOME"/.hyper.js hyper/"$os"/hyper.js
    rsync -azunv "$HOME"/.vimrc vim/"$os"/vimrc
    rsync -azunv "$HOME"/.p10k.zsh p10k/"$os"/p10k.zsh

    { echo "Hello" ;echo "Yooo" ;} && { echo "Hello" ;echo "Yooo" ;}>checksum.txt

    prompt

    # Unique linux config files
    rsync -azPu "$HOME"/.config/sway "$HOME"/.config/waybar "$HOME"/.config/rofi .

    # Terminal setup
    rsync -azPu "$HOME"/.zshrc zshrc/"$os"/zshrc
    rsync -azPu "$HOME"/.hyper.js hyper/"$os"/hyper.js
    rsync -azPu "$HOME"/.vimrc vim/"$os"/vimrc
    rsync -azPu "$HOME"/.p10k.zsh p10k/"$os"/p10k.zsh
}

macos() {
    # Test
    rsync -azunv "$HOME"/.zshrc zshrc/"$os"/zshrc
    rsync -azunv "$HOME"/.hyper.js hyper/"$os"/hyper.js
    rsync -azunv "$HOME"/.vimrc vim/"$os"/vimrc
    rsync -azunv "$HOME"/.p10k.zsh p10k/"$os"/p10k.zsh

    prompt

    # Terminal setup
    rsync -azPu "$HOME"/.zshrc zshrc/"$os"/zshrc
    rsync -azPu "$HOME"/.hyper.js hyper/"$os"/hyper.js
    rsync -azPu "$HOME"/.vimrc vim/"$os"/vimrc
    rsync -azPu "$HOME"/.p10k.zsh p10k/"$os"/p10k.zsh
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


#TODO research and find out more about rsync
# possible command rsync -azPu
# in leiu of the lack of a interactive command
# we can dry run
# rsync -azunv