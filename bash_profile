[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

if [ -f ~/.git-completion.bash ]; then
      . ~/.git-completion.bash
fi

export PATH=$HOME/bin/:$PATH
export PATH=/usr/local/bin:$PATH

alias ll="ls -lhAFG"

# Python virtualenvwrapper configuration
export WORKON_HOME=~/Envs
# source /usr/local/bin/virtualenvwrapper.sh
