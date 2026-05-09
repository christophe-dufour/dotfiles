# ── Navigation ───────────────────────────────────────────────────────────────
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias -- -="cd -"

# ── ls → eza ─────────────────────────────────────────────────────────────────
alias ls="eza --icons --group-directories-first"
alias ll="eza -lah --icons --group-directories-first --git"
alias la="eza -a --icons"
alias lt="eza --tree --icons --level=2"
alias lta="eza --tree --icons --level=3 -a --ignore-glob='.git|node_modules'"

# ── cat → bat ────────────────────────────────────────────────────────────────
alias cat="bat --paging=never"

# ── Git ──────────────────────────────────────────────────────────────────────
alias g="git"
alias gs="git status -sb"
alias ga="git add"
alias gaa="git add --all"
alias gc="git commit -m"
alias gco="git checkout"
alias gcb="git checkout -b"
alias gp="git push"
alias gpl="git pull"
alias gf="git fetch --prune"
alias glog="git log --oneline --graph --decorate --all"
alias gd="git diff"
alias gds="git diff --staged"
alias gundo="git reset HEAD~1 --mixed"

# ── Docker ───────────────────────────────────────────────────────────────────
alias d="docker"
alias dc="docker compose"
alias dcu="docker compose up -d"
alias dcd="docker compose down"
alias dcl="docker compose logs -f"
alias dps="docker ps --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'"
alias dclean="docker system prune -af --volumes"

# ── Node / JS ─────────────────────────────────────────────────────────────────
alias ni="npm install"
alias nr="npm run"
alias pn="pnpm"

# ── Network ──────────────────────────────────────────────────────────────────
alias myip="curl -s ifconfig.me"
alias localip="ipconfig getifaddr en0"
alias flush="dscacheutil -flushcache && killall -HUP mDNSResponder"
alias ports="lsof -i -P -n | grep LISTEN"

# ── System ───────────────────────────────────────────────────────────────────
alias reloadzsh="source $HOME/.zshrc"
alias brewup="brew update && brew upgrade && brew cleanup"
alias cleanup="find . -name '.DS_Store' -delete"

# ── Editor ───────────────────────────────────────────────────────────────────
alias code="windsurf"
