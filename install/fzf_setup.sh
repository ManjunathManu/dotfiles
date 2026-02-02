#!/bin/bash
source utils.sh

h2 "Installing fzf (fuzzy finder)"

if typeExists fzf; then
    success "fzf already installed"
else
    info "Installing fzf via Homebrew"
    runCommand "brew install fzf" "Failed to install fzf" "fzf installed"

    # Run fzf install script for shell integration
    info "Setting up fzf shell integration"
    runCommand "$(brew --prefix)/opt/fzf/install --key-bindings --completion --no-update-rc" \
        "Failed to setup fzf integration" \
        "fzf shell integration configured"
fi

# Setup command palette and workflows
h2 "Setting up command palette and workflows"

# Create ~/.fzf directory if it doesn't exist
if [[ ! -d "${HOME}/.fzf" ]]; then
    info "Creating ~/.fzf directory"
    mkdir -p "${HOME}/.fzf"
fi

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DOTFILES_DIR="$( cd "$SCRIPT_DIR/.." && pwd )"

# Copy command palette script
info "Installing command palette script"
cp "${DOTFILES_DIR}/fzf/command-palette.sh" "${HOME}/.fzf/command-palette.sh"
chmod +x "${HOME}/.fzf/command-palette.sh"

# Copy workflows file
info "Installing workflows file"
cp "${DOTFILES_DIR}/fzf/workflows.txt" "${HOME}/.fzf/workflows.txt"

success "Command palette and workflows installed"
success "fzf setup complete"
