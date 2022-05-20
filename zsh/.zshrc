export PATH="$PATH:/home/zorua/.local/bin:$(yarn global bin)"
#cat ~/.cache/wal/sequences
#source ~/.cache/wal/colors-tty.sh
alias vi="nvim"
alias cd="pushd"
eval "$(starship init zsh)"
export VISUAL=vi
export EDITOR="$VISUAL"
autoload -Uz compinit && compinit
