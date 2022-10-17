# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

bindkey -s ^f "tmux-sessionizer\n"

# Aliases
alias vi="nvim"
alias pod="podman"
alias podcom="podman-compose"
# Better dir navigation
alias cd="pushd"
alias pd="popd"

# Use nvim for editor
export VISUAL=nvim
export EDITOR="$VISUAL"
autoload -Uz compinit && compinit

export LOCAL_BIN="$HOME/.local/bin"
export YARN_BIN="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin"
export PNPM_HOME="/home/zorua/.local/share/pnpm"

export PATH="$PNPM_HOME:$YARN_BIN:$LOCAL_BIN:$PATH"

# asdf
. $HOME/.sources/asdf/asdf.sh
fpath=(${ASDF_DIR}/completions $fpath)
autoload -Uz compinit && compinit

# This should always be last
eval "$(starship init zsh)"
