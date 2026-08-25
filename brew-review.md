# Brewfile Review — 2026-08-24

Every line currently in `Brewfile`, with a real (checked, not guessed) status: is it on `$PATH`, is it wired into `.zshrc`, does its app exist in `/Applications`. My suggestion is a starting point, not a verdict — fill in **Your call** and I'll apply it to the Brewfile.

## Formulae

| Package | Description | Keep? | Comment | Your call |
|---|---|---|---|---|
| `age` | Simple, modern, secure file encryption | Keep | Not currently installed despite being in Brewfile — `SOPS_AGE_KEY_FILE` is exported in `.zshrc.local`, so this is expected to exist. Run `brew bundle install` to actually get it. | keep |
| `awscli` | Official AWS CLI | Keep | `aws` on PATH, AWS config already tracked as a 1Password secret — in real use. | keep|
| `bat` | `cat` clone with syntax highlighting | Keep | Powers your `cat` alias, on PATH. | keep|
| `buildkit` | Dockerfile-agnostic image builder toolkit | Drop candidate | Installed but no standalone CLI you'd invoke directly (`buildctl`) — Docker/OrbStack already ship their own buildkit internally. | drop |
| `cocoapods` | Dependency manager for Cocoa/iOS projects | Your call | `pod` on PATH and installed — only useful if you're building iOS/React Native apps. | keep |
| `deno` | Secure JS/TS runtime | Your call | On PATH, installed — confirm you still have a project using it vs. Node/Bun. | drop |
| `direnv` | Loads/unloads env vars per directory | Keep | Wired into `.zshrc` (`eval "$(direnv hook zsh)"`), actively used. | keep |
| `dive` | Explore layers of a Docker image | Your call | On PATH — niche, useful only when actively debugging image bloat. | drop |
| `docker` | Docker CLI | Keep | On PATH, core to your workflow (compose aliases exist). | keep |
| `doctl` | DigitalOcean CLI | Your call | On PATH — confirm you still host on DigitalOcean. | keep |
| `duckdb` | Embeddable SQL OLAP database | Your call | On PATH — niche, keep if you do local data analysis. | drop |
| `eza` | Modern `ls` replacement | Keep | Powers `ls`/`ll`/`la`/`lt` aliases, actively used every session. | keep |
| `exiftool` | Read/write EXIF metadata | Your call | On PATH — plausible given tax docs/ID scans mentioned in the wipe-prep audit, but confirm actual use. | drop |
| `ffmpeg` | Audio/video codec swiss-army knife | Keep | On PATH, clearly used — also explains the ~19 orphaned codec-lib leaves seen in `dots status` drift. | keep |
| `fnm` | Fast Node.js version manager | Drop candidate | Installed but **not activated** in your shell (no `fnm env` call anywhere) — `node` on PATH resolves to a plain Homebrew install, not fnm-managed. Dead weight unless you wire it in. | drop |
| `fzf` | Fuzzy finder | Keep | Wired into `.zshrc` (`eval "$(fzf --zsh)"`), actively used. | keep |
| `gh` | GitHub CLI | Keep | On PATH, used in `get-started.sh` and your `g`/`gp` aliases — core to your git workflow. | keep |
| `git-crypt` | Transparent git file encryption | Your call | On PATH, installed — confirm any repo actually uses it (check for `.gitattributes` referencing git-crypt). | keep |
| `htop` | Interactive process viewer | Keep | Common utility, on PATH. | keep |
| `koyeb/tap/koyeb` | Koyeb CLI | Your call | On PATH — confirm you still deploy to Koyeb. | drop |
| `mise` | Polyglot runtime version manager | Drop candidate | Installed but **not activated** (`mise doctor` reports `activated: no`, `shims_on_path: no`) — same overlap as `fnm`; neither is actually managing your Node version right now. Pick one and wire it in, or drop both. | keep |
| `opencode` | AI coding agent for the terminal | Your call | On PATH — a second AI coding agent alongside Devin + Claude Code. Worth deciding if you still reach for it. | keep |
| `openjdk` | Java development kit | Your call | `java` on PATH, installed — confirm what actually needs Java on this machine (cocoapods doesn't require it). | drop|
| `pipx` | Run Python CLI tools in isolated envs | Keep | On PATH, generically useful. | drop |
| `postgresql@14` | Postgres 14 | Your call | Installed (keg-only) — version-pinned; confirm your projects still target 14 specifically. | drop |
| `python@3.13` | Python 3.13 | Your call | Installed alongside 3.14 below — confirm both are actually needed or if this is leftover from a prior default. | drop |
| `python@3.14` | Python 3.14 | Your call | See above — two Python majors installed simultaneously. | drop |
| `rclone` | Rsync for cloud storage | Keep | On PATH, powers the pCloud mount LaunchAgent — core infra. | keep |
| `redis` | In-memory key-value store | Your call | Installed — keep if you run Redis locally for dev, drop if project Redis is always containerized. | drop |
| `schpet/tap/linear` | CLI for linear.app | Keep | On PATH, matches your Linear-based issue workflow. | keep |
| `sops` | Encrypted file editor | Keep | Same as `age` — not currently installed despite `.zshrc.local` expecting it (`SOPS_AGE_KEY_FILE`). Needs `brew bundle install`. | keep |
| `starship` | Cross-shell prompt | Keep | Wired as your prompt (`eval "$(starship init zsh)"`), essential. | keep |
| `stow` | Symlink farm manager | Keep | Required for the whole dotfiles system (`dots sync`, `bootstrap.sh`) to function at all. | keep |
| `terminal-notifier` | macOS notifications from CLI | Your call | On PATH — niche, useful if any script/alias sends notifications. | keep |
| `tree` | Directory tree viewer | Keep | Common utility, on PATH. | keep |
| `unar` | CLI archive extractor | Your call | On PATH — niche, keep if you regularly extract `.rar`/uncommon archives. | keep |
| `wrangler` | *Refactoring tool for Erlang (emacs/Eclipse integration)* | **Drop** | Almost certainly installed by mistake — this is **not** Cloudflare's Wrangler CLI. It's disabled upstream since 2025-07-01 and provides no binary (`wrangler` is not on PATH). If you want Cloudflare Wrangler, that's `npm install -g wrangler`, a different tool entirely. | drop |
| `yt-dlp` | Audio/video downloader | Keep | On PATH, common utility. | keep |
| `zoxide` | Smarter `cd` | Keep | Wired into `.zshrc` (`eval "$(zoxide init zsh)"`), actively used. | keep |
| `zsh-autosuggestions` | Fish-like shell autosuggestions | Keep | Confirmed sourced in `.zshrc` and working. | keep |
| `zsh-syntax-highlighting` | Fish-like shell syntax highlighting | Keep | Confirmed sourced in `.zshrc` and working. | keep |

## Casks

| Package | Description | Keep? | Comment | Your call |
|---|---|---|---|---|
| `1password` | Password manager | Keep | Core to your secrets workflow (`dots secrets`). | keep |
| `1password-cli` | 1Password CLI (`op`) | Keep | Required by `dots secrets push/pull/status`. | keep |
| `brave-browser` | Privacy-focused browser | Your call | App present — confirm it's actually your daily browser vs. Chrome. | keep|
| `bruno` | API testing IDE | Your call | App present — keep if still your Postman alternative. | keep|
| `claude` | Claude desktop app | Keep | App present, actively used. | keep |
| `cloudflare-warp` | Cloudflare's network client | Your call | App present — confirm you still use WARP (not the same as the "warp" terminal app that showed up as orphaned drift earlier). | keep |
| `devin-desktop` | Devin — agentic IDE | **Keep** | Your primary IDE, running right now — this was the one missing from Brewfile before today's fix. | keep|
| `figma` | Design tool | Your call | App present — confirm still in use. | keep|
| `google-chrome` | Browser | Your call | App present — see `brave-browser` comment; you may only need one primary browser tracked as "main." | keep|
| `iterm2` | Terminal emulator | Keep | Actively used (preferences touched today), now backed up as a snapshot too. | keep|
| `linear` | Linear desktop app | Keep | Matches your Linear-based project/issue tracking. | keep|
| `macfuse` | FUSE filesystem support | Keep | Kernel extension confirmed **actively loaded right now** (`io.macfuse.filesystems.macfuse.25`) — required for the rclone pCloud mount. Note: kext approval is a manual System Settings step after a fresh install. | keep|
| `ngrok` | Local tunnel / reverse proxy | Keep | Binary confirmed installed and present on PATH (no `.app`, this is expected — ngrok is CLI-only). | drop |
| `notion` | Notes/wiki app | Your call | App present — confirm still in use. | keep|
| `onyx` | System maintenance utility | **Drop** | Homebrew still has the receipt, but `OnyX.app` is genuinely gone from `/Applications` — matches the same orphaned-cask pattern as Arc/Cursor/etc. found earlier. | drop|
| `orbstack` | Docker Desktop replacement | Keep | App present, core container runtime. | keep|
| `slack` | Team chat | Keep | App present, actively used. | keep|
| `swiftbar` | Menu bar customization | Your call | App present — confirm still in use (easy to forget about menu bar scripts). | drop|
| `vlc` | Media player | Your call | App present — keep if still your go-to player. | keep|
| `windsurf` | Windsurf IDE | **Drop candidate** | App is **not installed** (only stale cache left) — this is the one that looked like your daily driver before we found Devin is actually primary. Safe to drop unless you plan to reinstall it. | drop |

---

Once you've filled in **Your call**, tell me which rows to drop and I'll remove them from `Brewfile` (and, where relevant, actually uninstall the formula/cask so `brew leaves`/`brew list --cask` stays honest).
