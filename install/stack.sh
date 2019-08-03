#!/bin/bash

# Sourcing this since nvm command is a shell function declared in ~/.nvm/nvm.sh.
source $NVM_DIR/nvm.sh

h2 "Quickly configure your development environment by installing required packages";

info "Refreshing local package index";
sudo apt-get update

installNvm() {
  h2 "Installing prerequisite packages for NVM"
  runCommand "sudo apt-get install build-essential libssl-dev"
  runCommand "url -sL https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh -o install_nvm.sh";
  runCommand "bash install_nvm.sh"
}

installDocker() {
  # Install a few prerequisite packages which let apt use packages over HTTPS:
  runCommand "sudo apt install apt-transport-https ca-certificates curl software-properties-common"
  # Add the GPG key for the official Docker repository to your system
  runCommand "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -"
  # Add the Docker repository to APT sources
  runCommand "sudo add-apt-repository \"deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable\""
  # Update the package database with the Docker packages from the newly added repo
  runCommand "sudo apt update"
  # Make sure you are about to install from the Docker repo instead of the default Ubuntu repo:
  runCommand "apt-cache policy docker-ce"
  # Finally, install Docker
  runCommand "sudo apt install docker-ce"
}

installAwsCli() {
	if ! typeExists "pip"; then
		h2 "Installing Python PIP"
		runCommand "sudo apt-get install -y python-pip"
		success "Installing PIP (`pip --version`) succeeded"
	fi

	h2 "Installing AWS CLI"
	runCommand "sudo pip install awscli"
}

installPython() {
  # Add the deadsnakes PPA to your sources list
  runCommand "sudo add-apt-repository ppa:deadsnakes/ppa"
  runCommand "sudo apt install python3.7"
}

installNginx() {
  runCommand "sudo apt install nginx"
  runCommand "sudo ufw allow \'Nginx HTTP\'"
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
  runCommand "sudo npm install -g @angular/cli"
  success "Installing ng cli succeeded"
else
  success "Angular cli(ng) is already installed"
fi

# Install Docker
if ! typeExists "docker"; then
  installDocker
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
if ! typeExists "aws"; then
  runCommand "sudo apt-get install tmux"
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
  runCommand "sudo apt-get install vim"
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
