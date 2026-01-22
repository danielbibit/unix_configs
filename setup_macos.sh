# Remove dock launch delay
defaults write com.apple.dock autohide-delay -float 0;
defaults write com.apple.dock autohide-time-modifier -int 0;
killall Dock

brew install git
brew install mac-mouse-fix
brew install neovim
brew install lazygit
brew install ranger
brew install tmux
brew install orbstack

brew install --cask karabiner-elements
brew install --cask betterdisplay
brew install --cask keepassxc
brew install --cask alt-tab
brew install --cask rectangle

ln -sf $PWD/.zshrc $HOME/.zshrc

ln -sf $PWD/.wezterm.lua $HOME/.wezterm.lua
ln -sf $PWD/tmux.conf $HOME/.tmux.conf
ln -sf $PWD/ranger/rc.conf $HOME/.config/ranger/rc.conf
ln -sf $PWD/nvim $HOME/.config/

mkdir -p $HOME/.config/lazygit
ln -sf $PWD/lazygit.yml /$HOME/.config/lazygit/config.yml

mkdir -p $HOME/.vim/config
ln -sf $PWD/vim/*.vim $HOME/.vim/config/
ln -sf $PWD/vim/vimrc $HOME/.vimrc

echo 'Done!'
