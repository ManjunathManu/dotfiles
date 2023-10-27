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
