export DOTFILES="$HOME/.dotfiles"
export PATH="$DOTFILES/bin:$PATH"

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Completions
autoload -Uz compinit && compinit

# zoxide (smarter cd)
eval "$(zoxide init zsh)"

# fzf shell integration
eval "$(fzf --zsh)"

# Plugins
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Aliases
source $DOTFILES/zsh/aliases.zsh

# Machine-specific overrides
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

# Drift detection
source $DOTFILES/bin/dots-status

# Prompt — must be last
eval "$(starship init zsh)"
