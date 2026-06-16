# make grep more user friendly by highlighting matches
# and exclude grepping through .svn folders.
alias grep='grep --color=auto --exclude-dir=\.svn'
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias tmux="TERM=alacritty tmux -2 -u attach || TERM=alacritty tmux -2 -u new"
# Lock the screen: swaylock under Wayland (dwl), xscreensaver under X11 (dwm).
alias lock='if [ -n "$WAYLAND_DISPLAY" ]; then swaylock -f; else xscreensaver-command --lock; fi'
alias xlock='if [ -n "$WAYLAND_DISPLAY" ]; then swaylock -f; else xscreensaver-command --lock; fi'
