#!/usr/bin/env bash
# get-started.sh — run this once, after a clean macOS install, to get back to work.
#
# BEFORE running this script:
#   1. Plug in the external drive holding your manual backup (see layout below).
#   2. Clone dotfiles (this script lives inside the repo, so this step can't be
#      automated — it's the one manual chicken-and-egg step):
#        git clone git@github.com:christophe-dufour/dotfiles.git ~/.dotfiles
#      If SSH isn't set up yet on the fresh machine, clone over HTTPS instead —
#      your SSH keys get restored from 1Password in step 3 below, at which
#      point you can switch the remote back: git remote set-url origin git@...
#   3. cd ~/.dotfiles && ./get-started.sh
#
# Expected external-drive layout (top-level folders, copied there by hand
# with `cp -R` before the wipe):
#   <drive>/Desktop/            <drive>/Documents/        <drive>/Downloads/
#   <drive>/Music/              <drive>/Code-extras/       (loose ~/Code files +
#                                                            non-git project folders)
#   <drive>/claude-memory/projects/   (was ~/.claude/projects)
#   <drive>/claude-memory/plans/      (was ~/.plans)
#
# This script pauses twice for GUI-only steps it cannot perform itself:
#   - signing into the 1Password app
#   - enabling 1Password's "Integrate with 1Password CLI" toggle

set -uo pipefail

DOTFILES="$HOME/.dotfiles"
EXTERNAL_DRIVE="${EXTERNAL_DRIVE:-/Volumes/Backup}"

BOLD='\033[1m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
RESET='\033[0m'

step()  { echo -e "\n${CYAN}▶ ${BOLD}$1${RESET}"; }
ok()    { echo -e "  ${GREEN}✓${RESET} $1"; }
info()  { echo -e "  $1"; }
pause() {
  echo -e "  ${YELLOW}⚠${RESET}  $1"
  read -p "    Press Enter once done... " _
}

step "1/7 — Dotfiles bootstrap (Xcode CLI tools, Homebrew, packages, macOS defaults, Claude Code)"
zsh "$DOTFILES/bootstrap.sh"

step "2/7 — 1Password"
pause "Open the 1Password app, sign into your account, then go to
     Settings -> Developer -> enable 'Integrate with 1Password CLI'."

step "3/7 — Restore secrets from 1Password (SSH keys, sops age key, rclone/AWS config, env files)"
bash "$DOTFILES/bin/dots-secrets" pull

step "4/7 — GitHub CLI auth"
gh auth login

step "5/7 — pCloud mount"
mkdir -p "$HOME/pcloud-mount"
launchctl load "$HOME/Library/LaunchAgents/com.rclone.pcloud.plist" 2>/dev/null
sleep 2
if ls "$HOME/pcloud-mount" >/dev/null 2>&1; then
  ok "pCloud mounted"
else
  info "pCloud mount not up yet — check /tmp/rclone-pcloud.err (needs rclone.conf from step 3)"
fi

step "6/7 — Restore personal files from external drive ($EXTERNAL_DRIVE)"
if [ -d "$EXTERNAL_DRIVE" ]; then
  for dir in Desktop Documents Downloads Music; do
    if [ -d "$EXTERNAL_DRIVE/$dir" ]; then
      cp -Rn "$EXTERNAL_DRIVE/$dir/." "$HOME/$dir/" && ok "$dir restored"
    else
      info "skipped: $EXTERNAL_DRIVE/$dir not found"
    fi
  done
  if [ -d "$EXTERNAL_DRIVE/Code-extras" ]; then
    cp -Rn "$EXTERNAL_DRIVE/Code-extras/." "$HOME/Code/" && ok "Code-extras restored"
  fi
  if [ -d "$EXTERNAL_DRIVE/claude-memory/projects" ]; then
    mkdir -p "$HOME/.claude/projects"
    cp -Rn "$EXTERNAL_DRIVE/claude-memory/projects/." "$HOME/.claude/projects/" && ok "Claude Code memory restored"
  fi
  if [ -d "$EXTERNAL_DRIVE/claude-memory/plans" ]; then
    mkdir -p "$HOME/.plans"
    cp -Rn "$EXTERNAL_DRIVE/claude-memory/plans/." "$HOME/.plans/" && ok "Claude Code plans restored"
  fi
else
  info "$EXTERNAL_DRIVE not found — plug in the drive and re-run, or:"
  info "  EXTERNAL_DRIVE=/Volumes/<name> ./get-started.sh"
fi

step "7/7 — Verify"
bash "$DOTFILES/bin/dots-status"
bash "$DOTFILES/bin/dots-secrets" status

echo -e "\n${GREEN}${BOLD}Done.${RESET} Open a new terminal to pick up shell changes."
