#! /bin/bash

# Finish setup for Postgresql
 sudo chown jeff_warner /usr/local/var/pgsql/data

##
## Setup
##
export PATH="/usr/lib/postgresql/10/bin:$PATH"
echo 'export PATH="/usr/lib/postgresql/10/bin:$PATH"' >> ~/.bash_profile
initdb -D /usr/local/var/pgsql/data
sudo chown jeff_warner /var/run/postgresql
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

source /home/jeff_warner/.rvm/scripts/rvm

rvm install ruby-2.5.7
rvm use 2.5.7 --default

# Rails setup
#gem install rails -v 5.2.4.5
gem install rails -v 5.2.3
gem install bundler


# setup gems
# sudo chown jeff_warner /var/lib/gems/2.5.0
# sudo chgrp jeff_warner /var/lib/gems/2.5.0
# sudo chown jeff_warner /var/lib/bin
# gem install bundler
