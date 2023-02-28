#!/bin/bash

echo "------ Unlinking symlinks... ------"
unlink ~/.bashrc
unlink ~/.zshrc
unlink ~/.editorconfig
unlink ~/.prettierrc.json
unlink ~/.tmux.conf
echo "------ Symlinks successfully unlinked ------"
echo "------ Uninstalling VIM... ------"
apt --purge autoremove vim

echo "------ Removing Vimrc... ------"

rm -rf ~/.vim
echo "------ VIM uninstallation done ------"
