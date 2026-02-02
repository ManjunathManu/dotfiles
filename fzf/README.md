# Enhanced Terminal Features Guide

This guide covers the Warp-inspired terminal enhancements added to your dotfiles, including fuzzy finding, command palette, autosuggestions, and enhanced history.

## Table of Contents

- [Overview](#overview)
- [Installation](#installation)
- [Features](#features)
  - [Command Palette](#command-palette)
  - [Enhanced History Search](#enhanced-history-search)
  - [File and Directory Navigation](#file-and-directory-navigation)
  - [Autosuggestions (zsh)](#autosuggestions-zsh)
- [Keyboard Shortcuts](#keyboard-shortcuts)
- [Customization](#customization)
- [Troubleshooting](#troubleshooting)

## Overview

These enhancements bring modern terminal features to Terminal.app without requiring Warp or other specialized terminal applications. All features work seamlessly with your existing tmux setup.

**Tools Used:**
- **fzf**: Fuzzy finder for fast searching
- **fd**: Fast file finder (replacement for `find`)
- **bat**: Cat with syntax highlighting
- **zsh-autosuggestions**: Fish-like autosuggestions for zsh

## Installation

Run the main installer to set up all enhancements:

```bash
./install.sh
```

Or install components individually:

```bash
# Install fzf
source install/fzf_setup.sh

# Install zsh plugins
source install/zsh_plugins_setup.sh
```

After installation, restart your terminal or source your shell configuration:

```bash
# For bash
source ~/.bashrc

# For zsh
source ~/.zshrc
```

## Features

### Command Palette

A searchable menu of commonly used commands organized by category (Git, AWS, Docker, tmux, etc.).

**Usage:**
1. Press `Ctrl+G` to open the command palette
2. Type to fuzzy search commands (e.g., type "git st" to find "git status")
3. Use arrow keys to navigate
4. Press `Enter` to execute the selected command
5. Press `Ctrl+C` to cancel

**Categories:**
- Git commands (status, diff, commit, push, etc.)
- AWS commands (profile switching, SSO, SSM)
- Docker commands (container management, logs)
- Tmux commands (session management)
- Navigation shortcuts
- NPM commands
- Nginx commands
- System commands
- Python/pip commands
- Kubernetes commands
- File operations

**Adding Custom Commands:**

Edit `~/.fzf/workflows.txt` to add your own commands:

```
command | category | description
```

Example:
```
npm run test | npm | Run test suite
docker-compose up -d | docker | Start docker-compose services
```

### Enhanced History Search

Dramatically improved command history with timestamps and fuzzy search.

**Features:**
- 50,000 commands in memory (up from default 1,000)
- 100,000 commands saved to disk
- Timestamps on all commands
- Duplicate removal
- Real-time history sharing across sessions
- Fuzzy search with fzf

**Usage:**

Press `Ctrl+R` to search history with fzf:
- Type to fuzzy search (matches anywhere in command)
- Use arrow keys to navigate
- Press `Enter` to select
- Press `Ctrl+C` to cancel
- Press `?` to toggle preview window

**View history with timestamps:**

```bash
history | tail -20
```

Output shows:
```
2026-02-02 10:15:32  git status
2026-02-02 10:16:45  npm run dev
```

### File and Directory Navigation

Fast fuzzy finding for files and directories.

**File Finder (`Ctrl+T`):**
1. Press `Ctrl+T` in your command line
2. Type to fuzzy search files
3. Select file(s) with `Enter` (use `Tab` to select multiple)
4. Selected file paths are inserted at cursor

**Directory Navigator (`Alt+C`):**
1. Press `Alt+C` (Option+C on Mac)
2. Type to fuzzy search directories
3. Select directory with `Enter`
4. Immediately changes to selected directory

**Preview:**
- Press `?` to toggle file/directory preview
- Preview shows file contents (with syntax highlighting via bat) or directory tree

**Enhanced Tab Completion:**

Use `**<TAB>` trigger for fuzzy completion:

```bash
vim **<TAB>        # Fuzzy find file to edit
cd **<TAB>         # Fuzzy find directory to change into
kill -9 **<TAB>    # Fuzzy find process to kill
```

### Autosuggestions (zsh)

Fish-like command suggestions based on your history (zsh only).

**How it works:**
- As you type, see gray text suggesting commands from history
- Suggestions appear automatically
- Based on your command history and completion system

**Accepting suggestions:**
- Press `→` (Right Arrow) to accept entire suggestion
- Press `End` to accept entire suggestion
- Press `Ctrl+Space` to accept entire suggestion
- Keep typing to refine/ignore suggestion

**Example:**

You type: `git st`
Suggestion appears: `git status` (in gray)
Press `→` to complete it

## Keyboard Shortcuts

### Global Shortcuts

| Shortcut | Function | Context |
|----------|----------|---------|
| `Ctrl+G` | Open command palette | bash, zsh |
| `Ctrl+R` | Enhanced history search | bash, zsh |
| `Ctrl+T` | File finder | bash, zsh |
| `Alt+C` | Directory navigator | bash, zsh |

### fzf Navigation (Inside fzf menus)

| Shortcut | Function |
|----------|----------|
| `↑/↓` or `Ctrl+K/J` | Navigate up/down |
| `Enter` | Select |
| `Tab` | Multi-select (mark item) |
| `Shift+Tab` | Multi-select (unmark item) |
| `Ctrl+A` | Select all |
| `Ctrl+C` or `Esc` | Cancel |
| `?` | Toggle preview |
| `Ctrl+Y` | Copy selection to clipboard |
| `Ctrl+E` | Open in vim |

### Autosuggestions (zsh)

| Shortcut | Function |
|----------|----------|
| `→` (Right Arrow) | Accept suggestion |
| `End` | Accept suggestion |
| `Ctrl+Space` | Accept suggestion |
| `Ctrl+F` | Accept one word |

## Customization

### Adding Commands to Palette

Edit `~/.fzf/workflows.txt`:

```bash
vim ~/.fzf/workflows.txt
```

Format: `command | category | description`

**Tips:**
- Use uppercase words for placeholders (e.g., `NAME`, `MESSAGE`, `PORT`)
- Commands with placeholders will pre-fill the command line for editing
- Organize by category (Git, Docker, etc.) using comment headers
- Keep descriptions concise but descriptive

### Customizing fzf Appearance

Edit `~/.enhanced_bash` or `~/.enhanced_zsh` and modify `FZF_DEFAULT_OPTS`:

```bash
export FZF_DEFAULT_OPTS="
  --height 80%              # Window height
  --border                  # Show border
  --layout=reverse          # Top to bottom
  --preview-window=:hidden  # Hide preview by default
  --color='...'             # Color scheme
  --prompt='∼ '            # Prompt character
  --pointer='▶'            # Selection pointer
  --marker='✓'             # Multi-select marker
"
```

### Adjusting History Size

Edit `~/.enhanced_bash` (for bash) or `~/.enhanced_zsh` (for zsh):

```bash
# Increase even more
export HISTSIZE=100000
export HISTFILESIZE=200000  # bash
export SAVEHIST=200000      # zsh
```

### Changing Autosuggestion Color

Edit `~/.enhanced_zsh`:

```bash
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#666666"  # Change hex color
```

## Troubleshooting

### fzf not working

**Check if fzf is installed:**
```bash
fzf --version
```

**Reinstall if needed:**
```bash
brew install fzf
$(brew --prefix)/opt/fzf/install --key-bindings --completion --no-update-rc
```

**Verify shell integration:**
```bash
# For bash
ls -la ~/.fzf.bash

# For zsh
ls -la ~/.fzf.zsh
```

### Command palette not opening

**Verify Ctrl+G binding:**

For bash:
```bash
bind -p | grep command_palette
```

For zsh:
```bash
bindkey | grep command_palette
```

**Check workflows file exists:**
```bash
ls -la ~/.fzf/workflows.txt
cat ~/.fzf/workflows.txt
```

### Autosuggestions not appearing (zsh)

**Check if plugin is installed:**
```bash
ls -la ~/.zsh/plugins/zsh-autosuggestions/
```

**Reinstall if needed:**
```bash
rm -rf ~/.zsh/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/plugins/zsh-autosuggestions
```

**Verify it's loaded:**
```bash
echo $ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE
```

Should output: `fg=#666666`

### History not persisting

**Check history size:**
```bash
# Bash
echo $HISTSIZE $HISTFILESIZE

# Zsh
echo $HISTSIZE $SAVEHIST
```

Should show: `50000 100000`

**Check history file:**
```bash
# Bash
ls -lh ~/.bash_history

# Zsh
ls -lh ~/.zsh_history
```

**Verify history options (zsh):**
```bash
setopt | grep HIST
```

Should show: `EXTENDED_HISTORY`, `INC_APPEND_HISTORY`, `SHARE_HISTORY`, etc.

### Performance issues

**Check shell startup time:**
```bash
time bash -i -c exit
time zsh -i -c exit
```

Should be under 1 second.

**Disable features temporarily:**

Comment out lines in `~/.enhanced_bash` or `~/.enhanced_zsh` to isolate issues.

### fd or bat not found

**Install missing tools:**
```bash
brew install fd bat
```

**Verify installation:**
```bash
fd --version
bat --version
```

### Works outside tmux but not inside

**Verify enhanced config is sourced in tmux:**

Inside tmux:
```bash
echo $HISTSIZE  # Should be 50000
command -v fzf  # Should show path
```

If not working, ensure tmux shells are login shells. Add to `~/.tmux.conf`:
```
set -g default-command "${SHELL}"
```

### Keybindings conflict with tmux

If `Ctrl+G` or other shortcuts don't work in tmux, check for conflicts in `~/.tmux.conf`:

```bash
grep -E "bind.*C-g" ~/.tmux.conf
```

Change the conflicting binding or use a different key for command palette.

## Verification Commands

Run these to verify your setup:

```bash
# Installation check
command -v fzf && echo "fzf: ✓" || echo "fzf: ✗"
command -v fd && echo "fd: ✓" || echo "fd: ✗"
command -v bat && echo "bat: ✓" || echo "bat: ✗"
[[ -d ~/.zsh/plugins/zsh-autosuggestions ]] && echo "zsh-autosuggestions: ✓" || echo "zsh-autosuggestions: ✗"

# Configuration check
echo "HISTSIZE: $HISTSIZE (expect: 50000)"
echo "HISTFILESIZE: $HISTFILESIZE (bash, expect: 100000)"
echo "SAVEHIST: $SAVEHIST (zsh, expect: 100000)"

# Files check
ls -la ~/.enhanced_bash ~/.enhanced_zsh ~/.fzf/workflows.txt ~/.fzf/command-palette.sh

# Keybinding check (zsh)
bindkey | grep -E "\\^R|\\^G|\\^T"
```

## Tips and Best Practices

1. **Learn the shortcuts gradually** - Start with `Ctrl+R` and `Ctrl+G`, then add others
2. **Customize workflows.txt** - Add your most-used commands for quick access
3. **Use fuzzy matching** - Don't type full words; "gst" finds "git status"
4. **Leverage history** - Commands you run become suggestions automatically
5. **Preview files** - Press `?` in fzf to see file contents before opening
6. **Multi-select** - Use `Tab` in fzf to select multiple files at once
7. **Cross-session history** - Commands from other terminals appear instantly
8. **Tmux compatible** - All features work inside tmux sessions

## Resources

- [fzf GitHub](https://github.com/junegunn/fzf)
- [fzf Wiki](https://github.com/junegunn/fzf/wiki)
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [fd GitHub](https://github.com/sharkdp/fd)
- [bat GitHub](https://github.com/sharkdp/bat)

## Optional Enhancements

### Atuin for History Sync

Sync history across machines with SQLite-based history:

```bash
brew install atuin
atuin import auto  # Import existing history
atuin register     # Optional: cloud sync
```

Then add to shell config:
```bash
eval "$(atuin init bash)"  # or zsh
```

### fzf-tab for Enhanced Completions

Replace zsh tab completion with fzf (zsh only):

```bash
git clone https://github.com/Aloxaf/fzf-tab ~/.zsh/plugins/fzf-tab
```

Add to `~/.zshrc`:
```bash
source ~/.zsh/plugins/fzf-tab/fzf-tab.plugin.zsh
```

### Aliases for fd and bat

Add to your shell config:

```bash
alias cat='bat --paging=never'
alias find='fd'
```
