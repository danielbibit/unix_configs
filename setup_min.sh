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

    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf lazygit.tar.gz lazygit
    install lazygit -D -t /usr/local/bin/
    rm lazygit.tar.gz
    rm lazygit
else
    echo "Unknown package manager. Cannot install packages."
    exit 1
fi

mkdir -p $HOME/.vim/config
ln -sf $PWD/vim/*.vim $HOME/.vim/config/
ln -sf $PWD/vim/vimrc $HOME/.vimrc
sed -i '/source ~\/\.vim\/config\/plugins.vim/d' "$HOME/.vimrc"

mkdir -p $HOME/.config/ranger
ln -sf $PWD/ranger/rc.conf $HOME/.config/ranger/rc.conf
rm -f $HOME/.config/ranger/rifle.conf
echo "mime ^text = code \"\$@\"">> $HOME/.config/ranger/rifle.conf

ln -sf $PWD/.wezterm.lua $HOME/.wezterm.lua
ln -sf $PWD/tmux.conf $HOME/.tmux.conf
ln -sf $PWD/.bashrc $HOME/.bashrc
ln -sf $PWD/nvim $HOME/.config/

echo 'Done!'
