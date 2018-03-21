# alias i egen fil
if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

#PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH.
export TERM=tmux-256color
export PATH=/usr/local/git/bin:/usr/local/sbin:$PATH
export TMOUT=259200 # 72h
export GREP_COLOR='1;35;40'
alias ep='export PYTHONPATH=.'

if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    alias grep="$(which grep) --color=always"
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

bind -f ~/code/dotfiles/.inputrc
