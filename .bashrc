# alias i egen fil
if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

#PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH.
export TERM=tmux-256color
export PATH=/usr/local/git/bin:/usr/local/sbin:/usr/local/go/bin:~/bin:$PATH
if [ -d /usr/local/texlive/2018basic/bin/x86_64-darwin/ ]; then
    export PATH=/usr/local/texlive/2018basic/bin/x86_64-darwin:$PATH
fi
export TMOUT=259200 # 72h
export GREP_COLOR='1;35;40'
export FZF_DEFAULT_COMMAND='git ls-files'
export PLAN9="/Users/erikolsson/9/plan9port"
export PATH="$PATH:$PLAN9/bin"
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

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
