echo 'Name of the user to config:'
read user

sudo ln -sf $PWD/vimrc /etc/vim/vimrc
sudo ln -sf $PWD/tmux.conf /etc/tmux.conf

# cp .bashrc /home/$user/
# cp .bash_profile /home/$user/
ln -sf $PWD/.gitconfig /home/$user/.gitconfig
