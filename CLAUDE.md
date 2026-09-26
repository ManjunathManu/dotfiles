# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository for macOS/Linux development environment configuration. It manages shell configurations (bash/zsh), tmux settings, vim configuration, and automated installation of development tools.

## Architecture

### Symlink-Based Configuration System

The core architecture uses symbolic links to manage dotfiles:

- Files ending with `.symlink` are automatically linked to `$HOME/.{basename}` by `install/link.sh`
- Examples:
  - `bash/bashrc.symlink` → `~/.bashrc`
  - `tmux/tmux.conf.symlink` → `~/.tmux.conf`
  - `vim/vimrc.symlink` → `~/.vimrc`

### Installation System

The installation process is orchestrated through `install.sh`, which sources three modular scripts:

1. **install/stack.sh** - Installs development tools (NVM, Angular CLI, Docker, AWS CLI, tmux, Python, vim, Nginx)
2. **install/link.sh** - Creates symlinks for all `.symlink` files
3. **install/git.sh** - Interactive git global configuration

All scripts use helper functions from `utils.sh` for consistent output formatting and command execution.

### Directory Structure

- `bash/` - Bash and Zsh configurations with aliases
- `tmux/` - Tmux configuration with custom theme and keybindings
- `vim/` - Vim configuration using Vundle plugin manager
- `install/` - Installation scripts for environment setup
- `bin/` - Custom executable scripts
- `config/` - Machine-local settings: `*.local.sh` files are gitignored; `aws.example.sh` is the template for `aws.local.sh` (AWS profiles, TEAM settings)
- `utils.sh` - Shared bash utility functions for styled output and command execution

## Key Commands

### Initial Setup

```bash
# Full installation (installs tools, creates symlinks, configures git)
./install.sh

# Install only symlinks
source install/link.sh

# Configure git globally (interactive)
source install/git.sh
```

### Testing Changes

After modifying configuration files:

```bash
# For bash changes
source ~/.bashrc

# For zsh changes
source ~/.zshrc

# For tmux changes (from within tmux)
tmux source-file ~/.tmux.conf
# Or use the configured keybinding: Ctrl+A then r
```

## Configuration Details

### Tmux Customizations

- Prefix key: `Ctrl+A` (instead of default `Ctrl+B`)
- Vim-style keybindings in copy mode
- Mouse support enabled
- Reload config: `Ctrl+A` then `r`
- macOS clipboard integration via `pbcopy`/`pbpaste`

### Shell Configuration

Both bash and zsh configurations are maintained:
- `bashrc.symlink` / `zshrc.symlink` - Main shell configuration
- `bash_aliases.symlink` / `zsh_aliases.symlink` - Command aliases
- SSH and kubectl autocompletion enabled in bashrc

### Vim Setup

- Uses Vundle as plugin manager
- Plugins include: vim-fugitive, nerdtree, ctrlp.vim
- vim-airline for enhanced status line
- Comment highlighting enabled for JSON files

## Working with This Repository

### Adding New Dotfiles

1. Create file with `.symlink` extension (e.g., `bash/new_config.symlink`)
2. Run `source install/link.sh` to create the symlink
3. The file will be linked to `~/.new_config`

### Modifying Installation Scripts

- All installation scripts use functions from `utils.sh` for consistency
- Available utility functions: `h1()`, `h2()`, `info()`, `success()`, `error()`, `runCommand()`
- The `runCommand()` function handles command execution with automatic error checking and logging
- Use `typeExists()` to check if a command is available before attempting installation

### Platform Differences

The repository supports both macOS and Linux:
- macOS-specific: Uses `pbcopy`/`pbpaste` for clipboard in tmux
- Linux-specific: Some package installation commands may differ (commented out brew references suggest migration from apt-get)
- Git credential helper automatically selects `osxkeychain` for macOS, `cache` or `store` for Linux

## Current State

The repository is configured for macOS (branch: `mac`), with some Linux-specific code commented out in installation scripts. Recent work includes updates to bash configuration for SSH/kubectl autocompletion and tmux theme customizations.
