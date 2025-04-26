#!/bin/sh

# List of packages to install
PACKAGES="vim ranger xsel bash curl git"

if command -v apk >/dev/null 2>&1; then
    echo "Detected apk (Alpine Linux)"
    apk update
    apk add --no-cache $PACKAGES
    apk add lazygit

elif command -v apt-get >/dev/null 2>&1; then
    echo "Detected apt-get (Debian/Ubuntu)"
    apt-get update
    apt-get install -y $PACKAGES

else
    echo "Unknown package manager. Cannot install packages."
    exit 1
fi

mkdir -p $HOME/.vim/config
ln -sf $PWD/vim/*.vim $HOME/.vim/config/
ln -sf $PWD/vim/vimrc $HOME/.vimrc

ln -sf $PWD/.wezterm.lua $HOME/.wezterm.lua
ln -sf $PWD/tmux.conf $HOME/.tmux.conf
ln -sf $PWD/ranger/rc.conf $HOME/.config/ranger/rc.conf
ln -sf $PWD/.bashrc $HOME/.bashrc
ln -sf $PWD/nvim $HOME/.config/

echo 'Done!'
