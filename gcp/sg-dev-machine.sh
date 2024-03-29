#!/bin/sh

# Get the latest package list
sudo apt update

# Do the updates
sudo apt-get update

# install wget
sudo apt install -y software-properties-common apt-transport-https wget

# Download the Debian Linux Chrome Remote Desktop installation package:
# wget https://dl.google.com/linux/direct/chrome-remote-desktop_current_amd64.deb

# Install the package and its dependencies:
# sudo dpkg --install chrome-remote-desktop_current_amd64.deb
# sudo apt install -y --fix-broken

# Cleanup remove the unnecessary file after the installation is done:
# rm chrome-remote-desktop_current_amd64.deb

# install xcfe
# sudo DEBIAN_FRONTEND=noninteractive \
#     apt install -y xfce4 xfce4-goodies desktop-base

# Configure Chrome Remote Desktop to use Xfce by default:
# sudo bash -c 'echo "exec /etc/X11/Xsession /usr/bin/xfce4-session" > /etc/chrome-remote-desktop-session'

# Xfce's default screen locker is Light Locker, which doesn't work with Chrome Remote Desktop. 
# install XScreenSaver as an alternative:
# sudo apt install -y xscreensaver

# Install Firefox browser
# sudo apt -y install firefox

# Install Chrome browser
# wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
# sudo dpkg --install google-chrome-stable_current_amd64.deb
# sudo apt install -y --fix-broken

# Cleanup remove the unnecessary file after the installation is done:
# rm google-chrome-stable_current_amd64.deb

# Disable the display manager service:
# There is no display connected to the VM --> the display manager service won't start.
# sudo systemctl disable lightdm.service

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


# Setup node
# sudo apt-get install -y nodejs npm       # This command generated version 8
# curl -sL https://deb.nodesource.com/setup_14.x | sudo bash -
# sudo apt-get install -y nodejs npm 

# Setup yarn
# npm install -g yarn 

# setup Redis
# check status with sudo systemctl status redis-server
# sudo apt-get install -y redis-server

# setup mime info
# sudo apt-get install shared-mime-info

# setup Postgres
# current version is 10
# sudo apt-get install -y postgresql postgresql-contrib libpq-dev 
# sudo -u postgres psql -c "SELECT version();"
# sudo systemctl status postgresql
# sudo systemctl stop postgresql
# sudo systemctl disable postgresql
# sudo mkdir -p /usr/local/var/pgsql/data
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


# clean up
sudo apt autoremove


###
# Testing stuff via ssh
# I had to delete lock files for apt-get https://itsfoss.com/could-not-get-lock-error/
#
###