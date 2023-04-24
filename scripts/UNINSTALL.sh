#!/bin/bash

unlink_symlinks ()
{
    echo "------ Unlinking symlinks... ------"
    unlink ~/.bashrc
    unlink ~/.bash_profile
    unlink ~/.zshrc
    unlink ~/.editorconfig
    unlink ~/.prettierrc.json
    unlink ~/.tmux.conf
    echo "------ Symlinks successfully unlinked ------"
}

uninstall_vim ()
{
    echo "------ Uninstalling VIM... ------"
    cd ~/vim
    make uninstall

    echo "------ Removing Vimrc... ------"
    rm -rf ~/.vim
    echo "------ VIM uninstallation done ------"
}

main ()
{
    unlink_symlinks
    uninstall_vim
}

# More info here https://vimdoc.sourceforge.net/htmldoc/usr_90.html#90.5
