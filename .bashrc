if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

source ~/.bash_git

export TERM=alacritty
PATH=/usr/local/bin:/usr/local/sbin:~/bin:$PATH
export TMOUT=259200 # 72h
export FZF_DEFAULT_COMMAND='git ls-files'
# java
JAVA_HOME=$(dirname "$(which javac)")
export JAVA_HOME
export PATH=$PATH:$JAVA_HOME/bin
CLASSPATH=.:$JAVA_HOME/jre/lib:$JAVA_HOME/lib:$JAVA_HOME/lib/tools.jar
export CLASSPATH
# no limit on history
export HISTFILESIZE=
export HISTSIZE=
# share history across sessions
shopt -s histappend


if [ -x /usr/bin/dircolors ]; then
    eval "$(dircolors -b)"
    alias ls='ls --color=always'
    LS_COLORS='di=100:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ow=34;47:ex=35'
    export LS_COLORS
    # alias grep="$(which grep) --color=always"
    alias fgrep='fgrep --color=always'
    alias egrep='egrep --color=always'
fi

set_virtualenv () {
  if test -z "$VIRTUAL_ENV" ; then
      PYTHON_VIRTUALENV=""
  else
      PYTHON_VIRTUALENV="${BLUE}[$(basename \"$VIRTUAL_ENV\")]${COLOR_NONE} "
  fi
}

PS1='${PYTHON_VIRTUALENV}\[\033[0;32m\]\[\033[0m\033[0;32m\]\u\[\033[0;36m\] @ \[\033[0;36m\]\h \w\[\033[0;32m\]$(__git_ps1)\n\[\033[0;32m\]└─\[\033[0m\033[0;32m\] \$\[\033[0m\033[0;32m\] ▶\[\033[0m\] '
. "$HOME/.cargo/env"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_OPS="--extended"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
