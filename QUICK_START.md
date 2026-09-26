# Quick Start Guide - Modern Terminal Setup

## Installation (5 minutes)

### Step 1: Install Tools
```bash
cd ~/workspace/source-code/personal/dotfiles
source install/stack.sh
```

Wait for all tools to install (Starship, eza, ripgrep, delta, zoxide, lazygit, etc.)

### Step 2: Create Symlinks
```bash
source install/link.sh
```

Type `y` when prompted to override existing dotfiles.

### Step 3: Install Nerd Font
```bash
brew install font-jetbrains-mono-nerd-font
```

**Important**: Configure your terminal app to use "JetBrains Mono" font.

### Step 4: Reload Shell
```bash
# For Bash
source ~/.bashrc

# For Zsh (recommended)
source ~/.zshrc
```

### Step 5: Install LSP Servers (for Neovim)
```bash
# Python
pip install pyright black isort

# JavaScript/TypeScript
npm install -g typescript typescript-language-server prettier

# Optional: HTML/CSS
npm install -g vscode-langservers-extracted

# Optional: Lua
brew install stylua lua-language-server
```

## Verification (1 minute)

Test that everything works:

```bash
# Test Starship prompt
cd ~/workspace
# You should see a beautiful prompt with git info

# Test modern tools
ls        # Should show icons with eza
ll        # Detailed view with git status
rg TODO   # Fast search with colors

# Test zoxide
cd /tmp
cd ~/workspace/source-code/personal/dotfiles
cd /tmp
z dot     # Should jump back to dotfiles

# Test lazygit
lg        # Should open git TUI (press 'q' to quit)

# Test Neovim
nvim      # Should show startup screen, plugins auto-install
```

## Essential Commands

### File Navigation
```bash
ls          # Modern ls with icons (eza)
ll          # Detailed list with git status
lt          # Tree view (2 levels deep)
z <name>    # Jump to frequently used directory
```

### Search
```bash
rg <term>   # Fast code search (ripgrep)
fd <name>   # Fast file finder
frg <term>  # Search with file preview
fp          # Preview files with syntax highlighting
```

### Git Workflow
```bash
lg          # Launch lazygit TUI
git diff    # Beautiful side-by-side diff with delta
git log     # Enhanced log with colors
```

### FZF Shortcuts (in terminal)
```bash
Ctrl+B      # Fuzzy find git branch and checkout
Ctrl+L      # Browse git log with preview
Ctrl+K      # Kill processes with preview
Ctrl+R      # Search command history (built-in fzf)
Ctrl+T      # Find files (built-in fzf)
```

### Neovim (leader key = Space)
```bash
nvim file.py

# Inside Neovim:
Space ff    # Find files
Space fs    # Search text in files
Space e     # Toggle file explorer
gd          # Go to definition
gr          # Show references
K           # Show documentation
Space ca    # Code actions
Space rn    # Rename symbol
Space f     # Format code
:q          # Quit
```

### System Monitoring
```bash
top         # Beautiful system monitor (btop)
df          # Better disk usage (duf)
ps          # Better process viewer (procs)
```

## Tmux Integration

```bash
# Start tmux
tmux

# Inside tmux (prefix = Ctrl+A):
Ctrl+A g    # Launch lazygit
Ctrl+A |    # Split vertical
Ctrl+A -    # Split horizontal
Ctrl+A h/j/k/l # Navigate panes
Ctrl+A r    # Reload config
```

## Zsh-Specific Features

```bash
# Auto-suggestions (as you type)
# Press Ctrl+Space to accept suggestion

# Syntax highlighting
# Commands turn green if valid, red if invalid

# Enhanced tab completion with fzf
# Press Tab and use arrow keys to navigate
```

## Tips for Maximum Productivity

1. **Use `z` instead of `cd`** - It learns your frequently visited directories
   ```bash
   z dot    # Jump to dotfiles
   z work   # Jump to workspace
   ```

2. **Use `lg` for all git operations** - Much faster than CLI
   ```bash
   lg       # Open lazygit
   # Use Space to stage, c to commit, P to push
   ```

3. **Use FZF everywhere** - Ctrl+R for history, Ctrl+T for files
   ```bash
   vim $(fzf)  # Open file from fuzzy finder
   ```

4. **Use Neovim for coding** - LSP provides IDE features
   ```bash
   nvim src/  # Edit whole directory
   # Use Telescope (Space ff) to navigate files
   ```

5. **Customize your prompt** - Edit `~/.config/starship/starship.toml`

## Common Issues

### Icons not showing?
- Install JetBrains Mono Nerd Font
- Configure terminal to use it
- Restart terminal

### Zoxide not working?
```bash
# Manually initialize
eval "$(zoxide init zsh)"  # or bash
```

### Neovim LSP not working?
```bash
nvim
:checkhealth     # Check for issues
:LspInfo         # Check LSP status
```

### Zinit (zsh) not loading?
```bash
rm -rf ~/.local/share/zinit
source ~/.zshrc
```

## What's Different?

### Before vs After

**Before**:
```bash
cd ~/long/path/to/project
ls -la
grep -r "TODO" .
git status
git add .
git commit -m "message"
git push
```

**After**:
```bash
z proj          # Smart jump
ll              # Icons + git status
rg TODO         # Fast search with colors
lg              # Visual TUI handles everything
```

**Time saved**: ~60% faster git workflows, ~80% faster navigation

## Next Steps

1. **Explore Lazygit**: Learn keybindings (`?` for help)
2. **Configure Neovim**: Add more LSP servers, change theme
3. **Customize Starship**: Edit your prompt
4. **Try Alacritty/WezTerm**: GPU-accelerated terminals
5. **Read IMPLEMENTATION_SUMMARY.md**: Full details on all features

## Getting Help

- **Starship**: `starship --help` or https://starship.rs
- **Lazygit**: Press `?` inside lazygit or check https://github.com/jesseduffield/lazygit
- **Neovim**: `:help` inside Neovim
- **FZF**: https://github.com/junegunn/fzf

## Cheat Sheet

Print this for reference:

```bash
# Navigation
z <dir>      # Smart cd
..           # Up one level
ls/ll/lt     # Modern ls with icons

# Search
rg <term>    # Search in files
fd <name>    # Find files
frg          # Search + preview

# Git
lg           # Lazygit TUI
Ctrl+B       # Find git branch
Ctrl+L       # Git log browser

# Neovim
nvim         # Launch
Space ff     # Find files
Space fs     # Find text
Space e      # File explorer
gd           # Go to definition
K            # Documentation

# System
top          # btop monitor
df           # duf disk usage
ps           # procs viewer
```

---

**You're all set!** Start using the modern terminal tools and enjoy the productivity boost! 🚀
