# echo 'Name of the user to config:'
# read user
sudo apt update
sudo apt install vim curl ranger tmux -y
ln -sf $PWD/.wezterm.lua /home/$(whoami)/.wezterm.lua
ln -sf $PWD/vimrc /home/$(whoami)/.vimrc
ln -sf $PWD/tmux.conf /home/$(whoami)/.tmux.conf
ln -sf $PWD/ranger/rc.conf /home/$(whoami)/.config/ranger/rc.conf
ln -sf $PWD/.bashrc /home/$(whoami)/.bashrc
ln -sf $PWD/nvim $HOME/.config/

echo 'Done!'
