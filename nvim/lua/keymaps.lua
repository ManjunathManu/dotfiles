-- Neovim Keymaps Configuration
-- Productive keybindings for modern workflow

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Leader key is set in init.lua as <Space>

-- Better escape
keymap.set("i", "jk", "<ESC>", opts)
keymap.set("i", "kj", "<ESC>", opts)

-- Clear search highlighting
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Delete without yanking
keymap.set({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete without yanking" })

-- Save file
keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })
keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })
keymap.set("n", "<leader>x", ":wq<CR>", { desc = "Save and quit" })

-- Increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- Window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- Navigate between windows
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Resize windows
keymap.set("n", "<C-Up>", ":resize +2<CR>", opts)
keymap.set("n", "<C-Down>", ":resize -2<CR>", opts)
keymap.set("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap.set("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Tab management
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

-- Fast tab navigation (no leader key)
-- These are Vim defaults, but re-declared explicitly in case a plugin shadows them.
keymap.set("n", "gt", "<cmd>tabn<CR>", { desc = "Go to next tab" })
keymap.set("n", "gT", "<cmd>tabp<CR>", { desc = "Go to previous tab" })

-- Better indenting
keymap.set("v", "<", "<gv", opts)
keymap.set("v", ">", ">gv", opts)

-- Move text up and down
keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts)
keymap.set("n", "<A-j>", ":m .+1<CR>==", opts)
keymap.set("n", "<A-k>", ":m .-2<CR>==", opts)

-- Keep cursor centered when scrolling
keymap.set("n", "<C-d>", "<C-d>zz", opts)
keymap.set("n", "<C-u>", "<C-u>zz", opts)
keymap.set("n", "n", "nzzzv", opts)
keymap.set("n", "N", "Nzzzv", opts)

-- Paste without yanking
keymap.set("v", "p", '"_dP', opts)

-- Buffer navigation
keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })
keymap.set("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })

-- File explorer (nvim-tree)
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
keymap.set("n", "<leader>ef", ":NvimTreeFindFile<CR>", { desc = "Find current file in file explorer" })

-- Telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Fuzzy find files in cwd" })
keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", { desc = "Fuzzy find recent files" })
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<CR>", { desc = "Find string in cwd" })
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<CR>", { desc = "Find string under cursor in cwd" })
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "List open buffers" })
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "List help tags" })

-- Git (via fugitive, gitsigns, and lazygit)
keymap.set("n", "<leader>gg", "<cmd>LazyGit<CR>", { desc = "Open LazyGit" })
keymap.set("n", "<leader>gs", "<cmd>Git<CR>", { desc = "Git status" })
keymap.set("n", "<leader>gb", "<cmd>Git blame<CR>", { desc = "Git blame" })
keymap.set("n", "<leader>gd", "<cmd>Gvdiffsplit<CR>", { desc = "Git diff" })

-- LSP keymaps (will be set in plugins/lsp.lua when LSP attaches)
-- These are just placeholders for reference
-- gd - Go to definition
-- gD - Go to declaration
-- gi - Go to implementation
-- gr - Show references
-- K - Hover documentation
-- <leader>ca - Code actions
-- <leader>rn - Rename
-- <leader>f - Format

-- Diagnostic keymaps
keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })
keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })
keymap.set("n", "<leader>df", vim.diagnostic.open_float, { desc = "Show diagnostic in float" })
keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics<CR>", { desc = "Show buffer diagnostics" })

-- Terminal
keymap.set("n", "<leader>tt", ":terminal<CR>", { desc = "Open terminal" })
keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
-- Direct window navigation from terminal mode (works even when Esc is captured)
keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Go to left window from terminal" })
keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Go to lower window from terminal" })
keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Go to upper window from terminal" })
keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Go to right window from terminal" })

-- Quick fix list
keymap.set("n", "<leader>qo", ":copen<CR>", { desc = "Open quickfix list" })
keymap.set("n", "<leader>qc", ":cclose<CR>", { desc = "Close quickfix list" })
keymap.set("n", "<leader>qn", ":cnext<CR>", { desc = "Next quickfix item" })
keymap.set("n", "<leader>qp", ":cprev<CR>", { desc = "Previous quickfix item" })

-- Claude Code AI
keymap.set("n", "<leader>ac", "<cmd>ClaudeCode<cr>", { desc = "Toggle Claude Code" })
keymap.set("n", "<leader>af", "<cmd>ClaudeCodeFocus<cr>", { desc = "Focus Claude" })
keymap.set("n", "<leader>ax", "<cmd>ClaudeCode<cr>", { desc = "Close Claude" })
keymap.set("n", "<leader>ar", "<cmd>ClaudeCode --resume<cr>", { desc = "Resume Claude session" })
keymap.set("n", "<leader>aR", "<cmd>ClaudeCode --continue<cr>", { desc = "Continue Claude conversation" })
keymap.set("n", "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>", { desc = "Select Claude model" })
keymap.set("v", "<leader>as", "<cmd>ClaudeCodeSend<cr>", { desc = "Send to Claude" })
keymap.set("n", "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>", { desc = "Add buffer to Claude" })
keymap.set("n", "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", { desc = "Accept Claude diff" })
keymap.set("n", "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>", { desc = "Deny Claude diff" })

-- Code Folding
keymap.set("n", "<leader>z", "za", { desc = "Toggle fold at cursor" })
keymap.set("n", "<leader>zr", "zR", { desc = "Open all folds" })
keymap.set("n", "<leader>zm", "zM", { desc = "Close all folds" })
keymap.set("n", "<leader>zo", "zo", { desc = "Open fold at cursor" })
keymap.set("n", "<leader>zc", "zc", { desc = "Close fold at cursor" })
