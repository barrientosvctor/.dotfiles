#!/bin/bash

# Default folder name
folder_name=".dotfiles"

# It updates packages
sudo apt update && sudo apt upgrade
echo "------ Packages updated and upgraded -------"
sudo apt install git
echo "------ GIT package successfully installed ------"
sudo apt install tmux
echo "------ TMUX package successfully installed ------"
echo "------ Installing dependencies to build VIM... ------"
sudo apt-get install make libncurses5-dev libncursesw5-dev build-essential
echo "------ VIM dependencies successfully installed ------"
echo "------ Installing VIM...  ------"
git clone https://github.com/barrientosvctor/vim.git ~/vim
cd ~/vim/src
make
sudo make install
git clone git@github.com:barrientosvctor/vimrc.git ~/.vim
cd ~/.vim
git submodule init
git submodule update
echo "------ VIM successfully installed ------"
cd ~/$folder_name
echo "------ Setting symlinks... ------"
ln -s ~/$folder_name/.bashrc ~/.bashrc
ln -s ~/$folder_name/.zshrc ~/.zshrc
ln -s ~/$folder_name/.editorconfig ~/.editorconfig
ln -s ~/$folder_name/.prettierrc.json ~/.prettierrc.json
ln -s ~/$folder_name/.tmux.conf ~/.tmux.conf
echo "------ All symlinks successfully set ------"
echo "Packages installed: git, tmux, vim"
