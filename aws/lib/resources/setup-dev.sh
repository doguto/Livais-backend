#!/bin/bash

yum -y update

# install dependencies
yum -y install \
git make gcc-c++ patch curl openssl-devel \
libcurl-devel libyaml-devel libffi-devel libicu-devel \
libxml2 libxslt libxml2-devel libxslt-devel \
zlib-devel readline-devel mysql mysql-server mysql-devel \
mysql mysql-server mysql-devel epel-release

# install nodejs
curl -sL https://rpm.nodesource.com/setup_14.x | bash
yum install -y nodejs
if which node > /dev/null 2>&1; then
    echo "Succeeded in installing Node.js."
else
    echo "Failed to install Node.js."
    exit 1
fi

# install yarn
curl -sL https://dl.yarnpkg.com/rpm/yarn.repo | tee /etc/yum.repos.d/yarn.repo
yum -y install yarn

# install rbenv
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
source ~/.bash_profile

# install ruby
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
rbenv install -v 3.3.7
rbenv global 3.3.7
ebenv rehash
if ruby -v > /dev/null 2>&1; then
    echo "Succeeded in installing Ruby."
    ruby -v
else
    echo "Failed to install Ruby."
    exit 1
fi

# install Nginx
amazon-linux-extras install nginx1
