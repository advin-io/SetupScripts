#!/usr/bin/env bash

# Variables
INSTALL_LOC="/usr/local/bin"

# Prereqs
sudo apt -y install gcc unzip
mkdir $HOME/Datasets $HOME/Models

# Install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/home/ubuntu/.linuxbrew/bin/brew shellenv)"' >> /home/ubuntu/.profile
eval "$(/home/ubuntu/.linuxbrew/bin/brew shellenv)"
sudo apt update && sudo apt -y upgrade
sudo apt -y install gcc

# Install github
brew install gh
gh auth login
mkdir $HOME/github/

# Install docker
# curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
rm get-docker.sh

sudo usermod -aG docker $USER
. $HOME/.bashrc

# Install docker compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo curl \
    -L https://raw.githubusercontent.com/docker/compose/1.29.1/contrib/completion/bash/docker-compose \
    -o /etc/bash_completion.d/docker-compose
. $HOME/.bashrc
sudo apt update

# Download NGC CLI
wget -O ngccli_cat_linux.zip https://ngc.nvidia.com/downloads/ngccli_cat_linux.zip
sudo unzip -d /usr/local/bin ngccli_cat_linux.zip && sudo chmod u+x /usr/local/bin/ngc
rm ngccli_cat_linux.zip
ngc config set
