#!/bin/bash

case $REPLY in
    "hyper") ydiff "$HOME"/.hyper.js ./hyper/"$os"/hyper.js
    ;;
    "zshrc") ydiff "$HOME"/.zshrc ./zshrc/"$os"/zshrc
    ;;
    "p10k") ydiff "$HOME"/.p10k.zsh ./hyper/"$os"/p10k.zsh
    ;;
    "vimrc") ydiff "$HOME"/.vimrc ./vimrc/"$os"/vimrc
    ;;
    *) echo "Invalid input, try again"
esac

case $REPLY in
    "sway") ydiff "$HOME"/.config/sway ./sway
    ;;
    "waybar") ydiff "$HOME"/.config/waybar ./waybar

    "hyper") ydiff "$HOME"/.hyper.js ./hyper/"$os"/hyper.js
    ;;
    "zshrc") ydiff "$HOME"/.zshrc ./zshrc/"$os"/zshrc
    ;;
    "p10k") ydiff "$HOME"/.p10k.zsh ./hyper/"$os"/p10k.zsh
    ;;
    "vimrc") ydiff "$HOME"/.vimrc ./vimrc/"$os"/vimrc
    ;;
    *) echo "Invalid input, try again"
esac