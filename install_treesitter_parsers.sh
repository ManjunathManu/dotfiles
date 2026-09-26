#!/usr/bin/env bash
# Install Treesitter parsers for Neovim

echo "Installing Treesitter parsers..."

# Open Neovim and install parsers
nvim --headless \
  +'lua vim.cmd("TSInstall python")' \
  +'lua vim.cmd("TSInstall lua")' \
  +'lua vim.cmd("TSInstall bash")' \
  +'lua vim.cmd("TSInstall javascript")' \
  +'lua vim.cmd("TSInstall typescript")' \
  +'lua vim.cmd("TSInstall json")' \
  +'lua vim.cmd("TSInstall yaml")' \
  +'lua vim.cmd("TSInstall html")' \
  +'lua vim.cmd("TSInstall css")' \
  +'lua vim.cmd("TSInstall markdown")' \
  +'sleep 10' \
  +qall

echo "Parsers installed! Check ~/.local/share/nvim/site/parser/"
ls -lh ~/.local/share/nvim/site/parser/
