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
alias lg="lazygit"
alias airplay="uxplay -pin 5151 -p -n NixWindow -nh"

# Better dir navigation
alias cd="pushd"
alias pd="popd"

bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

# Use nvim for editor
export VISUAL=nvim
export EDITOR="$VISUAL"
autoload -Uz compinit && compinit

export LOCAL_BIN="$HOME/.local/bin"
export BIN_YARN="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin"
export PNPM_HOME="/home/zorua/.local/share/pnpm"

export PATH="$PNPM_HOME:$BIN_YARN:$LOCAL_BIN:$ANDROID_STUDIO:$PATH"

# This should always be last
eval "$(starship init zsh)"

# pnpm
export PNPM_HOME="/home/zorua/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

fpath+=($(nix eval --raw nixpkgs#git-ps-rs)/share/zsh/site-functions)
autoload -U compinit
compinit

# bun completions
[ -s "/home/zorua/.bun/_bun" ] && source "/home/zorua/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
