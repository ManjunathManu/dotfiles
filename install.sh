#!/bin/bash

source utils.sh

info "Installing dotfiles...."

h1 "Step 1: Configure development environment"
source install/stack.sh

h1 "Step 2: Creating symlink for dotfiles"
source install/link.sh

h1 "Step 3: Configure git globally"
source install/git.sh

h1 "Step 4: Setup Enhanced Terminal Features"
source install/fzf_setup.sh

h1 "Step 5: Setup Zsh Plugins"
source install/zsh_plugins_setup.sh
newLine

h2 "Your development stack"
newLine
success "nvm: $(nvm --version)"
success "node: $(node -v)"
success "npm: $(npm -v)"
success "python: $(python3 --version 2>&1)"
success "aws: $(aws --version 2>&1)"
success "kitty: $(kitty --version 2>&1)"
success "nvim: $(nvim --version 2>&1 | head -1)"
success "Brewfile: $(brew bundle check --file="$(pwd)/Brewfile" --no-upgrade 2>&1 | tail -1)"

success "Installation completed...."
