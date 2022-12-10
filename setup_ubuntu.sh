# echo 'Name of the user to config:'
# read user

ln -sf $PWD/vimrc /home/$(whoami)/.vimrc
ln -sf $PWD/tmux.conf /home/$(whoami)/.tmux.conf
# cp .bash_profile /home/$user/

ln -sf $PWD/.bashrc /home/$(whoami)/.bashrc
ln -sf $PWD/.gitconfig /home/$(whoami)/.gitconfig
