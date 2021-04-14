#! /bin/bash



##
## Setup
##
# @todo: how to just use the installed setup and skip the inidb stuff.
# Finish setup for Postgresql
#
user = `whoami`
sudo chown $user /usr/local/var/pgsql/data
export PATH="/usr/lib/postgresql/10/bin:$PATH"
echo 'export PATH="/usr/lib/postgresql/10/bin:$PATH"' >> ~/.bash_profile
initdb -D /usr/local/var/pgsql/data
sudo chown $user /var/run/postgresql
pg_ctl -D /usr/local/var/pgsql/data -l logfile start
createuser -s postgres

# make sure elasticsearch is running via terminal
curl -X GET "localhost:9200/"


##
# Ruby and Rails setup
##
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 \
7D2BAF1CF37B13E2069D6956105BD0E739499BDB

curl -sSL https://get.rvm.io | bash -s stable --ruby

source /home/$user/.rvm/scripts/rvm

rvm install ruby-2.7.3
rvm use 2.7.3 --default

# Rails setup
cd boulder
gem install rails -v 5.2.3
gem install bundler
bundle

# setup React stuff
yarn install

# setup gems
# sudo chown jeff_warner /var/lib/gems/2.5.0
# sudo chgrp jeff_warner /var/lib/gems/2.5.0
# sudo chown jeff_warner /var/lib/bin
# gem install bundler


# @TODO: Hmm, after running X I lost the CLICOLORS in ssh
