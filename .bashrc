if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

source ~/.bash_git

export EDITOR=vim
PATH=$HOME/.local/bin:/usr/local/bin:/usr/local/lib:$HOME/go/bin:/usr/local/sbin:~/bin:$PATH
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

__git_complete_refs ()
{
    local branches
    branches=$(git for-each-ref --format='%(refname:short)' refs/heads/)
    COMPREPLY=( $(compgen -W "$branches" -- "$cur") )
}

complete -F __git_complete_refs git-checkout

PS1='${PYTHON_VIRTUALENV}\[\033[0;32m\]\[\033[0m\033[0;32m\]\u\[\033[0;36m\] @ \[\033[0;36m\]\h \w\[\033[0;32m\]$(__git_ps1)\n\[\033[0;32m\]└─\[\033[0m\033[0;32m\] \$\[\033[0m\033[0;32m\] ▶\[\033[0m\] '
. "$HOME/.cargo/env"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_OPS="--extended"

# Secrets (CLIENT_SECRET etc.) live in ~/.bash_secrets, outside the dotfiles repo.
[ -f ~/.bash_secrets ] && . ~/.bash_secrets

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/olsson/code/Release-Admiral/google-cloud-sdk/path.bash.inc' ]; then . '/home/olsson/code/Release-Admiral/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/olsson/code/Release-Admiral/google-cloud-sdk/completion.bash.inc' ]; then . '/home/olsson/code/Release-Admiral/google-cloud-sdk/completion.bash.inc'; fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# ssh-agent: start one and reuse it across shells. With `AddKeysToAgent yes`
# in ~/.ssh/config, your GitHub key loads on first use (one passphrase prompt
# per agent lifetime). `ssh-add -l` exits 2 when no agent is reachable.
SSH_ENV="$HOME/.ssh/agent.env"
[ -f "$SSH_ENV" ] && . "$SSH_ENV" >/dev/null 2>&1
ssh-add -l >/dev/null 2>&1
if [ $? -eq 2 ]; then
    (umask 077; ssh-agent -s > "$SSH_ENV")
    . "$SSH_ENV" >/dev/null
fi
