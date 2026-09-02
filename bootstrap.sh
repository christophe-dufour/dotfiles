#!/bin/zsh
set -e

echo "Starting dotfiles bootstrap..."

# ── Xcode CLI tools ───────────────────────────────────────────────────────────
if ! xcode-select -p &>/dev/null; then
  echo "Installing Xcode CLI tools..."
  xcode-select --install
  echo "Re-run this script after Xcode CLI tools finish installing."
  exit 0
fi

# ── Homebrew ──────────────────────────────────────────────────────────────────
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://brew.sh/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# ── Stow ─────────────────────────────────────────────────────────────────────
brew install stow

# ── Clone dotfiles ────────────────────────────────────────────────────────────
if [ ! -d "$HOME/.dotfiles" ]; then
  git clone git@github.com:christophe-dufour/dotfiles.git ~/.dotfiles
fi

cd ~/.dotfiles

# ── Stow packages ─────────────────────────────────────────────────────────────
for pkg in zsh git ssh starship claude opencode launchagents devin vscode; do
  stow "$pkg" && echo "✓ $pkg"
done

# ── Install packages ──────────────────────────────────────────────────────────
echo "Installing Homebrew packages..."
brew bundle install --file=~/.dotfiles/Brewfile

# ── Token-efficiency layer (rtk + headroom CLI) ────────────────────────────────
# rtk init -g is idempotent — safe to re-run, regenerates the hook config.
echo "Wiring rtk into Claude Code and OpenCode..."
rtk init -g
rtk init -g --opencode

# headroom's Homebrew cask only ships the GUI app; the CLI (doctor, proxy,
# mcp install) is a separate `uv tool install`.
echo "Installing headroom CLI..."
uv tool install "headroom-ai[all]"

# ── macOS preferences ─────────────────────────────────────────────────────────
echo "Applying macOS defaults..."
zsh ~/.dotfiles/macos.sh

# ── Claude Code ───────────────────────────────────────────────────────────────
echo "Installing Claude Code..."
curl -fsSL https://claude.ai/install.sh | bash

echo ""
echo "Bootstrap complete. Open a new terminal to apply shell changes."
