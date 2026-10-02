# Brewfile: everything this Mac needs, in one place.
#
#   brew bundle --file=~/workspace/source-code/personal/dotfiles/Brewfile   # install / upgrade
#   brew bundle check --file=...                                            # anything missing?
#   brew bundle cleanup --file=...                                          # list extras not in here
#
# Run by install/stack.sh after nvm + Node, so the npm entries below can install.
# Generated from `brew bundle dump` (2026-10-02), then grouped and reviewed.
# Keep it current: add new tools here instead of a bare `brew install`.

# ── Taps ─────────────────────────────────────────────────────────────────────
tap "go-swagger/go-swagger"
tap "localazy/tools"
tap "pinecone-io/tap"

# ── Shell & terminal ─────────────────────────────────────────────────────────
cask "kitty"
cask "font-jetbrains-mono-nerd-font"
brew "starship"           # prompt
brew "zsh-completions"
brew "bash-completion@2"
brew "bash-completion", link: false
brew "fzf"
brew "zoxide"             # smart cd
brew "tmux"               # ⚠ replaced by kitty; remove once you no longer need it as a fallback

# ── Modern CLI replacements ──────────────────────────────────────────────────
brew "bat"                # cat
brew "eza"                # ls
brew "fd"                 # find
brew "ripgrep"            # grep
brew "procs"              # ps
brew "duf"                # df
brew "btop"               # top
brew "htop"
brew "tree"
brew "tldr"
brew "hyperfine"          # benchmarking
brew "wget"
brew "inetutils"
brew "terminal-notifier"

# ── Data / JSON / YAML ───────────────────────────────────────────────────────
brew "jq"
brew "jd"                 # JSON diff
brew "dasel"              # query JSON/YAML/TOML/XML/CSV

# ── Git ──────────────────────────────────────────────────────────────────────
brew "git"
brew "git-delta"          # diff pager (themes in git/gitconfig.symlink)
brew "lazygit"
brew "gh"

# ── Editors & language servers ───────────────────────────────────────────────
brew "neovim"
brew "vim"
brew "lua-language-server"
brew "stylua"

# ── Languages & version managers ─────────────────────────────────────────────
# Node comes from nvm (installed by install/stack.sh), not Homebrew.
brew "pyenv"
brew "python@3.9", link: false
brew "pipx"
brew "uv"
brew "openjdk"
brew "tfenv"              # provides terraform

# ── Cloud, containers & APIs ─────────────────────────────────────────────────
brew "docker"
brew "go-swagger/go-swagger/go-swagger"
brew "localazy/tools/localazy"
brew "pinecone-io/tap/pinecone"
cask "ngrok"
# kubectl and the AWS CLI are installed from their official .pkg installers in
# /usr/local/bin. To manage them with Homebrew instead, uncomment and remove
# the .pkg versions (otherwise you'd have two copies on PATH):
# brew "kubernetes-cli"
# brew "awscli"

# ── Databases & services ─────────────────────────────────────────────────────
brew "libpq"              # psql client (PATH set in zprofile)
brew "redis"
brew "kafka"
brew "zookeeper"
brew "nginx"
cask "pgadmin4"

# ── Libraries ────────────────────────────────────────────────────────────────
# Installed on request at some point; possibly only needed by other tools.
brew "glib"
brew "harfbuzz"
brew "libmagic"
brew "poppler"

# ── Desktop apps ─────────────────────────────────────────────────────────────
cask "hammerspoon"
cask "macgesture"
cask "warp"               # ⚠ another terminal; remove if kitty has replaced it

# ── Global npm packages (need Node from nvm) ─────────────────────────────────
npm "@angular/cli"
npm "corepack"
npm "prettier"
npm "pyright"
npm "typescript"
npm "typescript-language-server"
npm "vscode-langservers-extracted"
npm "vercel"

# ── VS Code extensions (installed when the `code` CLI is available) ──────────
vscode "anthropic.claude-code"
vscode "docker.docker"
vscode "eamodio.gitlens"
vscode "hashicorp.terraform"
vscode "mechatroner.rainbow-csv"
vscode "mhutchie.git-graph"
vscode "ms-azuretools.vscode-containers"
vscode "ms-azuretools.vscode-docker"
vscode "ms-python.debugpy"
vscode "ms-python.python"
vscode "ms-python.vscode-pylance"
vscode "ms-python.vscode-python-envs"
vscode "ms-toolsai.jupyter"
vscode "ms-toolsai.jupyter-keymap"
vscode "ms-toolsai.jupyter-renderers"
vscode "ms-toolsai.vscode-jupyter-cell-tags"
vscode "ms-toolsai.vscode-jupyter-slideshow"
vscode "ms-vscode-remote.remote-containers"
vscode "nrwl.angular-console"
vscode "vscodevim.vim"
