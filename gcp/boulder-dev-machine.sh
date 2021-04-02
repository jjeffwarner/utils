#!/bin/sh

# Get the latest package list
sudo apt update

# Do the updates
sudo apt-get update

# install wget
sudo apt install -y software-properties-common apt-transport-https wget

# Download the Debian Linux Chrome Remote Desktop installation package:
wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb

# Install the package and its dependencies:
sudo dpkg --install chrome-remote-desktop_current_amd64.deb
sudo apt install -y --fix-broken

# Cleanup remove the unnecessary file after the installation is done:
rm chrome-remote-desktop_current_amd64.deb

# install xcfe
sudo DEBIAN_FRONTEND=noninteractive \
    apt install -y xfce4 xfce4-goodies desktop-base

# Configure Chrome Remote Desktop to use Xfce by default:
sudo bash -c 'echo "exec /etc/X11/Xsession /usr/bin/xfce4-session" > /etc/chrome-remote-desktop-session'

# Xfce's default screen locker is Light Locker, which doesn't work with Chrome Remote Desktop. 
# install XScreenSaver as an alternative:
sudo apt install -y xscreensaver

# Install Firefox browser
sudo apt -y install firefox

# Install Chrome browser
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg --install google-chrome-stable_current_amd64.deb
sudo apt install -y --fix-broken

# Cleanup remove the unnecessary file after the installation is done:
rm google-chrome-stable_current_amd64.deb

# Disable the display manager service:
# There is no display connected to the VM --> the display manager service won't start.
sudo systemctl disable lightdm.service

# Install the Google Cloud SDK
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

sudo apt-get install apt-transport-https ca-certificates gnupg

curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -

sudo apt-get update 
sudo apt-get install -y google-cloud-sdk

# END Install the Google Cloud SDK

# Install Visual Studio Code
sudo snap install --classic code

# we need curl
sudo apt-get install -y curl

# Setup for boulder
# need Ruby version 2.5
# sudo apt-get install -y ruby-full
# using rvm instead after the machine is setup with version 2.5.7
# https://vitux.com/installing-and-configuring-ruby-on-rails-on-debian-10/

# Setup node
# sudo apt-get install -y nodejs npm       # This command generated version 8
curl -sL https://deb.nodesource.com/setup_14.x | sudo bash -
sudo apt-get install -y nodejs npm 

# Setup yarn
#sudo apt-get install -y yarn               # this generated an old version as well
npm install -g yarn 

# setup Redis
# check status with sudo systemctl status redis-server
sudo apt-get install -y redis-server

# setup Postgres
# current version is 10
sudo apt-get install -y postgresql postgresql-contrib libpq-dev 
# sudo -u postgres psql -c "SELECT version();"
# sudo systemctl status postgresql
sudo mkdir -p /usr/local/var/pgsql/data
# doesn't look like my user is setup yet so this doesn't work.
# sudo chown jeff_warner /usr/local/var/pgsql/data

##
## Setup
##
# export PATH="/usr/lib/postgresql/10/bin:$PATH"
# echo 'export PATH="/usr/lib/postgresql/10/bin:$PATH"' >> ~/.bash_profile
# initdb -D /usr/local/var/pgsql/data
# sudo chown jeff_warner /var/run/postgresql
# pg_ctl -D /usr/local/var/pgsql/data -l logfile start
# createuser -s postgres

# add user to the postgres group so we can use the pg_ctl command
# sudo usermod -a -G postgres $USER

# setup ElasticSearch + Java
# start service takes around 20 seconds :( 
sudo apt-get install -y default-jdk
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
sudo sh -c 'echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" > /etc/apt/sources.list.d/elastic-7.x.list'
sudo apt-get update
sudo apt-get install -y elasticsearch
sudo systemctl enable elasticsearch.service --now

# verify that elasticsearch is running with curl -X GET "localhost:9200/" via ssh



###
# Testing stuff via ssh
# I had to delete lock files for apt-get https://itsfoss.com/could-not-get-lock-error/
#
###