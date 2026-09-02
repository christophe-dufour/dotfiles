#!/bin/bash
# Claude Code statusLine hook: writes context-usage state to a cache file
# for the iTerm2 status bar widget to poll, and returns a line for Claude's
# own in-app status line.
set -euo pipefail

cache_dir="$HOME/.cache/term-statusbar"
cache_file="$cache_dir/claude.json"
mkdir -p "$cache_dir"

input="$(cat)"

echo "$input" | jq -c '{
  used_percentage: .context_window.used_percentage,
  model: (.model.display_name // "Claude"),
  updated_at: now
}' > "$cache_file.tmp" && mv "$cache_file.tmp" "$cache_file"

pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
model=$(echo "$input" | jq -r '.model.display_name // "Claude"')

if [ -n "$pct" ]; then
  echo "$model · ctx ${pct}%"
else
  echo "$model"
fi
