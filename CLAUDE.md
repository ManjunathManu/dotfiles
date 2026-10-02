# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

Personal dotfiles for macOS (branch `mac`; the repo is **public** on GitHub). It manages the kitty terminal, zsh (and bash), Neovim, git, and the installation of every tool via a Brewfile and mise.

## Architecture

### Symlink-Based Configuration System

`install/link.sh` links every `*.symlink` file or directory (up to 3 levels deep):

- Default: `dir/name.symlink` → `~/.name` (e.g. `bash/zshrc.symlink` → `~/.zshrc`, `git/git-hooks.symlink/` → `~/.git-hooks`)
- Directories listed in `link.sh` go to `~/.config/<dir>/<name>` instead: starship, lazygit, nvim, kitty, bat, mise, atuin (e.g. `kitty/kitty.conf.symlink` → `~/.config/kitty/kitty.conf`). Add a new tool's directory to that list.
- A `.symlink` *directory* is linked as a whole (e.g. `kitty/sessions.symlink/`).

### Installation System

`install.sh` runs, in order:

1. **install/stack.sh** - Homebrew, then mise + Node/Python (`mise/config.toml.symlink`), then everything in `Brewfile` (`brew bundle`), then pre-commit (via `uv tool`). New tools go in the Brewfile, not as separate install steps.
2. **install/link.sh** - Creates the symlinks above
3. **install/git.sh** - Writes name/email (+ optional personal-repo email) to `~/.gitconfig.local`
4. **install/fzf_setup.sh**, **install/zsh_plugins_setup.sh**

### Directory Structure

- `kitty/` - kitty config, custom tab bar (`tab_bar.py.symlink`), auto dark/light themes, sessions, quick-access terminal
- `bash/` - zsh (`zshrc`, `zprofile`, `zsh_aliases`, `enhanced_zsh`) and bash equivalents; `zsh_cache.zsh` (startup cache helper, sourced by path, not linked)
- `nvim/` - Neovim 0.12 config (lazy.nvim, native LSP)
- `vim/` - plain vim config (vim is still `$EDITOR` and git's editor)
- `git/` - `gitconfig.symlink` (shared settings + delta themes), `git-hooks.symlink/` (global hook dispatcher)
- `mise/`, `atuin/`, `bat/`, `starship/`, `lazygit/`, `fzf/` - tool configs
- `install/` - installation scripts; `bin/` - custom scripts (e.g. `team-request`)
- `config/` - machine-local settings: `*.local.sh` is gitignored; `aws.example.sh` is the template for `aws.local.sh` (TEAM settings)
- `utils.sh` - shared bash helpers for install scripts
- `Brewfile` - every formula, cask, global npm package and VS Code extension (`brew bundle check --file=Brewfile`)

## Key Commands

```bash
./install.sh                         # full setup on a new Mac
source install/link.sh               # (re)create symlinks only
brew bundle check --file=Brewfile    # anything missing?
pre-commit run --all-files           # gitleaks + shellcheck + basic checks
```

Testing changes:

```bash
exec zsh                             # reload zsh (or open a new kitty tab)
# kitty: Ctrl+Cmd+,  reloads kitty.conf; tab_bar.py changes need Cmd+Q and reopen
zsh -n file; bash -n file            # syntax only; also dry-run scripts, it misses logic bugs
```

## Configuration Details

### Shell (zsh)

- Startup ~0.27s. Slow `tool init`/completion output is cached by `_cached_source` (`bash/zsh_cache.zsh`, cache in `~/.cache/zsh`, keyed on the tool's real path).
- **Never cache `mise activate`**: its output embeds the current `$PATH`. brew's `shellenv` is safe to cache (uses `${PATH+:$PATH}`).
- `bindkey -v` is set explicitly before any other `bindkey`; zsh only auto-picks vi mode if `$EDITOR` contains "vi" at that moment.
- atuin is initialized last (after `~/.enhanced_zsh`, which loads fzf's Ctrl+R) with `--disable-up-arrow --disable-ai`.
- A precmd hook sends kitty user vars (`aws_sso`, `aws_expires`) for the tab bar; `sso <name>` exports `AWS_SSO_NAME`.

### kitty

- No tmux-style prefix: `cmd+…` for splits/tabs/hints/sessions, kitty defaults otherwise.
- Kitty started from the Dock has `PATH=/usr/bin:/bin:/usr/sbin:/sbin`: use absolute paths in kitty.conf (e.g. `scrollback_pager /opt/homebrew/bin/nvim …`) and in `tab_bar.py` subprocesses.
- Theme overrides go in `dark-theme.auto.conf` / `light-theme.auto.conf` (they load after kitty.conf).
- `tab_bar.py` must never block: no network calls, slow work on `add_timer`.

### git

- `~/.gitconfig` is a symlink into this public repo: personal values (name, email) go in `~/.gitconfig.local` via `git config --file`, **never** `git config --global`.
- Repos under `~/workspace/source-code/personal/` use the personal email (`includeIf` → `~/.gitconfig.personal`).
- Global `core.hooksPath = ~/.git-hooks`: `_dispatch` runs gitleaks on pre-commit, then the repo's own `.git/hooks/<name>`. Repos with their own `core.hooksPath` (husky `.husky`) bypass it. `pre-commit install` needs `GIT_CONFIG_GLOBAL=/dev/null` (the zsh `pre-commit` wrapper does this).

### Node / Python

- mise only (nvm and pyenv are gone). Defaults in `mise/config.toml.symlink`; projects switch via `mise.toml`, `.nvmrc` or `.python-version`.
- Homebrew's `python@3.14` can't load `pyexpat` on macOS 26.0, so pre-commit is installed with `uv tool` on mise's Python.
- `mise/lightmetrics.mise.toml` is linked to `~/workspace/source-code/lightmetrics/mise.toml` (mise reads parent folders, so it covers every work repo). Its enter hook prints an `sso` reminder via `_aws_sso_hint`; it never logs in by itself.
- `mise-env` (zsh) loads a repo's `.env` via an untracked `mise.local.toml` (listed in `.git/info/exclude`); `mise-env off` removes it.
- `grep` is aliased to `rg` in zsh: use `command grep` in shell functions.
- Starship's config is at `~/.config/starship/starship.toml` (link.sh puts it there), so `STARSHIP_CONFIG` must be exported before `starship init` in zshrc/bashrc; without it Starship silently uses its defaults. Prompt colors are ANSI names so they follow kitty's dark/light theme.

### Upkeep

- `bin/upkeep` (zsh alias `upkeep`) reports brew / mise / pre-commit-hook updates, never upgrades. launchd runs it with `--notify` on the 1st of each month at 10:00 (`launchd/dev.dotfiles.upkeep.plist` is a template: link.sh fills in paths, copies it to `~/Library/LaunchAgents` and reloads it). Report: `~/.cache/upkeep/report.txt`.

## Working with This Repository

- Install scripts use `utils.sh`: `h1`, `h2`, `info`, `success`, `error`, `typeExists`, `runCommand`. `runCommand` runs inside `$(…)` (output hidden unless it fails), so use it for quick non-interactive steps; run interactive or long commands directly.
- Shell scripts must pass shellcheck at warning level (the pre-commit hook enforces it; zsh files are excluded). macOS `/bin/bash` is 3.2: no `mapfile`, no associative arrays.
- Before printing anything from history, configs or logs, check for secrets and print counts, not values.

## Quick Questions section

- For vim/neovim configuration questions, start by stating the answer directly, then offer to explore config files if the user wants implementation help.
