#!/bin/bash

folder_name=".dotfiles"

install_vim_from_source() {
	sudo apt-get install lua5.1 liblua5.1-dev make

	git clone https://github.com/vim/vim.git ~/vim
	cd ~/vim

	./configure --with-features=huge \
            --enable-cscope \
            --enable-multibyte \
            --enable-fontset \
            --disable-gui \
            --disable-netbeans \
            --enable-luainterp=yes
	make
	sudo make install
}

setup_vimrc() {
	git clone git@github.com:barrientosvctor/vimrc.git ~/.vim
	cd ~/.vim
	make
}

# Install packages
sudo apt install git tmux gcc g++ cmake

# Symlink files
ln -s ~/${folder_name}/.bashrc ~/.bashrc
ln -s ~/${folder_name}/.editorconfig ~/.editorconfig
ln -s ~/${folder_name}/.prettierrc.json ~/.prettierrc.json
ln -s ~/${folder_name}/.gitconfig ~/.gitconfig
ln -s ~/${folder_name}/.tmux.conf ~/.tmux.conf

echo "Installed packages: git, tmux, gcc, g++, cmake"
