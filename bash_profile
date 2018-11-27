[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

if [ -f ~/.git-completion.bash ]; then
      . ~/.git-completion.bash
fi

export PATH=/usr/local/bin:$PATH
export PATH=$HOME/bin/:$PATH

alias ll="ls -lhAFG"

# Python virtualenvwrapper configuration
export WORKON_HOME=~/Envs
# source /usr/local/bin/virtualenvwrapper.sh

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"
