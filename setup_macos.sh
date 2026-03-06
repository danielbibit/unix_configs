# Remove dock launch delay
defaults write com.apple.dock autohide-delay -float 0;
defaults write com.apple.dock autohide-time-modifier -int 0;
killall Dock

# Remove hold key to show symbol
defaults write -g ApplePressAndHoldEnabled -bool false

# Stop wrinting .DS_Store files on smb shares
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool TRUE

# Essentials
brew install git
brew install neovim
brew install tree-sitter-cli
brew install gnu-tar # For ansible
brew install ffmpeg
brew install fzf

# Development/cli tools
brew install lazygit
brew install tmux
brew install orbstack
brew install yazi
brew install eza
brew install zoxide
brew install bat

# Devops
brew install awscli
brew install opentofu

brew install --cask keepassxc

brew install --cask karabiner-elements
brew install --cask betterdisplay
brew install --cask alt-tab
brew install --cask rectangle-pro
brew install --cask linearmouse

# Add borders to focused window
brew tap FelixKratz/formulae
brew install borders
brew services start borders
mkdir -p $HOME/.config/borders
ln -sf $PWD/bordersrc $HOME/.config/borders/

ln -sf $PWD/.zshrc $HOME/.zshrc

ln -sf $PWD/.wezterm.lua $HOME/.wezterm.lua
ln -sf $PWD/tmux.conf $HOME/.tmux.conf
ln -sf $PWD/nvim $HOME/.config/

mkdir -p $HOME/.config/lazygit
ln -sf $PWD/lazygit.yml /$HOME/.config/lazygit/config.yml

mkdir -p $HOME/.vim/config
ln -sf $PWD/vim/*.vim $HOME/.vim/config/
ln -sf $PWD/vim/vimrc $HOME/.vimrc

mkdir -p $HOME/.config/ghostty
ln -sf $PWD/ghostty/ghostty_macos $HOME/.config/ghostty/config

mkdir -p $HOME/.config/yazi
ln -sf $PWD/yazi/keymap.toml $HOME/.config/yazi/keymap.toml

echo 'Done!'
