-- Neovim Options Configuration
-- Modern editor settings for productivity

local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Tabs & Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

-- Line wrapping
opt.wrap = true
opt.linebreak = true  -- Wrap at word boundaries, not mid-word

-- Search settings
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- Cursor line
opt.cursorline = true

-- Appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- Backspace
opt.backspace = "indent,eol,start"

-- Clipboard
opt.clipboard:append("unnamedplus")

-- Split windows
opt.splitright = true
opt.splitbelow = true

-- Consider - as part of keyword
opt.iskeyword:append("-")

-- Disable swapfile
opt.swapfile = false
opt.backup = false
opt.writebackup = false

-- Undo
opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/undo"

-- Update time
opt.updatetime = 250
opt.timeoutlen = 300

-- Completion
opt.completeopt = "menu,menuone,noselect"

-- Mouse (enable for all modes, essential for tmux compatibility)
opt.mouse = "a"
opt.mousemoveevent = true  -- Enable mouse move events for better plugin support

-- Scrolloff
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.sidescroll = 1  -- Smooth horizontal scrolling (1 column at a time)

-- Command line
opt.cmdheight = 1
opt.showmode = false

-- File encoding
opt.fileencoding = "utf-8"

-- Folding (basic settings, Treesitter folding configured in plugins.lua)
opt.foldmethod = "expr"
opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldenable = true     -- Enable folding by default
opt.foldlevel = 1         -- Start with top-level folds closed
opt.foldlevelstart = 1    -- Start with this fold level when opening files
opt.foldnestmax = 4       -- Limit fold nesting depth

-- Performance
opt.lazyredraw = true

-- Shorter messages
opt.shortmess:append("c")

-- Persistent undo
opt.undolevels = 10000

-- Better diff
opt.diffopt:append("vertical")

-- Statusline (lualine will handle this)
opt.laststatus = 3  -- Global statusline

-- Show matching brackets
opt.showmatch = true

-- Wildmenu
opt.wildmode = "longest:full,full"
opt.wildignore:append({ "*.pyc", "*.o", "*.obj", "*.swp", "*.class", "*.zip", "*/node_modules/*", "*/.git/*" })

-- Format options
opt.formatoptions:append("r")  -- Continue comments on newline

-- Filetype overrides
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = ".env*",
  callback = function()
    vim.bo.filetype = "sh"
  end,
})

-- List chars (show invisible characters)
opt.list = true
opt.listchars = {
  tab = "→ ",
  trail = "·",
  extends = "»",
  precedes = "«",
  nbsp = "␣",
}
