# Neovim Migration Guide

## 🎯 Status Overview

✅ **Already Set Up:**
- Neovim v0.11.5 installed (with native LSP config API!)
- Configuration files symlinked to `~/.config/nvim/`
- Python formatters (black, isort)
- lazy.nvim will auto-install on first launch
- **Updated to use Neovim 0.11+ native LSP API** (no deprecated lspconfig)

❌ **Need to Install:**
- LSP servers (for code intelligence)
- Additional formatters (prettier, stylua)

---

## 🆕 What's New in This Config

### Neovim 0.11+ Native LSP API
Your config now uses the **new native LSP configuration API** (`vim.lsp.config`) introduced in Neovim 0.11, which replaces the older `nvim-lspconfig` plugin approach. This means:

- ✅ **No deprecation warnings**
- ✅ **Faster startup** (one less plugin to load)
- ✅ **Cleaner API** (built into Neovim core)
- ✅ **More consistent** with Neovim's design philosophy

**What changed:**
```lua
-- Old way (deprecated)
require('lspconfig').pyright.setup({...})

-- New way (native)
vim.lsp.config.pyright = {...}
vim.lsp.enable('pyright')
```

---

## 📦 Required LSP Servers & Formatters

### Python Development
- ✅ **black** - Already installed
- ✅ **isort** - Already installed
- ❌ **pyright** - Python LSP server

### JavaScript/TypeScript Development
- ❌ **typescript-language-server** - LSP for JS/TS
- ❌ **prettier** - Code formatter

### HTML/CSS Development
- ❌ **vscode-langservers-extracted** - LSP for HTML/CSS/JSON

### Lua Development (for Neovim config)
- ❌ **lua-language-server** - Lua LSP
- ❌ **stylua** - Lua formatter

---

## 🚀 Installation Commands

### 1. Install Node.js LSP Servers (via npm)

```bash
# Install TypeScript LSP
npm install -g typescript typescript-language-server

# Install HTML/CSS/JSON LSP
npm install -g vscode-langservers-extracted

# Install Prettier
npm install -g prettier

# Install Pyright (Python LSP)
npm install -g pyright
```

### 2. Install Lua Tools (via Homebrew)

```bash
# Lua language server
brew install lua-language-server

# Lua formatter
brew install stylua
```

### Alternative: Install via Mason (Recommended)

Neovim has a plugin called Mason that can manage LSP servers for you. Once you launch Neovim:

```vim
:Mason
```

Then install the following (press `i` to install):
- pyright
- typescript-language-server
- html-lsp
- css-lsp
- lua-ls
- prettier
- stylua

---

## 🔄 Migration Steps

### Step 1: First Launch

```bash
# Launch Neovim (will auto-install lazy.nvim and plugins)
nvim
```

On first launch:
1. lazy.nvim will bootstrap itself
2. All plugins will be automatically installed
3. Treesitter parsers will be installed
4. You'll see the Alpha startup screen

This may take 1-2 minutes. Wait for all installations to complete.

### Step 2: Install LSP Servers

**Option A: Via Mason (Recommended - inside Neovim)**
```vim
:Mason
```
Navigate with `j`/`k`, press `i` to install servers listed above.

**Option B: Via Command Line (Manual)**
Run the npm/brew commands from the Installation Commands section above.

### Step 3: Verify Installation

```bash
# Check LSP servers
which pyright typescript-language-server prettier stylua

# Inside Neovim, open a Python file and check LSP
nvim test.py
# Then in Neovim:
:LspInfo
```

### Step 4: Test Key Features

Create a test file to verify everything works:

```bash
nvim ~/test.py
```

Then test:
- **File explorer**: Press `<Space>e`
- **Fuzzy find**: Press `<Space>ff`
- **Live grep**: Press `<Space>fs`
- **LSP hover**: Hover over a function and press `K`
- **Go to definition**: Press `gd` on a symbol
- **Format**: Press `<Space>f`
- **Keybinding hints**: Press `<Space>` and wait 500ms

---

## 🔑 Essential New Keybindings

### Core Workflow
| Key | Action | Plugin |
|-----|--------|--------|
| `<Space>e` | Toggle file explorer | nvim-tree |
| `<Space>ef` | Find current file in tree | nvim-tree |
| `<Space>ff` | Fuzzy find files | Telescope |
| `<Space>fs` | Live grep (search text) | Telescope |
| `<Space>fr` | Recent files | Telescope |
| `<Space>fb` | List buffers | Telescope |

### LSP (Code Intelligence)
| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Show references |
| `gi` | Go to implementation |
| `K` | Show documentation |
| `<Space>rn` | Rename symbol |
| `<Space>ca` | Code actions |
| `<Space>f` | Format code |
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |

### Git Integration
| Key | Action | Plugin |
|-----|--------|--------|
| `<Space>gs` | Git status | fugitive |
| `<Space>gb` | Git blame | fugitive |
| `<Space>gd` | Git diff | fugitive |
| `<Space>hp` | Preview hunk | gitsigns |
| `<Space>hs` | Stage hunk | gitsigns |
| `<Space>hr` | Reset hunk | gitsigns |
| `]c` | Next git hunk | gitsigns |
| `[c` | Previous git hunk | gitsigns |

### Window/Tab Management
| Key | Action |
|-----|--------|
| `<Space>sv` | Split vertically |
| `<Space>sh` | Split horizontally |
| `<Space>se` | Make splits equal |
| `<Space>sx` | Close split |
| `<C-h/j/k/l>` | Navigate splits |
| `<Space>to` | New tab |
| `<Space>tn/tp` | Next/previous tab |

---

## 🎨 Visual Differences

### Theme
- **Old**: Solarized8 (dark)
- **New**: Tokyo Night (dark, modern)

If you prefer Solarized, you can change the colorscheme in `nvim/init.lua:29`.

### UI Enhancements
- **Startup Screen**: Alpha dashboard with quick actions
- **File Icons**: nvim-web-devicons in tree and status line
- **Git Signs**: Inline git change indicators (│ for additions)
- **Indent Guides**: Visual indentation lines
- **Which-key**: Popup showing available keybindings

---

## 📝 Configuration Comparison

### Vim Config Structure
```
vim/
└── vimrc.symlink (520 lines, single file)
```

### Neovim Config Structure
```
nvim/
├── init.lua.symlink          # Bootstrap & load modules
└── lua/
    ├── options.lua           # Editor settings
    ├── keymaps.lua          # Key bindings
    └── plugins.lua          # Plugin configs (lazy.nvim)
```

### Editing Your Config
```bash
# Old way (Vim)
vim ~/.vimrc

# New way (Neovim)
nvim ~/.config/nvim/init.lua
# or use the startup screen shortcut: press 'c'
```

---

## 🔧 Troubleshooting

### Plugins not loading
```vim
:Lazy sync
```

### LSP not working
```vim
:LspInfo          " Check LSP status
:LspRestart       " Restart LSP
```

### Treesitter issues
```vim
:TSUpdate         " Update parsers
:checkhealth      " Check overall health
```

### Format not working
```vim
:ConformInfo      " Check formatter status
```

### Complete health check
```vim
:checkhealth      " Shows issues with your setup
```

---

## 🚦 Python Virtual Environment Detection

Your Neovim config automatically detects Python virtual environments!

**How it works:**
1. When you open a Python file, Neovim looks for: `venv/`, `.venv/`, `env/`, `.env/`
2. If found, it automatically uses that interpreter for LSP
3. Falls back to pyenv shim if no venv found

**Manual commands:**
```vim
:LspRestart                           " Restart LSP after changing venv
```

---

## 🎓 Learning Resources

### Telescope (Fuzzy Finder)
- `<Space>ff` - Start typing filename
- `<C-j/k>` - Move up/down
- `<Enter>` - Open file
- `<C-q>` - Send to quickfix list

### Neovim Native Features
- `:help telescope` - Telescope documentation
- `:help lsp` - LSP documentation
- `:help lua-guide` - Lua in Neovim guide

### Plugin Documentation
- [lazy.nvim](https://github.com/folke/lazy.nvim)
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
- [nvim-tree](https://github.com/nvim-tree/nvim-tree.lua)

---

## ⚡ Why Switch to Neovim?

### Performance Benefits
- **Native LSP**: 30-50% faster than CoC (no Node.js overhead)
- **Lazy Loading**: Plugins load only when needed
- **Treesitter**: Faster, more accurate syntax highlighting
- **Lua**: ~10x faster than VimScript

### Modern Features
- **Better async**: Non-blocking operations
- **Built-in LSP**: No external dependencies
- **Lua API**: More powerful, cleaner configuration
- **Active development**: Frequent updates and improvements

### Developer Experience
- **which-key**: Discover keybindings as you type
- **Telescope**: Powerful fuzzy finding everywhere
- **Better git integration**: Inline diff markers
- **Mason**: Easy LSP server management

---

## 🔄 Keeping Both Configs

You can keep both Vim and Neovim configs side by side:
- Vim: `~/.vimrc` (current setup)
- Neovim: `~/.config/nvim/` (new setup)

Use `vim` for the old config, `nvim` for the new one.

Once you're comfortable with Neovim, you can optionally alias:
```bash
# Add to ~/.bashrc or ~/.zshrc
alias vim='nvim'
alias vi='nvim'
```

---

## 📋 Quick Start Checklist

- [ ] Install LSP servers (npm/brew commands above)
- [ ] Launch Neovim: `nvim` (wait for plugin installation)
- [ ] Install LSP servers via `:Mason` (optional if using npm)
- [ ] Test file explorer: `<Space>e`
- [ ] Test fuzzy find: `<Space>ff`
- [ ] Open a Python file and test LSP: `gd`, `K`, `<Space>f`
- [ ] Review keybindings: Press `<Space>` and wait
- [ ] Run health check: `:checkhealth`

---

## 🎉 Next Steps

1. **Launch Neovim** and let it set up
2. **Install LSP servers** via Mason or npm
3. **Practice new keybindings** (especially `<Space>ff`, `<Space>fs`, `<Space>e`)
4. **Customize** if needed (edit `~/.config/nvim/lua/` files)
5. **Gradually switch** your workflow from Vim to Neovim

Remember: You don't have to switch completely overnight. Keep both and gradually transition!
