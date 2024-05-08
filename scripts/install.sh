#!/bin/bash

folder_path=$(pwd)

install_vim_from_source() {
	sudo apt-get install lua5.1 liblua5.1-dev make libxt-dev libgtk-3-dev

	git clone https://github.com/vim/vim.git ~/vim
	cd ~/vim

	./configure --with-features=huge \
            --enable-cscope \
            --enable-multibyte \
            --enable-fontset \
            --enable-gui=gtk3 \
            --disable-netbeans \
            --enable-luainterp=yes
	make && sudo make install
}

setup_vimrc() {
	git clone git@github.com:barrientosvctor/vimrc.git ~/.vim
	cd ~/.vim
	make
}

install_packages() {
	# CMake also includes c (cc, gcc) and c++ (g++, c++) compilers.
	sudo apt install git tmux cmake
	echo "Installed packages: git, tmux, cmake"
}

symlink_dotfiles() {
	ln -s ${folder_path}/.bashrc ~/.bashrc
	ln -s ${folder_path}/.bash_logout ~/.bash_logout
	ln -s ${folder_path}/.editorconfig ~/.editorconfig
	ln -s ${folder_path}/.prettierrc.json ~/.prettierrc.json
	ln -s ${folder_path}/.gitconfig ~/.gitconfig
	ln -s ${folder_path}/.tmux.conf ~/.tmux.conf
}

case "$1" in
    packages)
        install_packages
        ;;
    symlink)
        symlink_dotfiles
        ;;
    vim.install)
        install_vim_from_source
        ;;
    vim.rc)
        setup_vimrc
        ;;
    all)
        install_packages
        install_vim_from_source
        setup_vimrc
        symlink_dotfiles
        ;;
    *)
        echo -e "\nUsage: $(basename "$0") {packages|symlink|vim.install|vim.rc|all}\n"
        exit 1
        ;;
esac

echo "Done."
