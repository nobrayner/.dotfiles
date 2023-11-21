# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
# SHARE_HISTORY=true
setopt appendhistory

bindkey -s ^f "tmux-sessionizer\n"

# Aliases
alias vi="nvim"
alias pod="podman"
alias podcom="podman-compose"
alias docker="podman"
# Better dir navigation
alias cd="pushd"
alias pd="popd"

# Use nvim for editor
export VISUAL=nvim
export EDITOR="$VISUAL"
autoload -Uz compinit && compinit

export LOCAL_BIN="$HOME/.local/bin"
export BIN_YARN="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin"
export PNPM_HOME="/home/zorua/.local/share/pnpm"

export PATH="$PNPM_HOME:$BIN_YARN:$LOCAL_BIN:$PATH"

# asdf
. $HOME/.sources/asdf/asdf.sh
fpath=(${ASDF_DIR}/completions $fpath)
autoload -Uz compinit && compinit

# This should always be last
eval "$(starship init zsh)"

# pnpm
export PNPM_HOME="/home/zorua/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/zorua/.local/bin/google-cloud-sdk/path.zsh.inc' ]; then . '/home/zorua/.local/bin/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/zorua/.local/bin/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/zorua/.local/bin/google-cloud-sdk/completion.zsh.inc'; fi

# bun completions
[ -s "/home/zorua/.bun/_bun" ] && source "/home/zorua/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
