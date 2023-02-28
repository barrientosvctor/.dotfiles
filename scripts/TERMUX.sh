#!/bin/bash

# Default folder name
folder_name=".dotfiles"

# It sets 'storage' folder in termux
termux-setup-storage

# It updates packages
apt update
apt upgrade
echo "------ Packages updated and upgraded -------"
apt install git
echo "------ GIT package successfully installed -------"
apt install nodejs
echo "------ NODEJS package successfully installed ------"
apt install tmux
echo "------ TMUX package successfully installed -------"
apt install vim
echo "------ VIM package successfully installed -------"
apt install openssh
echo "------ SSH package successfully installed -------"
echo "------ Setting vimrc... ------"
git clone https://github.com/barrientosvctor/vimrc.git ~/.vim
cd ~/.vim
git submodule init
git submodule update
echo "------ Vimrc set ------"
cd ~/$folder_name
echo "------ Setting symlinks... ------"
ln -s ~/$folder_name/.bashrc ~/.bashrc
ln -s ~/$folder_name/.zshrc ~/.zshrc
ln -s ~/$folder_name/.editorconfig ~/.editorconfig
ln -s ~/$folder_name/.prettierrc.json ~/.prettierrc.json
ln -s ~/$folder_name/.tmux.conf ~/.tmux.conf
echo "------ All symlinks successfully set ------"
echo "Packages installed: git, nodejs, tmux, ssh, vim"
