#!/bin/bash
if [ "$(whoami)" != "app" ]; then
  echo "Script must be run as user: app. Run create-deploy-user.sh first to create user app"
  exit 255
fi

# Essentials
sudo apt-get update
sudo apt-get -y install unzip software-properties-common apt-transport-https autoconf bison build-essential libssl-dev libyaml-dev libreadline-dev zlib1g-dev libncurses5-dev libffi-dev libgdbm-dev nginx nginx-extras nginx-common

# Nodejs
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source ~/.bashrc
nvm install 16.15.1
nvm use 16.15.1
npm install -g pm2 yarn

# MongoDB V6.0
wget -qO - https://www.mongodb.org/static/pgp/server-6.0.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/6.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list
sudo apt-get update
sudo apt-get install -y mongodb-org
echo "mongodb-org hold" | sudo dpkg --set-selections
echo "mongodb-org-database hold" | sudo dpkg --set-selections
echo "mongodb-org-server hold" | sudo dpkg --set-selections
echo "mongodb-mongosh hold" | sudo dpkg --set-selections
echo "mongodb-org-mongos hold" | sudo dpkg --set-selections
echo "mongodb-org-tools hold" | sudo dpkg --set-selections

# wkhtmltopdf
wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6-1/wkhtmltox_0.12.6-1.focal_amd64.deb
sudo apt -y install ./wkhtmltox_0.12.6-1.focal_amd64.deb

wget https://github.com/GlifeRnD/GlifeDeploymentScripts/raw/master/fonts/pingfang.zip
mkdir -p ~/.local/share/fonts
unzip ./pingfang.zip -d ~/.local/share/fonts

# Redis
sudo apt-get install -y redis-server
redis-cli ping