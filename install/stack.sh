#!/bin/bash

# Sourcing this since nvm command is a shell function declared in ~/.nvm/nvm.sh.
source $NVM_DIR/nvm.sh

h2 "Quickly configure your development environment by installing required packages";

info "Refreshing local package index";
# brew update

installNvm() {
  h2 "Installing prerequisite packages for NVM"
  # runCommand "brew install  build-essential libssl-dev"
  runCommand "curl -sL https://raw.githubusercontent.com/creationix/nvm/v0.20.0/install.sh -o install_nvm.sh";
  runCommand "bash install_nvm.sh"
}

installDocker() {
  # Install a few prerequisite packages which let brew use packages over HTTPS:
  runCommand "brew install  brew-transport-https ca-certificates curl software-properties-common"
  # Add the GPG key for the official Docker repository to your system
  runCommand "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | brew-key add -"
  # Add the Docker repository to brew sources
  runCommand "sudo add-brew-repository \"deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable\""
  # Update the package database with the Docker packages from the newly added repo
  runCommand "brew update"
  # Make sure you are about to install from the Docker repo instead of the default Ubuntu repo:
  runCommand "brew-cache policy docker-ce"
  # Finally, install Docker
  runCommand "brew install  docker-ce"
}

installAwsCli() {
	if ! typeExists "pip"; then
		h2 "Installing Python PIP"
		# runCommand "brew install  python3-pip"
    runCommand "curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py"
    runCommand "python3 get-pip.py"
		success "Installing PIP (`pip --version`) succeeded"
	fi

	h2 "Installing AWS CLI"
	runCommand "sudo pip3 install awscli"
}

installPython() {
  # Add the deadsnakes PPA to your sources list
  # runCommand "sudo add-brew-repository ppa:deadsnakes/ppa"
  runCommand "brew install python@3.9"
}

installNginx() {
  runCommand "brew install nginx"
  # runCommand "sudo ufw allow \'Nginx HTTP\'"
  runCommand "sudo nginx -g \"daemon off\""
}

# Install NVM
if [ ! -d "$NVM_DIR" ] ; then
  installNvm
  success "Installing Node Version Manager(NVM) $(nvm --version) succeeded"
else
  success "nvm is already installed"
fi

# Install Angular CLI
if ! typeExists "ng"; then
  runCommand "npm install -g @angular/cli"
  success "Installing ng cli succeeded"
else
  success "Angular cli(ng) is already installed"
fi

# Install Docker
if ! typeExists "docker"; then
  # installDocker
  success "Installing docker successfully"
else
  success "Docker is alreay installed"
fi

# Install AWS CLI
if ! typeExists "aws"; then
  installAwsCli
  success "Installing AWS CLI $(aws --version 2>&1) succeeded"
else
  AWS_FULL_VER=$(aws --version 2>&1)
  AWS_VER=$(echo $AWS_FULL_VER | sed -e 's/aws-cli\///' | sed -e 's/ Python.*//')
  vercomp $AWS_VER "1.9.8"
  if [[ $? == 2 ]]; then
    h2 "Installing updated AWS CLI version ($AWS_VER < 1.9.8)"
    installAwsCli
  fi
  success "aws cli is already its latest version"
fi

# Install tmux
if ! typeExists "tmux"; then
  runCommand "brew install tmux"
  success "tmux installed successfully"
else
  success "tmux is already installed"
fi

# Install python
if ! typeExists "python"; then
  installPython
  success "Python installed successfully"
else
  success "Python is already installed"
fi

# Install vim
if ! typeExists "vim"; then
  runCommand "brew install vim"
  success "vim installed successfully"
else
  success "vim is already installed"
fi

if ! typeExists "nginx"; then
  installNginx
  success "Nginx installed successfully"
else
  success "Nginx is already installed"
fi

# ============================================
# MODERN CLI TOOLS INSTALLATION
# ============================================

# Install Starship (modern prompt)
h2 "Installing Starship prompt"
if typeExists starship; then
    success "starship already installed"
else
    runCommand "brew install starship" "Failed to install starship" "starship installed successfully"
fi

# Install fd (faster alternative to find)
h2 "Installing fd (find alternative)"
if typeExists fd; then
    success "fd already installed"
else
    runCommand "brew install fd" "Failed to install fd" "fd installed successfully"
fi

# Install bat (better cat with syntax highlighting)
h2 "Installing bat (cat alternative)"
if typeExists bat; then
    success "bat already installed"
else
    runCommand "brew install bat" "Failed to install bat" "bat installed successfully"
fi

# Install eza (modern ls replacement)
h2 "Installing eza (ls alternative)"
if typeExists eza; then
    success "eza already installed"
else
    runCommand "brew install eza" "Failed to install eza" "eza installed successfully"
fi

# Install ripgrep (faster grep)
h2 "Installing ripgrep (grep alternative)"
if typeExists rg; then
    success "ripgrep already installed"
else
    runCommand "brew install ripgrep" "Failed to install ripgrep" "ripgrep installed successfully"
fi

# Install delta (better git diffs)
h2 "Installing delta (git diff tool)"
if typeExists delta; then
    success "delta already installed"
else
    runCommand "brew install git-delta" "Failed to install delta" "delta installed successfully"
fi

# Install zoxide (smart cd)
h2 "Installing zoxide (smart cd)"
if typeExists zoxide; then
    success "zoxide already installed"
else
    runCommand "brew install zoxide" "Failed to install zoxide" "zoxide installed successfully"
fi

# Install lazygit (terminal UI for git)
h2 "Installing lazygit"
if typeExists lazygit; then
    success "lazygit already installed"
else
    runCommand "brew install lazygit" "Failed to install lazygit" "lazygit installed successfully"
fi

# Install btop (better top)
h2 "Installing btop (system monitor)"
if typeExists btop; then
    success "btop already installed"
else
    runCommand "brew install btop" "Failed to install btop" "btop installed successfully"
fi

# Install duf (better df)
h2 "Installing duf (disk usage tool)"
if typeExists duf; then
    success "duf already installed"
else
    runCommand "brew install duf" "Failed to install duf" "duf installed successfully"
fi

# Install procs (better ps)
h2 "Installing procs (process viewer)"
if typeExists procs; then
    success "procs already installed"
else
    runCommand "brew install procs" "Failed to install procs" "procs installed successfully"
fi

# Install tldr (simplified man pages)
h2 "Installing tldr (man page alternative)"
if typeExists tldr; then
    success "tldr already installed"
else
    runCommand "brew install tldr" "Failed to install tldr" "tldr installed successfully"
fi

# Install hyperfine (benchmarking tool)
h2 "Installing hyperfine (benchmarking tool)"
if typeExists hyperfine; then
    success "hyperfine already installed"
else
    runCommand "brew install hyperfine" "Failed to install hyperfine" "hyperfine installed successfully"
fi

# Install fzf (fuzzy finder) - likely already installed but ensure it's there
h2 "Installing fzf (fuzzy finder)"
if typeExists fzf; then
    success "fzf already installed"
else
    runCommand "brew install fzf" "Failed to install fzf" "fzf installed successfully"
    # Install fzf key bindings and fuzzy completion
    runCommand "$(brew --prefix)/opt/fzf/install --all" "Failed to install fzf bindings" "fzf bindings installed successfully"
fi
