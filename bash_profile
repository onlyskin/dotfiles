[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
export PATH=/Users/sam/.rvm/gems/ruby-2.2.6/bin:/Users/sam/.rvm/gems/ruby-2.2.6@global/bin:/Users/sam/.rvm/rubies/ruby-2.2.6/bin:/usr/local/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Users/sam/.rvm/bin:/Applications/clojure:/Applications/VirtualBox.app/Contents/MacOS/

if [ -f ~/.git-completion.bash ]; then
      . ~/.git-completion.bash
fi

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
export PATH=/usr/local/bin:$PATH

alias ll="ls -lhAF"

# Python virtualenvwrapper configuration
export WORKON_HOME=~/Envs
source /usr/local/bin/virtualenvwrapper.sh
