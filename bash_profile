[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

alias ll="ls -lhAFG"

# git autocompletion
if [ -f ~/.git-completion.bash ]; then
      . ~/.git-completion.bash
fi

# path modifications
export PATH=/usr/local/bin:$PATH
export PATH=$HOME/bin/:$PATH

export coding="/Users/Sam/Documents/Coding"
export bin="/Users/Sam/bin"
export tray=$coding"/elm-tray"
export todo=$HOME"/Dropbox/Apps/Simpletask"

# Python virtualenvwrapper configuration
export WORKON_HOME=~/Envs
# source /usr/local/bin/virtualenvwrapper.sh

# Base16 Shell (colorscheme)
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

# don't alwasy update homebrew
export HOMEBREW_AUTO_UPDATE_SECS=604800

# infinite shared history
export HISTCONTROL=ignoredups:erasedups  # no duplicate entries
export HISTSIZE=100000                   # big big history
export HISTFILESIZE=100000               # big big history
shopt -s histappend                      # append to history, don't overwrite it

# Save and reload the history after each command finishes
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
