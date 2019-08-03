#!/bin/bash

source env.sh
source utils.sh

info "Installing dotfiles...."

h1 "Step 1: Creating symlink for dotfiles"
source install/link.sh

h1 "Step 2: Configure git globally"
source install/git.sh

success "Installation completed...."
