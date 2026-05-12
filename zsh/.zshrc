export DOTFILES="$HOME/.dotfiles"
export PATH="$DOTFILES/bin:/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
export HOMEBREW_PREFIX="/opt/homebrew"
export HOMEBREW_CELLAR="/opt/homebrew/Cellar"
export HOMEBREW_REPOSITORY="/opt/homebrew"

# Completions — cached, only rebuilt daily
autoload -Uz compinit
if [ "$(date +'%j')" != "$(stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)" ]; then
  compinit
else
  compinit -C
fi

# zoxide (smarter cd)
eval "$(zoxide init zsh)"

# fzf shell integration
eval "$(fzf --zsh)"

# Plugins
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Aliases
source $DOTFILES/zsh/aliases.zsh

# Drift detection (reads cache — non-blocking)
$DOTFILES/bin/dots-status

# Machine-specific overrides
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# direnv — must be before starship
eval "$(direnv hook zsh)"

# Prompt — must be last
eval "$(starship init zsh)"
