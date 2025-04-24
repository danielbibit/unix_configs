# echo 'Name of the user to config:'
# read user
sudo apt update
sudo apt install vim curl ranger tmux -y
ln -sf $PWD/.wezterm.lua $HOME/.wezterm.lua
ln -sf $PWD/tmux.conf $HOME/.tmux.conf
ln -sf $PWD/ranger/rc.conf $HOME/.config/ranger/rc.conf
ln -sf $PWD/.bashrc $HOME/.bashrc
ln -sf $PWD/nvim $HOME/.config/

mkdir $HOME/.vim/config
ln -sf $PWD/vim/*.vim $HOME/.vim/config/
ln -sf $PWD/vim/vimrc $HOME/.vimrc

echo 'Done!'
