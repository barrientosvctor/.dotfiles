#!/bin/bash

folder_name=".dotfiles"

echo "${folder_name}"

# Install packages
sudo apt install git tmux gcc g++ cmake

# Symlink files
ln -s ~/${folder_name}/.bashrc ~/.bashrc
ln -s ~/${folder_name}/.editorconfig ~/.editorconfig
ln -s ~/${folder_name}/.prettierrc.json ~/.prettierrc.json
ln -s ~/${folder_name}/.gitconfig ~/.gitconfig
ln -s ~/${folder_name}/.tmux.conf ~/.tmux.conf

echo "Installed packages: git, tmux, gcc, g++, cmake"
