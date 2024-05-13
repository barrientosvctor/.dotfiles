#!/bin/bash

uninstall_vim() {

}

unlink_symlink() {}

case "$1" in
    vim.uninstall)
        uninstall_vim
        ;;
    unlink)
        unlink_symlink
        ;;
    *)
        echo -e "\nUsage: $(basename "$0") {vim.uninstall|unlink}\n"
        exit 1
        ;;
esac

echo "Done."
