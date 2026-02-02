#!/bin/bash
source utils.sh

h2 "Installing zsh-autosuggestions"

ZSH_CUSTOM="${HOME}/.zsh/plugins"
AUTOSUGG_DIR="${ZSH_CUSTOM}/zsh-autosuggestions"

if [[ -d "$AUTOSUGG_DIR" ]]; then
    success "zsh-autosuggestions already installed"
else
    info "Creating plugins directory"
    mkdir -p "$ZSH_CUSTOM"

    info "Cloning zsh-autosuggestions"
    runCommand "git clone https://github.com/zsh-users/zsh-autosuggestions $AUTOSUGG_DIR" \
        "Failed to clone zsh-autosuggestions" \
        "zsh-autosuggestions installed"
fi

success "zsh plugins setup complete"
