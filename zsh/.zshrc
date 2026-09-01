export DOTFILES="$HOME/.dotfiles"
export PATH="$DOTFILES/bin:/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
export HOMEBREW_PREFIX="/opt/homebrew"
export HOMEBREW_CELLAR="/opt/homebrew/Cellar"
export HOMEBREW_REPOSITORY="/opt/homebrew"

# sops — macOS has no XDG-style default for this, so point it at the key
# restored by dots-secrets (see bin/dots-secrets)
export SOPS_AGE_KEY_FILE="$HOME/.config/sops/age/keys.txt"

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

# Added by Windsurf
export PATH="/Users/christophe/.codeium/windsurf/bin:$PATH"

# iTerm2 profile switching based on working directory
function chpwd() {
  case $PWD in
    ~/Code/leplein-apps*)
      echo -ne "\033]1337;SetProfile=Default\a"
      ;;
    ~/Code/leplein-emp-backbone*)
      echo -ne "\033]1337;SetProfile=leplein-backbone\a"
      ;;
    ~/Code/leplein-plans*)
      echo -ne "\033]1337;SetProfile=Default\a"
      ;;
    *)
      echo -ne "\033]1337;SetProfile=Default\a"
      ;;
  esac
}
