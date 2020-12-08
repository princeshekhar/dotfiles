#!/bin/bash

set -euo pipefail

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Link dotfiles
for dotfile in "$DIR"/dotfiles/*
do
    # don't replace it if it's already there
    bn=$(basename "$dotfile")
    home_dotfile="$HOME/.$bn"
    test -f "$home_dotfile" -o -L "$home_dotfile" && continue
    ln -s "$dotfile" "$home_dotfile"
done

# set up zsh
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    cd "$HOME/.oh-my-zsh"
    git pull
fi
