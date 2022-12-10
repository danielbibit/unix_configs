sudo cp vimrc /etc/vim/
sudo cp tmux.conf /etc/tmux.conf

echo 'Name of the user to config:'
read user

# cp .bashrc /home/$user/
# cp .bash_profile /home/$user/
cp .gitconfig /home/$user/
