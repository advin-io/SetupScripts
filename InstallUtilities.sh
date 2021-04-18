#!/usr/bin/env bash

# Prereqs
sudo apt update && sudo apt -y upgrade
sudo apt -y install gcc unzip
# Add favorite folders
mkdir $HOME/Datasets $HOME/Models $HOME/github 

# Install brew
if [ $(which brew) -eq 0 ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/home/ubuntu/.linuxbrew/bin/brew shellenv)"' >> /home/ubuntu/.profile
    eval "$(/home/ubuntu/.linuxbrew/bin/brew shellenv)"
    sudo apt update
fi

# Install github
if [ $(which gh) -eq 0 ]; then
    brew install gh
    gh auth login
fi

# Install docker
if [ $(which docker) -eq 0 ]; then
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    rm get-docker.sh
    sudo usermod -aG docker $USER
    . $HOME/.bashrc

# Install docker compose
if [ $(which docker-compose) -eq 0 ]; then
    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    sudo curl \
        -L https://raw.githubusercontent.com/docker/compose/1.29.1/contrib/completion/bash/docker-compose \
        -o /etc/bash_completion.d/docker-compose
    . $HOME/.bashrc
    sudo apt update
fi

# Download NGC CLI
if [ $(which ngc) -eq 0 ]; then
    wget -O ngccli_cat_linux.zip https://ngc.nvidia.com/downloads/ngccli_cat_linux.zip
    sudo unzip -d /usr/local/bin ngccli_cat_linux.zip && sudo chmod u+x /usr/local/bin/ngc
    rm ngccli_cat_linux.zip
    ngc config set
fi
