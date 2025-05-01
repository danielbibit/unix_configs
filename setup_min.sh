#!/bin/sh

# List of packages to install
PACKAGES="vim ranger xsel bash curl git"

if command -v apk >/dev/null 2>&1; then
    echo "Detected apk (Alpine Linux)"
    apk update
    apk add --no-cache $PACKAGES

elif command -v apt-get >/dev/null 2>&1; then
    echo "Detected apt-get (Debian/Ubuntu)"
    apt-get update
    apt-get install -y $PACKAGES
else
    echo "Unknown package manager. Cannot install packages."
    exit 1
fi

# install lazygit
LAZYGIT_VER=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VER}/lazygit_${LAZYGIT_VER}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
install lazygit -D -t /usr/local/bin/
rm lazygit.tar.gz
rm lazygit

# Install television
TELEVISION_VER=`curl -s "https://api.github.com/repos/alexpasmantier/television/releases/latest" | grep '"tag_name":' | sed -E 's/.*"tag_name": "([^"]+)".*/\1/'`
curl -LO https://github.com/alexpasmantier/television/releases/download/$TELEVISION_VER/tv-$TELEVISION_VER-x86_64-unknown-linux-musl.tar.gz
tar -xzf tv-$TELEVISION_VER-x86_64-unknown-linux-musl.tar.gz
mv tv-$TELEVISION_VER-x86_64-unknown-linux-musl/tv /usr/local/bin/
rm tv-$TELEVISION_VER-x86_64-unknown-linux-musl.tar.gz
rm -rf tv-$TELEVISION_VER-x86_64-unknown-linux-musl

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
