# echo 'Name of the user to config:'
# read user

sudo ln -sf $PWD/vimrc /etc/vim/vimrc
sudo ln -sf $PWD/tmux.conf /etc/tmux.conf

# cp .bash_profile /home/$user/
ln -sf $PWD/.bashrc /home/$(whoami)/.bashrc
ln -sf $PWD/.gitconfig /home/$(whoami)/.gitconfig
