#!/bin/bash

source utils.sh

info "Installing dotfiles...."

h1 "Step 1: Configure development environment"
source install/stack.sh

h1 "Step 2: Creating symlink for dotfiles"
source install/link.sh

h1 "Step 3: Configure git globally"
source install/git.sh
newLine

h2 "Your development stack"
newLine
success "nvm: $(nvm --version)"
success "node: $(node -v)"
success "npm: $(npm -v)"
success "aws: $(aws --version 2>&1)"
success "tmux: $(tmux -V)"
success "python: $(python --version)"
success "Angualr cli: $(ng version)"
success "Docker: $(docker version)"
success "Nginx: $(nginx -v)"

success "Installation completed...."
