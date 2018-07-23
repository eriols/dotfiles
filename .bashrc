# alias i egen fil
if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

#PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH.
export TERM=tmux-256color
export PATH=/usr/local/git/bin:/usr/local/sbin:/usr/local/go/bin:$PATH
export TMOUT=259200 # 72h
export GREP_COLOR='1;35;40'
alias ep='export PYTHONPATH=.'
alias sov='pmset sleepnow'
alias git='/usr/local/bin/git'

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
