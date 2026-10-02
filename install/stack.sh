#!/bin/bash
# Installs the development stack:
#   1. Homebrew
#   2. mise + the Node/Python versions in mise/config.toml.symlink (Node is
#      needed before the Brewfile's npm entries)
#   3. Everything in ../Brewfile: CLI tools, apps, fonts, npm globals, VS Code
#      extensions. Add new tools to the Brewfile, not here.
# Sourced by install.sh from the repo root.

DOTFILES_DIR="${DOTFILES_DIR:-$(pwd)}"

h2 "Homebrew"
if ! typeExists brew; then
  info "Installing Homebrew (may ask for your password)"
  # Run directly, not via runCommand: the installer is interactive
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" \
    || { error "Homebrew installation failed"; exit 1; }
fi
eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || brew shellenv)"
success "$(brew --version | head -1)"

h2 "mise + Node/Python"
# mise replaced nvm + pyenv. The config is linked into ~/.config later
# (install/link.sh), so point mise at the repo copy for this first install.
export MISE_GLOBAL_CONFIG_FILE="$DOTFILES_DIR/mise/config.toml.symlink"
if ! typeExists mise; then
  runCommand "brew install mise" "Failed to install mise" "mise installed"
fi
runCommand "mise install" "Failed to install Node/Python with mise" "Node + Python installed"
# Put those versions on PATH for the rest of this script (brew bundle's npm entries)
MISE_PATHS=$(mise bin-paths | tr '\n' ':')
export PATH="$MISE_PATHS$PATH"
success "node $(node -v), npm $(npm -v), $(python3 --version)"

h2 "Brewfile packages"
# Third-party taps (go-swagger, localazy, pinecone) must be trusted before
# Homebrew loads them. If this step stops with "untrusted tap", review and run:
#   brew trust go-swagger/go-swagger localazy/tools pinecone-io/tap
info "brew bundle --file=$DOTFILES_DIR/Brewfile (this can take a while)"
# Run directly so progress and any password prompts (casks) are visible
brew bundle --file="$DOTFILES_DIR/Brewfile" \
  || { error "brew bundle failed. Fix the error above, then re-run: brew bundle --file=$DOTFILES_DIR/Brewfile"; exit 1; }
success "Brewfile packages installed"

h2 "pre-commit"
# Via uv on mise's Python (see Brewfile note on Homebrew's python@3.14)
if ! typeExists pre-commit; then
  runCommand "uv tool install pre-commit --python \"$(mise which python3)\"" \
    "Failed to install pre-commit" "pre-commit installed"
fi
# GIT_CONFIG_GLOBAL=/dev/null: pre-commit refuses to install while the global
# core.hooksPath (our hook dispatcher) is set; the dispatcher runs it anyway
runCommand "GIT_CONFIG_GLOBAL=/dev/null pre-commit install" "Failed to install this repo's pre-commit hooks" "pre-commit hooks installed for dotfiles"
