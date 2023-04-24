#!/bin/bash

# Default folder name
folder_name=".dotfiles"
zshrc_file_path="~/.zshrc"

update-packages ()
{
    echo "------ Updating & upgrading packages... -------"
    sudo apt update && sudo apt upgrade
    echo "------ Packages updated and upgraded -------"
}

install-packages ()
{
    echo "------ Installing GIT package... ------"
    sudo apt install git
    echo "------ GIT package successfully installed ------"
    echo "------ Installing TMUX package... ------"
    sudo apt install tmux
    echo "------ TMUX package successfully installed ------"
    echo "------ Installing Make package... ------"
    sudo apt install make
    echo "------ Make package successfully installed ------"
    echo "------ Installing Curl package... ------"
    sudo apt install curl
    echo "------ Curl package successfully installed ------"
}

packages-setup ()
{
    update-packages
    install-packages
}

build-vim ()
{
    echo "------ Installing dependencies to build VIM... ------"
    sudo apt-get install make libncurses5-dev libncursesw5-dev build-essential python3
    echo "------ VIM dependencies successfully installed ------"
}

install-vim ()
{
    echo "------ Installing VIM...  ------"
    git clone https://github.com/barrientosvctor/vim.git ~/vim
    cd ~/vim/src
    ./configure --with-features=huge \
        --enable-multibyte \
        --enable-python3interp=yes \
        --with-python3-config-dir=$(python3-config --configdir) \
        --enable-gui=auto \
        --enable-cscope \
        --prefix=/usr/local \
        --enable-fail-if-missing
    make && sudo make install
    echo "------ VIM successfully installed ------"
}

setup-vim-dotfiles ()
{
    echo "------ Setting up VIM dotfiles...  ------"
    git clone git@github.com:barrientosvctor/vimrc.git ~/.vim
    cd ~/.vim
    git submodule init
    git submodule update
    echo "------ VIM dotfiles done!  ------"
}

vim-setup ()
{
    build-vim
    install-vim
    setup-vim-dotfiles
}

symlink-setup ()
{
    cd ~/$folder_name
    echo "------ Setting up symlinks... ------"
    ln -s ~/$folder_name/.bashrc ~/.bashrc
    ln -s ~/$folder_name/.bash_profile ~/.bash_profile
    ln -s ~/$folder_name/.editorconfig ~/.editorconfig
    ln -s ~/$folder_name/.prettierrc.json ~/.prettierrc.json
    ln -s ~/$folder_name/.tmux.conf ~/.tmux.conf
    echo "------ All symlinks successfully set ------"
}

zsh-install ()
{
    echo "------ Installing Oh My Zsh...  ------"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    if [ -f $zshrc_file_path ]; then
        rm -rf $zshrc_file_path
        ln -s ~/$folder_name/.zshrc $zshrc_file_path
    else
        ln -s ~/$folder_name/.zshrc $zshrc_file_path
    fi
}

resume ()
{
    echo "Packages installed: git, tmux, vim, make, curl."
    echo "Oh My Zsh installed."
}

main ()
{
    packages-setup
    vim-setup
    symlink-setup
    zsh-install
    resume
}

main
