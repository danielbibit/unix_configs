# echo 'Name of the user to config:'
# read user
sudo apt update
sudo apt install vim curl ranger tmux ripgrep fd-find -y
ln -sf $PWD/.wezterm.lua $HOME/.wezterm.lua
ln -sf $PWD/tmux.conf $HOME/.tmux.conf
ln -sf $PWD/ranger/rc.conf $HOME/.config/ranger/rc.conf
ln -sf $PWD/.bashrc $HOME/.bashrc
ln -sf $PWD/nvim $HOME/.config/
ln -sf $PWD/lazygit.yml /$HOME/.config/lazygit/config.yml

mkdir -p $HOME/.vim/config
ln -sf $PWD/vim/*.vim $HOME/.vim/config/
ln -sf $PWD/vim/vimrc $HOME/.vimrc

echo 'Done!'
