#!/usr/bin/env bash

# Neovim LSP Servers & Formatters Installation Script
# Installs all required tools for the Neovim development environment

set -e

# Source utils for pretty output
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/utils.sh"

h1 "Neovim Tools Installation"

# Check if npm is installed
if ! command -v npm &> /dev/null; then
    error "npm is not installed. Please install Node.js first."
    info "Install via: brew install node"
    exit 1
fi

# Check if brew is installed (for macOS)
if [[ "$OSTYPE" == "darwin"* ]]; then
    if ! command -v brew &> /dev/null; then
        error "Homebrew is not installed."
        info "Install from: https://brew.sh"
        exit 1
    fi
fi

h2 "Installing Node.js LSP Servers & Formatters"

info "Installing TypeScript language server..."
runCommand "npm install -g typescript typescript-language-server"

info "Installing Pyright (Python LSP)..."
runCommand "npm install -g pyright"

info "Installing HTML/CSS/JSON LSP..."
runCommand "npm install -g vscode-langservers-extracted"

info "Installing Prettier (formatter)..."
runCommand "npm install -g prettier"

h2 "Installing Lua Tools (via Homebrew)"

if [[ "$OSTYPE" == "darwin"* ]]; then
    info "Installing Lua language server..."
    runCommand "brew install lua-language-server"

    info "Installing StyLua (Lua formatter)..."
    runCommand "brew install stylua"
else
    info "Skipping Lua tools on non-macOS (install manually if needed)"
    info "  - Lua LSP: https://github.com/luals/lua-language-server"
    info "  - StyLua: https://github.com/JohnnyMorganz/StyLua"
fi

h2 "Verifying Installation"

echo ""
echo "Checking installed tools:"
echo ""

check_tool() {
    if command -v "$1" &> /dev/null; then
        success "✓ $1 installed: $(command -v $1)"
    else
        error "✗ $1 not found"
    fi
}

check_tool "typescript-language-server"
check_tool "pyright"
check_tool "prettier"
check_tool "lua-language-server"
check_tool "stylua"

echo ""
h2 "Python Tools (Already Installed)"
check_tool "black"
check_tool "isort"

echo ""
success "Installation complete!"
echo ""
info "Next steps:"
echo "  1. Launch Neovim: nvim"
echo "  2. Wait for lazy.nvim to install plugins"
echo "  3. Check LSP status: :LspInfo"
echo "  4. Run health check: :checkhealth"
echo ""
info "Optional: Install additional LSP servers via :Mason in Neovim"
