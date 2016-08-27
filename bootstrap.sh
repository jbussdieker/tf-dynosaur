#!/bin/bash

# Setup the dyno user
useradd dyno --create-home
mkdir /home/dyno/.ssh
chown dyno:dyno /home/dyno/.ssh
chmod 0700 /home/dyno/.ssh
echo -n 'command="echo '\n------> This Dynosaur is still booting. Please try again.\n' 1>&2",no-port-forwarding,no-X11-forwarding,no-agent-forwarding,no-pty ' > /home/dyno/.ssh/authorized_keys
cat /home/ubuntu/.ssh/authorized_keys >> /home/dyno/.ssh/authorized_keys

mkdir /home/dyno/slugs
chown dyno:dyno /home/dyno/slugs

# Install dynosaur
apt-get -y update
apt-get -y install git ruby build-essential libpq-dev
apt-get -y install libxml2-dev libxslt-dev
gem install bundler --no-ri --no-rdoc
gem install foreman --no-ri --no-rdoc --version 0.74.0
git clone https://github.com/jbussdieker/dynosaur.git /tmp/dynosaur
cd /tmp/dynosaur
bundle
bundle exec rake install

mkdir /home/dyno/buildpacks
cd /home/dyno/buildpacks
git clone https://github.com/heroku/heroku-buildpack-ruby.git
git clone https://github.com/heroku/heroku-buildpack-nodejs.git
git clone https://github.com/heroku/heroku-buildpack-closure.git
git clone https://github.com/heroku/heroku-buildpack-python.git
git clone https://github.com/heroku/heroku-buildpack-java.git
git clone https://github.com/heroku/heroku-buildpack-gradle.git
git clone https://github.com/heroku/heroku-buildpack-grails.git
git clone https://github.com/heroku/heroku-buildpack-scala.git
git clone https://github.com/heroku/heroku-buildpack-play.git
git clone https://github.com/heroku/heroku-buildpack-php.git
git clone https://github.com/heroku/heroku-buildpack-go.git

mkdir /app
chown dyno:dyno /app

echo -n 'command="/usr/local/bin/shell",no-port-forwarding,no-X11-forwarding,no-agent-forwarding,no-pty ' > /home/dyno/.ssh/authorized_keys
cat /home/ubuntu/.ssh/authorized_keys >> /home/dyno/.ssh/authorized_keys
