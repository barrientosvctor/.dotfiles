#!/bin/bash

# Default folder name
folder_name=".dotfiles"
zshrc_file_path="~/.zshrc"

# It sets 'storage' folder in termux
termux-setup-storage

update_packages ()
{
    echo "------ Updating packages... -------"
    apt update
    apt upgrade
    echo "------ Packages updated and upgraded -------"
}

# It updates packages

install_packages ()
{
    echo "------ Installing GIT... -------"
    apt install git
    echo "------ GIT package successfully installed -------"
    echo "------ Installing NodeJS... -------"
    apt install nodejs
    echo "------ NODEJS package successfully installed ------"
    echo "------ Installing TMUX... -------"
    apt install tmux
    echo "------ TMUX package successfully installed -------"
    echo "------ Installing VIM... -------"
    apt install vim
    echo "------ VIM package successfully installed -------"
    echo "------ Installing SSH package... -------"
    apt install openssh
    echo "------ SSH package successfully installed -------"
}

setting_up_vimrc ()
{
    echo "------ Setting vimrc... ------"
    git clone https://github.com/barrientosvctor/vimrc.git ~/.vim
    cd ~/.vim
    git submodule init
    git submodule update
    echo "------ Vimrc set ------"
}

setting_up_symlinks ()
{
    cd ~/$folder_name
    echo "------ Setting symlinks... ------"
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

summary ()
{
    echo "Packages installed: git, nodejs, tmux, ssh, vim"
}

main ()
{
    update_packages
    install_packages

    setting_up_vimrc
    setting_up_symlinks

    summary
}
