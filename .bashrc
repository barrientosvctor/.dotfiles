# If not running interactively, don't do anything
[[ $- == *i* ]] || return

# enable bash completion in interactive shells
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

echo -e "✨ Let's code, ${USER} ✨"
echo " "

# loads custom prompt
source ~/.bash_profile

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# fzf config file for vim
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

export BAT_THEME="ansi"
