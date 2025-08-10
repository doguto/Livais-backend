sudo yum -y update

# install dependencies
sudo yum -y install \
git make gcc-c++ patch curl \
openssl-devel \
libcurl-devel libyaml-devel libffi-devel libicu-devel \
libxml2 libxslt libxml2-devel libxslt-devel \
zlib-devel readline-devel \
mysql mysql-server mysql-devel \
ImageMagick ImageMagick-devel \
epel-release

# install Node.js
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
source ~/.nvm/nvm.sh
nvm install 22

# install yarn
curl -sL https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
sudo yum -y install yarn

# install rbenv
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(rbenv init -)"' >> ~/.bash_profile
source ~/.bash_profile

# install ruby
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
rbenv install -v 3.3.7
rbenv global 3.3.7
rbenv rehash

# setup GitHub
ssh-keygen -t rsa
# press Enter 3times here
cd ~/.ssh
cat id_rsa.pub
# copy SSH key and write in GitHub setting
ssh -T git@github.com
# enter "yes"


# setup Livais
cd /
sudo mkdir /var/www/
sudo chown ec2-user /var/www/
cd /var/www
git clone git@github.com:doguto/Livais-backend.git
cd Livais-backend/

# setup secret files
vim config/master.key
vim .env

# install gems
gem install bundler 2.5.22
bundle config set force_ruby_platform true
bundle install --without development test

# setup Database
rails db:create RAILS_ENV=production
rails db:migrate RAILS_ENV=production

# install Nginx
sudo amazon-linux-extras install nginx1
sudo systemctl start nginx
cd /etc/nginx/conf.d
sudo vi ***.conf  # paste nginx.conf
sudo nginx -t   # 設定チェック
sudo systemctl reload nginx
# 設定を変更したら直上2行を都度実行

# 以上で完了
RAILS_ENV=production rails s -b 0.0.0.0 -p 3000  # 実行して確認

# setup daemon service
sudo mkdir -p /etc/systemd/system/
cd /etc/systemd/system
sudo touch livais-api.service
sudo vim livais-api.service # paste livais-api.service
sudo systemctl daemon-reload
sudo systemctl enable livais-api
sudo systemctl start livais-api
