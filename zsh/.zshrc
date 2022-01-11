cat ~/.cache/wal/sequences
source ~/.cache/wal/colors-tty.sh
alias vi="nvim"
eval "$(starship init zsh)"
[ -z "$SSH_AUTH_SOCK" ] && eval "$(ssh-agent -s)" 
