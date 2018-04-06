#!/bin/bash
# Install ruby package
sudo apt update
sudo apt install -y ruby-full ruby-bundler build-essential

# Add mongodb repo 
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
sudo bash -c 'echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.2.list'

# Install mongodb 
sudo apt update
sudo apt install -y mongodb-org

# Start mongod
sudo systemctl start mongod
sudo systemctl enable mongod

# Install app
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
puma -d
