#!/bin/bash

echo "------ Unlinking symlinks... ------"
unlink ~/.bashrc
unlink ~/.bash_profile
unlink ~/.zshrc
unlink ~/.editorconfig
unlink ~/.prettierrc.json
unlink ~/.tmux.conf
echo "------ Symlinks successfully unlinked ------"
echo "------ Uninstalling VIM... ------"
cd ~/vim
make distclean
make uninstall
rm -rf ~/vim
rm -r /usr/local/bin/rvim
rm -r /usr/local/bin/vim
rm -r /usr/local/bin/vimdiff
rm -r /usr/local/bin/vimtutor

echo "------ Removing Vimrc... ------"
rm -rf ~/.vim
echo "------ VIM uninstallation done ------"

# More info here https://vimdoc.sourceforge.net/htmldoc/usr_90.html#90.5
