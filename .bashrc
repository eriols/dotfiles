# alias i egen fil
if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

source ~/.bash_git

export TERM=xterm-256color
export PATH=/usr/local/git/bin:/usr/local/sbin:/usr/local/go/bin:~/bin:$PATH
if [ -d /usr/local/texlive/2018basic/bin/x86_64-darwin/ ]; then
    export PATH=/usr/local/texlive/2018basic/bin/x86_64-darwin:$PATH
fi
export TMOUT=259200 # 72h
export GREP_COLOR='1;35;40'
export FZF_DEFAULT_COMMAND='git ls-files'

if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    LS_COLORS='di=100:fi=0:ln=31:pi=5:so=5:bd=5:cd=5:or=31:mi=0:ow=34;47:ex=35'
    export LS_COLORS
    alias grep="$(which grep) --color=always"
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

if [ -f ~/.inputrc ]; then
	bind -f ~/.inputrc
fi

function set_virtualenv () {
  if test -z "$VIRTUAL_ENV" ; then
      PYTHON_VIRTUALENV=""
  else
      PYTHON_VIRTUALENV="${BLUE}[`basename \"$VIRTUAL_ENV\"`]${COLOR_NONE} "
  fi
  }


PS1='${PYTHON_VIRTUALENV}\[\033[0;32m\]\[\033[0m\033[0;32m\]\u\[\033[0;36m\] @ \[\033[0;36m\]\h \w\[\033[0;32m\]$(__git_ps1)\n\[\033[0;32m\]└─\[\033[0m\033[0;32m\] \$\[\033[0m\033[0;32m\] ▶\[\033[0m\] '
